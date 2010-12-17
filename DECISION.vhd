----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:59 11/13/2010 
-- Design Name: 
-- Module Name:    E_DECISION - A_DECISION 
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

entity E_DECISION is
    Port ( 
	 		E_DECISION_Reset: 				IN  STD_LOGIC;
			E_DECISION_Clock_In:				IN  STD_LOGIC;		
			E_DECISION_Value1 : IN  STD_LOGIC;
         E_DECISION_Value2 : IN  STD_LOGIC;
         E_DECISION_Value3 : IN  STD_LOGIC;
         E_DECISION_Result : OUT  STD_LOGIC;
			E_DECISION_Busy : OUT  STD_LOGIC);
end E_DECISION;

architecture A_DECISION of E_DECISION is

SIGNAL S_DECISION_Reset: 	STD_LOGIC;
SIGNAL S_DECISION_Clock_In:	STD_LOGIC;		
SIGNAL S_DECISION_Value1 : STD_LOGIC;
SIGNAL S_DECISION_Value2 :  STD_LOGIC;
SIGNAL S_DECISION_Value3 :  STD_LOGIC;
SIGNAL S_DECISION_Result :   STD_LOGIC;
SIGNAL S_DECISION_Busy :   STD_LOGIC;

begin


	P1 : process (
		S_DECISION_Reset,
		S_DECISION_Clock_In
	)
	begin
			-- Resetfall
			IF(S_DECISION_Reset = '0')
			THEN
				S_DECISION_Result <= '0';
				S_DECISION_Busy <= '1';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_DECISION_Clock_In = '1' AND S_DECISION_Clock_In'EVENT)
			THEN
				IF ((S_DECISION_Value1 = '1' AND S_DECISION_Value2 = '1') OR (S_DECISION_Value2 = '1' AND S_DECISION_Value3 = '1') OR (S_DECISION_Value1 = '1' AND S_DECISION_Value3 = '1'))
				THEN
					S_DECISION_Result <= '1';
					S_DECISION_Busy <= '0';		
				ELSE
					S_DECISION_Result <= '0';	
					S_DECISION_Busy <= '0';							
				END IF;
			END IF;
	end process;


S_DECISION_Reset <= E_DECISION_Reset;
S_DECISION_Clock_In <= E_DECISION_Clock_In;	
S_DECISION_Value1 <= E_DECISION_Value1;
S_DECISION_Value2 <= E_DECISION_Value2;
S_DECISION_Value3 <= E_DECISION_Value3;
E_DECISION_Result <= S_DECISION_Result;
E_DECISION_Busy <= S_DECISION_Busy;

end A_DECISION;

