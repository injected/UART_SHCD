----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:49 11/13/2010 
-- Design Name: 
-- Module Name:    TESTBENCH - Behavioral 
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

entity E_TESTBENCH is
end E_TESTBENCH;

architecture E_TESTBENCH_A  of E_TESTBENCH is



  component E_MAIN Port
    (
		E_MAIN_Reset: 				 		IN  STD_LOGIC;
		E_MAIN_Clock_In:					IN  STD_LOGIC;		
		E_MAIN_Freq_Settings:			IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
		E_MAIN_One_or_two_Stoppbits:	IN  STD_LOGIC;		
		E_MAIN_Paritybit:					IN  STD_LOGIC;
		E_MAIN_Serial_Out:				OUT STD_LOGIC
	);
  end component;

		SIGNAL S_MAIN_Reset: STD_LOGIC;	
		SIGNAL S_MAIN_Clock_In:	STD_LOGIC;		
		SIGNAL S_MAIN_Freq_Settings: STD_LOGIC_VECTOR(2 DOWNTO 0);
		SIGNAL S_MAIN_One_or_two_Stoppbits: STD_LOGIC;	
		SIGNAL S_MAIN_Paritybit: STD_LOGIC;
		SIGNAL S_MAIN_Serial_Out: STD_LOGIC;


begin



C_MAIN: E_MAIN PORT MAP
(
		E_MAIN_Reset => S_MAIN_Reset,		
		E_MAIN_Clock_In => S_MAIN_Clock_In,
		E_MAIN_Freq_Settings => S_MAIN_Freq_Settings,
		E_MAIN_One_or_two_Stoppbits => S_MAIN_One_or_two_Stoppbits,		
		E_MAIN_Paritybit =>  S_MAIN_Paritybit 
	);

	S_MAIN_Reset <= '1';
	S_MAIN_Freq_Settings <= "000";
	S_MAIN_One_or_two_Stoppbits <= '0';
	S_MAIN_Paritybit <= '0';
 
end E_TESTBENCH_A ;

