		----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:59 11/13/2010 
-- Design Name: 
-- Module Name:    E_MAIN - Behavioral 
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

entity E_MAIN is
	Port 
	( 
		E_MAIN_Reset: 				 		IN  STD_LOGIC;
		E_MAIN_Clock_In:					IN  STD_LOGIC;		
		E_MAIN_Freq_Settings:			IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
		E_MAIN_One_or_two_Stoppbits:	IN  STD_LOGIC;		
		E_MAIN_Paritybit:					IN  STD_LOGIC;
		E_MAIN_Serial_Out:				OUT STD_LOGIC
	);
end E_MAIN;

architecture E_MAIN_A of E_MAIN is

		SIGNAL S_MAIN_Reset: 				 	STD_LOGIC;
		SIGNAL S_MAIN_Clock_In:					STD_LOGIC;		
		SIGNAL S_MAIN_Freq_Settings:			STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
		SIGNAL S_MAIN_One_or_two_Stoppbits:	STD_LOGIC;		
		SIGNAL S_MAIN_Paritybit:					STD_LOGIC;
		SIGNAL S_MAIN_Serial_Out:		STD_LOGIC;

SIGNAL S_UART_Enable:		STD_LOGIC;
SIGNAL S_UART_Read_or_Write:		STD_LOGIC;
SIGNAL S_UART_Data_In:		STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL S_UART_Data_Out:		STD_LOGIC_VECTOR(7 DOWNTO 0);			
SIGNAL S_UART_Out_Length: STD_LOGIC_VECTOR(7 DOWNTO 0);


  component E_ARMADEUS_DUMMY Port
  (
  		E_ARMADEUS_DUMMY_Reset: 				IN  STD_LOGIC;
		E_ARMADEUS_DUMMY_Clock_In:				IN  STD_LOGIC
  );
  end component;

  component E_UART  Port
    (
		E_UART_Reset: 				 		IN  STD_LOGIC;
		E_UART_Clock_In:					IN  STD_LOGIC;		
		E_UART_Freq_Settings:			IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
		E_UART_Enable:						IN  STD_LOGIC;	
		E_UART_Read_or_Write:			IN  STD_LOGIC;	
		E_UART_One_or_two_Stoppbits:	IN  STD_LOGIC;		
		E_UART_Paritybit:					IN  STD_LOGIC;	
		E_UART_Data_In:					IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
		E_UART_Data_Out:					INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit			
		E_UART_Data_Out_Length:			INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
		E_UART_Serial_Out:				OUT  STD_LOGIC	
	);
  end component;

begin

  C_ARMADEUS_DUMMY: E_ARMADEUS_DUMMY PORT MAP
  (
  E_ARMADEUS_DUMMY_Reset => S_MAIN_Reset,
  E_ARMADEUS_DUMMY_Clock_In => S_MAIN_Clock_In
  );
  
C_UART: E_UART PORT MAP
	(
		E_UART_Reset => S_MAIN_Reset,
		E_UART_Clock_In => S_MAIN_Clock_In,	
		E_UART_Freq_Settings => S_MAIN_Freq_Settings,
		E_UART_Enable => S_UART_Enable,
		E_UART_Read_or_Write => S_UART_Read_or_Write,
		E_UART_One_or_two_Stoppbits => S_MAIN_One_or_two_Stoppbits,	
		E_UART_Paritybit => S_MAIN_Paritybit,
		E_UART_Data_In => S_UART_Data_In,	
		E_UART_Data_Out => S_UART_Data_Out,			
		E_UART_Data_Out_Length => S_UART_Out_Length,
		E_UART_Serial_Out => S_MAIN_Serial_Out
	);
	
		S_MAIN_Reset <= E_MAIN_Reset;
		S_MAIN_Clock_In <= E_MAIN_Clock_In;	
		S_MAIN_Freq_Settings <= E_MAIN_Freq_Settings;
		S_MAIN_One_or_two_Stoppbits <= E_MAIN_One_or_two_Stoppbits;	
		S_MAIN_Paritybit <= E_MAIN_Paritybit;
		E_MAIN_Serial_Out <= S_MAIN_Serial_Out;

end E_MAIN_A;

