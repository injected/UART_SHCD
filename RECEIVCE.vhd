----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:49 11/13/2010 
-- Design Name: 
-- Module Name:    E_RECEIVCE - A_RECEIVE 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity E_RECEIVE is
Port (
		E_RECEIVE_Reset: 				 		IN  STD_LOGIC;
		E_RECEIVE_Clock_In:					IN  STD_LOGIC;		
		E_RECEIVE_Baudrate_5x:  					IN  STD_LOGIC;	
		E_RECEIVE_Paritybit:					OUT STD_LOGIC;	
		E_RECEIVE_Data_Parallel_Out:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RECEIVE_Data_Serial_In:				IN  STD_LOGIC;
		E_RECEIVE_Busy:							OUT  STD_LOGIC
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
SIGNAL S_DECISION_Busy:				STD_LOGIC;	

component E_DECISION
    Port ( 
	 		E_DECISION_Reset: 				IN  STD_LOGIC;
			E_DECISION_Clock_In:				IN  STD_LOGIC;		
			E_DECISION_Value1 : IN  STD_LOGIC;
         E_DECISION_Value2 : IN  STD_LOGIC;
         E_DECISION_Value3 : IN  STD_LOGIC;
         E_DECISION_Result : OUT  STD_LOGIC;
			E_DECISION_Busy : OUT  STD_LOGIC
			);
end component;

begin

C_DECISION: E_DECISION
    PORT MAP ( 
	 		E_DECISION_Reset => S_RECEIVE_Reset,
			E_DECISION_Clock_In => S_RECEIVE_Clock_In,
			E_DECISION_Value1 => S_DECISION_Value1,
         E_DECISION_Value2 => S_DECISION_Value2,
         E_DECISION_Value3 => S_DECISION_Value3,
         E_DECISION_Result  => S_DECISION_Result,
			E_DECISION_Busy => S_DECISION_Busy
			);


	P1 : process (
		S_RECEIVE_Reset,
		S_RECEIVE_Clock_In
	)
	begin
			-- Resetfall
			IF(S_RECEIVE_Reset = '0')
			THEN
				S_RECEIVE_Data_Parallel_Out <= "00000000";
				S_RECEIVE_Busy <= '0';	
				S_State <= "0000";	
				S_RECEIVE_Paritybit <= '0';
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_RECEIVE_Clock_In = '1' AND S_RECEIVE_Clock_In'EVENT)
			THEN
			
				-- warten auf Startbit
				IF (S_State = "0000" AND S_RECEIVE_Data_Serial_In = '0')
				THEN
					S_RECEIVE_Busy <= '1';	
					S_State <= "0001";
				
				-- Startbit
				ELSIF (S_State = "0001" AND S_Counter = "100")
				THEN
				S_State <= "0010";
				
				-- Bit 0
				ELSIF (S_State = "0010" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(0) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "0010" AND S_Counter = "100")
				THEN
				S_State <= "0011";
				
				-- Bit 1
				ELSIF (S_State = "0011" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(1) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "0011" AND S_Counter = "100")
				THEN
				S_State <= "0100";

				-- Bit 2
				ELSIF (S_State = "0100" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(2) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "0100" AND S_Counter = "100")
				THEN
				S_State <= "0101";

				-- Bit 3
				ELSIF (S_State = "0101" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(3) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "0101" AND S_Counter = "100")
				THEN
				S_State <= "0110";

				-- Bit 4
				ELSIF (S_State = "0111" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(4) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "0111" AND S_Counter = "100")
				THEN
				S_State <= "1000";

				-- Bit 5
				ELSIF (S_State = "1000" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(5) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "1000" AND S_Counter = "100")
				THEN
				S_State <= "1001";

				-- Bit 6
				ELSIF (S_State = "1001" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(6) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "1001" AND S_Counter = "100")
				THEN
				S_State <= "1010";

				-- Bit 7
				ELSIF (S_State = "1010" AND S_Counter = "010")
				THEN
				S_RECEIVE_Data_Parallel_Out(7) <= S_RECEIVE_Data_Serial_In;

				ELSIF (S_State = "1010" AND S_Counter = "100")
				THEN
				S_State <= "1011";
				
				-- Paritybit
				ELSIF (S_State = "1011" AND S_Counter = "010")
				THEN
				S_RECEIVE_Paritybit <= S_RECEIVE_Data_Serial_In;
				ELSIF (S_State = "1011" AND S_Counter = "100")
				THEN
				S_State <= "1100";				

				
				-- Erstes Stoppbit, State-Machine reseten, Busy-Flag reseten	
				ELSIF (S_State = "1100")
				THEN
				S_State <= "0000";	
				S_RECEIVE_Busy <= '0';
				
				END IF;
			
			END IF;
	end process;
	

	P2 : process (
		S_RECEIVE_Reset,
		S_RECEIVE_Baudrate_5x
	)
	begin
			-- Resetfall
			IF((S_RECEIVE_Reset = '0') OR (S_State = "0001"))
			THEN
				S_Counter <= "000";
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_RECEIVE_Baudrate_5x = '1' AND S_RECEIVE_Baudrate_5x'EVENT)
			THEN
				CASE S_Counter IS
				WHEN "000" => S_Counter <= "001";
				WHEN "001" => S_Counter <= "010";
				WHEN "010" => S_Counter <= "011";
				WHEN "011" => S_Counter <= "100";
				WHEN "100" => S_Counter <= "000";				
				WHEN OTHERS => S_Counter <= "000";
				END CASE;
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

