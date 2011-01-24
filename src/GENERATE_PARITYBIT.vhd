-- Pinbeschreibung:

	-- Eingaenge:
		-- E_GENERATE_PARITYBIT_Reset				Reset
		-- E_GENERATE_PARITYBIT_Clock_In			Takt	
		-- E_GENERATE_PARITYBIT_Start_Calc		Positive Flanke startet Berechnung
		-- E_GENERATE_PARITYBIT_Data				Datenbyte aus dem das Paritybit berechnet werden soll

	-- Ausgaenge:		
		-- E_GENERATE_PARITYBIT_Paritiy_Out		Berechnetes Paritybit	
		-- E_GENERATE_PARITYBIT_Busy:				Signalisiert, ob die Berechnung abgeschlossen wurde		

library IEEE;		
use IEEE.STD_LOGIC_1164.ALL;


entity E_GENERATE_PARITYBIT is
Port(
		E_GENERATE_PARITYBIT_Reset: 				 		IN  STD_LOGIC;
		E_GENERATE_PARITYBIT_Clock_In:					IN  STD_LOGIC;		
		E_GENERATE_PARITYBIT_Start_Calc:					IN  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Data:							IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_GENERATE_PARITYBIT_Paritiy_Out:				OUT  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Busy:							OUT  STD_LOGIC		
);

end E_GENERATE_PARITYBIT;

architecture A_GENERATE_PARITYBIT of E_GENERATE_PARITYBIT is


SIGNAL S_GENERATE_PARITYBIT_Reset: 				STD_LOGIC;
SIGNAL S_GENERATE_PARITYBIT_Clock_In:			STD_LOGIC;		
SIGNAL S_GENERATE_PARITYBIT_Start_Calc:		STD_LOGIC;	
SIGNAL S_GENERATE_PARITYBIT_Data:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_GENERATE_PARITYBIT_Paritiy_Out:		STD_LOGIC;	
SIGNAL S_GENERATE_PARITYBIT_Busy:				STD_LOGIC;

SIGNAL S_Start_Calc_Old: 					STD_LOGIC;
SIGNAL S_Start_Calc_Event: 				STD_LOGIC; 
SIGNAL S_Start_Calc_Event_Handshake: 	STD_LOGIC; 

		
begin

S_GENERATE_PARITYBIT_Reset <= E_GENERATE_PARITYBIT_Reset;
S_GENERATE_PARITYBIT_Clock_In <= E_GENERATE_PARITYBIT_Clock_In;		
S_GENERATE_PARITYBIT_Start_Calc <= E_GENERATE_PARITYBIT_Start_Calc;	
S_GENERATE_PARITYBIT_Data <= E_GENERATE_PARITYBIT_Data; 
E_GENERATE_PARITYBIT_Paritiy_Out <= S_GENERATE_PARITYBIT_Paritiy_Out;
E_GENERATE_PARITYBIT_Busy <= S_GENERATE_PARITYBIT_Busy;



	Start_Event_erkennen : process (
		S_GENERATE_PARITYBIT_Reset,
		S_GENERATE_PARITYBIT_Clock_In
	)
	begin
			-- Resetfall
			IF(S_GENERATE_PARITYBIT_Reset = '0')
			THEN	
			S_Start_Calc_Old <= '0';
			S_Start_Calc_Event <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_GENERATE_PARITYBIT_Clock_In = '1' AND S_GENERATE_PARITYBIT_Clock_In'EVENT)
			THEN
				IF (S_GENERATE_PARITYBIT_Start_Calc = '1' AND S_Start_Calc_Old = '0')
				THEN
				S_Start_Calc_Event <= '1';
				ELSIF (S_Start_Calc_Event_Handshake = '1')
				THEN
				S_Start_Calc_Event <= '0';
				ELSE
				-- Nothing to do
				END IF;
			S_Start_Calc_Old <= S_GENERATE_PARITYBIT_Start_Calc;
			END IF;
	end process;
	

Berechnung_Parity : PROCESS
(
		S_GENERATE_PARITYBIT_Reset,
		S_GENERATE_PARITYBIT_Clock_In
)
	begin
		-- Resetfall
	IF(S_GENERATE_PARITYBIT_Reset = '0')
	THEN
	S_GENERATE_PARITYBIT_Paritiy_Out <= '0'; 
	S_GENERATE_PARITYBIT_Busy <= '0';
	S_Start_Calc_Event_Handshake <= '0';
			
	--	Main Loop wird bei jedem Taktereignis aufgerufen		
	ELSIF (S_GENERATE_PARITYBIT_Clock_In = '1' AND S_GENERATE_PARITYBIT_Clock_In'EVENT)
	THEN

		IF (S_Start_Calc_Event = '1')
		THEN
			
			S_GENERATE_PARITYBIT_Busy <= '1';
			S_Start_Calc_Event_Handshake <= '1';
			S_GENERATE_PARITYBIT_Paritiy_Out <= '0'; 
			
			FOR i IN 7 DOWNTO 0 LOOP 
				IF (S_GENERATE_PARITYBIT_Data(i) = '1') 
				THEN
					S_GENERATE_PARITYBIT_Paritiy_Out <= NOT S_GENERATE_PARITYBIT_Paritiy_Out;
				ELSE
					-- Nothing to do
				END IF;
			END LOOP; 		
			
			S_GENERATE_PARITYBIT_Busy <= '0';
		ELSIF (S_Start_Calc_Event = '0' AND S_Start_Calc_Event_Handshake = '1') 
		THEN
				S_Start_Calc_Event_Handshake <= '0';			
		ELSE
		  -- Nothing to do
		END IF;
			
	ELSE
	-- Nothing to do
	END IF;
		
	end process;


end A_GENERATE_PARITYBIT;


