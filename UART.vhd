----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:33:52 11/13/2010 
-- Design Name: 
-- Module Name:    UART - Behavioral 
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

entity E_UART is
	Port 
	( 
		E_UART_Reset: 				 		IN  STD_LOGIC;
		E_UART_Clock_In:					IN  STD_LOGIC;		
		E_UART_Freq_Settings:			IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
		E_UART_Enable:						IN  STD_LOGIC;	
		E_UART_Read_or_Write:			IN  STD_LOGIC;	
		E_UART_One_or_two_Stoppbits:	IN  STD_LOGIC;		
		E_UART_Paritybit:					IN  STD_LOGIC;	
		E_UART_Data_In:					IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_UART_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit			
		E_UART_Data_Out_Length:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
		E_UART_Serial_Out:				OUT  STD_LOGIC	
	);
end E_UART;

architecture A_UART of E_UART is
  
  
SIGNAL S_UART_Reset: 				 		STD_LOGIC;
SIGNAL S_UART_Clock_In:				STD_LOGIC;		
SIGNAL S_UART_Freq_Settings:			 STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
SIGNAL S_UART_Enable:					STD_LOGIC;	
SIGNAL S_UART_Read_or_Write:			STD_LOGIC;	
SIGNAL S_UART_One_or_two_Stoppbits:	STD_LOGIC;		
SIGNAL S_UART_Paritybit:				STD_LOGIC;	
SIGNAL S_UART_Data_In:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
SIGNAL S_UART_Data_Out:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit			
SIGNAL S_UART_Data_Out_Length:		STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
SIGNAL S_UART_Serial_Out:				STD_LOGIC;

  SIGNAL S_BAUD_GENERATOR_Baudrate: 	STD_LOGIC;
  SIGNAL S_BAUD_GENERATOR_Baudrate_5x: 		STD_LOGIC;

  SIGNAL S_TX_Enable: 		STD_LOGIC;
  SIGNAL S_TX_Busy:			STD_LOGIC;
  
  SIGNAL S_RX_Enable: 		STD_LOGIC;

  component E_BAUD_GENERATOR Port
    (
		E_BAUD_GENERATOR_Reset: 				IN  STD_LOGIC;
		E_BAUD_GENERATOR_Clock_In:				IN  STD_LOGIC;		
		E_BAUD_GENERATOR_Freq_Settings:		IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit		
		E_BAUD_GENERATOR_Baudrate: 			OUT STD_LOGIC;
		E_BAUD_GENERATOR_Baudrate_5x: 		OUT STD_LOGIC
	);
  end component;

component E_TX
Port (
		E_TX_Reset: 				 		IN  STD_LOGIC;
		E_TX_Clock_In:						IN  STD_LOGIC;	
	   E_TX_Baudrate: 					IN  STD_LOGIC;		
		E_TX_Enable:						IN  STD_LOGIC;	
		E_TX_Busy:							OUT  STD_LOGIC;	
		E_TX_One_or_two_Stoppbits:		IN  STD_LOGIC;		
		E_TX_Paritybit:					IN  STD_LOGIC;	
		E_TX_Data:							IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
		E_TX_Serial_Out:					OUT  STD_LOGIC	
);  
end component;

component E_RX 
Port (
		E_RX_Reset: 				 		IN  STD_LOGIC;
		E_RX_Clock_In:						IN  STD_LOGIC;	
	   E_RX_Baudrate: 					IN  STD_LOGIC;	
	   E_RX_Baudrate_5x: 				IN  STD_LOGIC;			
		E_RX_Enable:						IN  STD_LOGIC;	
		E_RX_One_or_two_Stoppbits:		IN  STD_LOGIC;		
		E_RX_Paritybit:					IN  STD_LOGIC;	
		E_RX_Data_Out:						INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RX_Data_Out_Length:			INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0) -- 8 bit
);
end component;
  
begin


C_BAUD_GENERATOR: E_BAUD_GENERATOR PORT MAP
	(
		E_BAUD_GENERATOR_Reset => S_UART_Reset,
		E_BAUD_GENERATOR_Clock_In => S_UART_Clock_In,	
		E_BAUD_GENERATOR_Freq_Settings => S_UART_Freq_Settings,	
		E_BAUD_GENERATOR_Baudrate => S_BAUD_GENERATOR_Baudrate,
		E_BAUD_GENERATOR_Baudrate_5x => S_BAUD_GENERATOR_Baudrate_5x 
	);

C_TX: E_TX
PORT MAP 
(
		E_TX_Reset => S_UART_Reset,
		E_TX_Clock_In => S_UART_Clock_In,
	   E_TX_Baudrate => S_BAUD_GENERATOR_Baudrate,	
		E_TX_Enable => S_TX_Enable,
		E_TX_Busy => S_TX_Busy,		
		E_TX_One_or_two_Stoppbits => S_UART_One_or_two_Stoppbits,		
		E_TX_Paritybit => S_UART_Paritybit,	
		E_TX_Data => S_UART_Data_In,
		E_TX_Serial_Out => S_UART_Serial_Out
);

C_RX: E_RX 
PORT MAP (
		E_RX_Reset => S_UART_Reset ,
		E_RX_Clock_In => S_UART_Clock_In,
	   E_RX_Baudrate => S_BAUD_GENERATOR_Baudrate,	
	   E_RX_Baudrate_5x => S_BAUD_GENERATOR_Baudrate_5x,		
		E_RX_Enable => S_RX_Enable,	
		E_RX_One_or_two_Stoppbits => S_UART_One_or_two_Stoppbits,		
		E_RX_Paritybit => S_UART_Paritybit,
		E_RX_Data_Out => S_UART_Data_Out,
		E_RX_Data_Out_Length => S_UART_Data_Out_Length
);

S_UART_Reset <= E_UART_Reset;
S_UART_Clock_In <= E_UART_Clock_In;
S_UART_Freq_Settings <= E_UART_Freq_Settings;
S_UART_Enable <= E_UART_Enable;
S_UART_Read_or_Write <= E_UART_Read_or_Write;
S_UART_One_or_two_Stoppbits <= E_UART_One_or_two_Stoppbits;
S_UART_Paritybit <= E_UART_Paritybit;
S_UART_Data_In <= E_UART_Data_In;
E_UART_Data_Out <= S_UART_Data_Out;		
E_UART_Data_Out_Length <= S_UART_Data_Out_Length;
E_UART_Serial_Out <= S_UART_Serial_Out;

end A_UART;

