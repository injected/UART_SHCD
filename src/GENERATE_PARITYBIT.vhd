----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:18 11/13/2010 
-- Design Name: 
-- Module Name:    Gererate_Paritybit - Behavioral 
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

entity E_GENERATE_PARITYBIT is
Port(
		E_GENERATE_PARITYBIT_Reset: 				 		IN  STD_LOGIC;
		E_GENERATE_PARITYBIT_Clock_In:					IN  STD_LOGIC;		
		E_GENERATE_PARITYBIT_Enable:						IN  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Data:							IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_GENERATE_PARITYBIT_Paritiy_Out:				OUT  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Busy:							OUT  STD_LOGIC		
);

end E_GENERATE_PARITYBIT;

architecture A_GENERATE_PARITYBIT of E_GENERATE_PARITYBIT is

SIGNAL P: 			STD_LOGIC; 
--SIGNAL P_intern: 			STD_LOGIC;
		

begin

P_COUNTER : PROCESS
(
		E_GENERATE_PARITYBIT_Reset,
		E_GENERATE_PARITYBIT_Clock_In
)
begin
		-- Resetfall
			IF(E_GENERATE_PARITYBIT_Reset = '0')
			THEN
			P <= '0'; 
			E_GENERATE_PARITYBIT_Busy <= '0';
			
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (E_GENERATE_PARITYBIT_Clock_In = '1' AND E_GENERATE_PARITYBIT_Clock_In'EVENT)
			THEN

	IF (E_GENERATE_PARITYBIT_Enable = '1') THEN
	
	E_GENERATE_PARITYBIT_Busy <= '1';
	
		FOR i IN 7 DOWNTO 0 LOOP 
			IF (E_GENERATE_PARITYBIT_Data(i) = '1') THEN
				P <= NOT P;
			END IF;
		END LOOP; 		
		--IF (P='0') THEN
		--	P_intern <= '0';
		--	p<='0';
		--ELSE 
		--	P_intern <= '1';
		--	p<='0';
		--END IF;
		ELSE
		  P<='0';
	END IF;
	END IF;
	
	E_GENERATE_PARITYBIT_Busy <= '0';
	
	END PROCESS P_COUNTER;

  E_GENERATE_PARITYBIT_Paritiy_Out<=P;

end A_GENERATE_PARITYBIT;


