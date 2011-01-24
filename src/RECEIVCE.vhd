-- Funktionsbeschreibung:

-- Die E_Receive Entity hoert die RX-Datenleitung ab. Wenn ein Datenbyte anliegt wird das Busy-Flag
-- bis zum naechsten Startbit auf Null gezogen. Waehrend dieser Zeit muss die die darueberliegende Entity
-- den Datenwert ausgelesen haben. Die RX-Leitung wird pro Bit 5 mal abgetastet. Das Partiybit wird an die 
-- hoehere Ebene weitergegeben.

-- Pinbeschreibung

	-- Eingaenge:
		-- E_RECEIVE_Reset						Reset (active low)
		-- E_RECEIVE_Clock_In					Takt
		-- E_RECEIVE_Baudrate_5x				fuenffache Baudrate der Kommunikationsfrequenz
		-- E_RECEIVE_Data_Serial_In:			Anschluss der RX-Leitung


	-- Ausgaenge:
		-- E_RECEIVE_Paritybit:					empfangenes Paritybit	
		-- E_RECEIVE_Data_Parallel_Out:		Datenbyte das empfangen wurde
		-- E_RECEIVE_Busy:						Busy-Flag bestimmt ob Daten anliegen (0 = valid)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity E_RECEIVE is
Port (
		E_RECEIVE_Reset: 				 		IN  STD_LOGIC;
		E_RECEIVE_Clock_In:					IN  STD_LOGIC;		
		E_RECEIVE_Baudrate_5x:  			IN  STD_LOGIC;	
		E_RECEIVE_Paritybit:					OUT STD_LOGIC;	
		E_RECEIVE_Data_Parallel_Out:		OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RECEIVE_Data_Serial_In:			IN  STD_LOGIC;
		E_RECEIVE_Busy:						OUT  STD_LOGIC
);
end E_RECEIVE;

architecture A_RECEIVE of E_RECEIVE is

SIGNAL S_RECEIVE_Reset: 				 		STD_LOGIC;
SIGNAL S_RECEIVE_Clock_In:					STD_LOGIC;		
SIGNAL S_RECEIVE_Baudrate_5x:  				STD_LOGIC;	
SIGNAL S_RECEIVE_Paritybit:					STD_LOGIC;	
SIGNAL S_RECEIVE_Data_Parallel_Out:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_RECEIVE_Data_Serial_In:	STD_LOGIC;	
SIGNAL S_RECEIVE_Busy:					STD_LOGIC;	

SIGNAL S_State:					STD_LOGIC_VECTOR(3 DOWNTO 0); -- 8 bit
SIGNAL S_Counter:					STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 bit

SIGNAL S_DECISION_Value1:			STD_LOGIC;	
SIGNAL S_DECISION_Value2:			STD_LOGIC;	
SIGNAL S_DECISION_Value3:			STD_LOGIC;	
SIGNAL S_DECISION_Result:			STD_LOGIC;	

SIGNAL S_Save_Bit:					STD_LOGIC;
SIGNAL S_Save_Ready:					STD_LOGIC;
SIGNAL S_Enable_Receive:			STD_LOGIC;

component E_DECISION
    Port ( 
			E_DECISION_Value1 : 				IN  STD_LOGIC;
         E_DECISION_Value2 : 				IN  STD_LOGIC;
         E_DECISION_Value3 : 				IN  STD_LOGIC;
         E_DECISION_Result : 				OUT  STD_LOGIC
			);
end component;

begin

C_DECISION: E_DECISION
    PORT MAP ( 
			E_DECISION_Value1 => S_DECISION_Value1,
         E_DECISION_Value2 => S_DECISION_Value2,
         E_DECISION_Value3 => S_DECISION_Value3,
         E_DECISION_Result  => S_DECISION_Result
			);


	Save_Byte : process (
		S_RECEIVE_Reset,
		S_RECEIVE_Clock_In
	)
	begin
			-- Resetfall
			IF(S_RECEIVE_Reset = '0')
			THEN
				S_RECEIVE_Data_Parallel_Out <= "00000000";
				S_RECEIVE_Busy <= '1';	
				S_State <= "0000";	
				S_RECEIVE_Paritybit <= '0';
				S_Enable_Receive <= '0';
			--	Main Loop wird bei jedem Taktereignis aufgerufen					
			ELSIF (S_RECEIVE_Clock_In = '1' AND S_RECEIVE_Clock_In'EVENT)
			THEN
			
				-- warten auf Startbit
				IF (S_State = "0000"  AND S_RECEIVE_Data_Serial_In = '0')
				THEN
					S_RECEIVE_Busy <= '1';
					S_Enable_Receive <= '1';
					S_State <= "0001";
				
				-- Wenn Datenbit eingelesen wurde
				ELSIF (S_Save_Ready = '1')
				THEN
					
					-- Startbit 
					IF (S_State = "0001")
					THEN
						S_State <= "0010";
						S_RECEIVE_Busy <= '1';
				
					-- Bit 0
					ELSIF (S_State = "0010")
					THEN
						S_State <= "0011";
						S_RECEIVE_Data_Parallel_Out(0) <= S_Save_Bit;
					
					-- Bit 1
					ELSIF (S_State = "0011")
					THEN
						S_State <= "0100";
						S_RECEIVE_Data_Parallel_Out(1) <= S_Save_Bit;

					-- Bit 2
					ELSIF (S_State = "0100")
					THEN
						S_State <= "0101";
						S_RECEIVE_Data_Parallel_Out(2) <= S_Save_Bit;

					-- Bit 3
					ELSIF (S_State = "0101")
					THEN
						S_State <= "0110";
						S_RECEIVE_Data_Parallel_Out(3) <= S_Save_Bit;

					-- Bit 4
					ELSIF (S_State = "0110")
					THEN
						S_State <= "0111";
						S_RECEIVE_Data_Parallel_Out(4) <= S_Save_Bit;

					-- Bit 5
					ELSIF (S_State = "0111")
					THEN
						S_State <= "1000";
						S_RECEIVE_Data_Parallel_Out(5) <= S_Save_Bit;	

					-- Bit 6
					ELSIF (S_State = "1000")
					THEN
						S_State <= "1001";
						S_RECEIVE_Data_Parallel_Out(6) <= S_Save_Bit;

					-- Bit 7
					ELSIF (S_State = "1001")
					THEN
						S_State <= "1010";
						S_RECEIVE_Data_Parallel_Out(7) <= S_Save_Bit;

					-- Paritybit
					ELSIF (S_State = "1010")
					THEN
						S_State <= "1011";
						S_RECEIVE_Paritybit <= S_Save_Bit;

					-- erstes Stoppbit
					ELSIF (S_State = "1011")
					THEN
						S_State <= "0000";
						S_Enable_Receive <= '0';
						S_RECEIVE_Busy <= '0';
					
					ELSE
						-- Nothing to do
					END IF;
					
				ELSE
					-- Nothing to do
				END IF;
			
			END IF;
	end process;
	

	Receive_Bit : process 
	(
		S_RECEIVE_Reset,
		S_RECEIVE_Baudrate_5x,
		S_Enable_Receive
	)
	begin
			-- Resetfall
			IF((S_RECEIVE_Reset = '0') OR (S_Enable_Receive  = '0'))
			THEN
				S_Counter <= "000";
				S_Save_Bit <= '0';
				S_Save_Ready <= '0';
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_RECEIVE_Baudrate_5x = '1' AND S_RECEIVE_Baudrate_5x'EVENT AND S_Enable_Receive = '1')
			THEN
				IF (S_Counter = "000")
				THEN
					S_Counter <= "001";
					S_Save_Ready <= '0';
				ELSIF (S_Counter = "001")
				THEN
					S_Counter <= "010";
					S_DECISION_Value1 <= S_RECEIVE_Data_Serial_In;
				ELSIF (S_Counter = "010")
				THEN
					S_Counter <= "011";
					S_DECISION_Value2 <= S_RECEIVE_Data_Serial_In;
				ELSIF (S_Counter = "011")
				THEN
					S_Counter <= "100";
					S_DECISION_Value3 <= S_RECEIVE_Data_Serial_In;
				ELSIF (S_Counter = "100")
				THEN				
					S_Counter <= "000";
					S_Save_Bit <= S_DECISION_Result;
					S_Save_Ready <= '1';
				ELSE
					S_Counter <= "000";
				END IF;

			END IF;
	end process;
	
	
	
S_RECEIVE_Reset <= E_RECEIVE_Reset;
S_RECEIVE_Clock_In <= E_RECEIVE_Clock_In;	
S_RECEIVE_Baudrate_5x <= E_RECEIVE_Baudrate_5x;
E_RECEIVE_Paritybit <= S_RECEIVE_Paritybit;	
E_RECEIVE_Data_Parallel_Out <= S_RECEIVE_Data_Parallel_Out; -- 8 bit
S_RECEIVE_Data_Serial_In <= E_RECEIVE_Data_Serial_In;
E_RECEIVE_Busy <= S_RECEIVE_Busy;

end A_RECEIVE;

