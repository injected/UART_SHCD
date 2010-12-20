----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:58 11/13/2010 
-- Design Name: 
-- Module Name:    E_RX - A_RX 
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

entity E_RX is
Port (
		E_RX_Reset: 				 		IN  STD_LOGIC;
		E_RX_Clock_In:						IN  STD_LOGIC;	
	   E_RX_Baudrate: 					IN  STD_LOGIC;	
	   E_RX_Baudrate_5x: 				IN  STD_LOGIC;			
		E_RX_Enable:						IN  STD_LOGIC;	
		E_RX_One_or_two_Stoppbits:		IN  STD_LOGIC;		
		E_RX_Paritybit:					IN  STD_LOGIC;	
		E_RX_Data_Parallel_Out:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RX_Data_Serial_In:				IN  STD_LOGIC;
		E_RX_Data_Out_Length:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) -- 8 bit
);
end E_RX;

architecture A_RX of E_RX is

SIGNAL S_RX_Reset: 				 		STD_LOGIC;
SIGNAL S_RX_Clock_In:					STD_LOGIC;	
SIGNAL S_RX_Baudrate: 				STD_LOGIC;	
SIGNAL S_RX_Baudrate_5x: 		STD_LOGIC;			
SIGNAL S_RX_Enable:					STD_LOGIC;	
SIGNAL S_RX_One_or_two_Stoppbits:	STD_LOGIC;		
SIGNAL S_RX_Paritybit:				STD_LOGIC;	
SIGNAL S_RX_Data_Parallel_Out:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_RX_Data_Serial_In:	STD_LOGIC;	
SIGNAL S_RX_Data_Out_Length:		STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
	
SIGNAL S_RECEIVE_Enable:				STD_LOGIC;	
SIGNAL S_RECEIVE_Busy:				STD_LOGIC;	
SIGNAL S_RECEIVE_Data:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_RECEIVE_Data_Out_Length:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
	
		SIGNAL S_GENERATE_PARITYBIT_Enable:					STD_LOGIC;	
		SIGNAL S_GENERATE_PARITYBIT_Data:						STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		SIGNAL S_GENERATE_PARITYBIT_Paritiy_Out:				STD_LOGIC;		

		SIGNAL S_BUFFER_Data_In:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		SIGNAL S_BUFFER_Save:				STD_LOGIC;
		SIGNAL S_BUFFER_Length:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit;		
		SIGNAL S_BUFFER_Data_Out:			STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		SIGNAL S_BUFFER_Load:					STD_LOGIC;		
	
	component E_RECEIVE 
Port (
		E_RECEIVE_Reset: 				 		IN  STD_LOGIC;
		E_RECEIVE_Clock_In:					IN  STD_LOGIC;		
	   E_RECEIVE_Baudrate: 					IN  STD_LOGIC;
		E_RECEIVE_Baudrate_5x:  					IN  STD_LOGIC;
		E_RECEIVE_Enable:						IN  STD_LOGIC;	
		E_RECEIVE_One_or_two_Stoppbits:		IN  STD_LOGIC;		
		E_RECEIVE_Paritybit:					IN  STD_LOGIC;	
		E_RECEIVE_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RECEIVE_Data_Out_Length:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RECEIVE_Busy:							OUT  STD_LOGIC
);
  end component;

component E_GENERATE_PARITYBIT
Port(
		E_GENERATE_PARITYBIT_Reset: 				 		IN  STD_LOGIC;
		E_GENERATE_PARITYBIT_Clock_In:					IN  STD_LOGIC;		
		E_GENERATE_PARITYBIT_Enable:						IN  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Data:						IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_GENERATE_PARITYBIT_Paritiy_Out:				OUT  STD_LOGIC		
);
end component;

component E_BUFFER 
Port(
		E_BUFFER_Reset: 				 		IN  STD_LOGIC;
		E_BUFFER_Clock_In:					IN  STD_LOGIC;	
		E_BUFFER_Data_In:						IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Save:							IN  STD_LOGIC;
		E_BUFFER_Length:						OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit;		
		E_BUFFER_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Load:							OUT  STD_LOGIC		
);
end component;
	
	
begin


C_RECEIVE: E_RECEIVE 
PORT MAP 
(
		E_RECEIVE_Reset => S_RX_Reset,
		E_RECEIVE_Clock_In => S_RX_Clock_In,
	   E_RECEIVE_Baudrate =>	S_RX_Baudrate,
		E_RECEIVE_Baudrate_5x => S_RX_Baudrate_5x,
		E_RECEIVE_Enable => S_RECEIVE_Enable,
		E_RECEIVE_One_or_two_Stoppbits => S_RX_One_or_two_Stoppbits,
		E_RECEIVE_Paritybit => S_RX_Paritybit,
		E_RECEIVE_Data_Out => S_RECEIVE_Data,
		E_RECEIVE_Data_Out_Length => S_RECEIVE_Data_Out_Length,
		E_RECEIVE_Busy => S_RECEIVE_Busy		
);  

C_GENERATE_PARITYBIT: E_GENERATE_PARITYBIT
PORT MAP
(
		E_GENERATE_PARITYBIT_Reset => S_RX_Reset,
		E_GENERATE_PARITYBIT_Clock_In => S_RX_Clock_In,	
		E_GENERATE_PARITYBIT_Enable => S_GENERATE_PARITYBIT_Enable,
		E_GENERATE_PARITYBIT_Data => S_GENERATE_PARITYBIT_Data,
		E_GENERATE_PARITYBIT_Paritiy_Out => S_GENERATE_PARITYBIT_Paritiy_Out 		
		
);

C_BUFFER: E_BUFFER
PORT MAP
(
		E_BUFFER_Reset => S_RX_Reset,
		E_BUFFER_Clock_In => S_RX_Clock_In,
		E_BUFFER_Data_In => S_BUFFER_Data_In,
		E_BUFFER_Save => S_BUFFER_Save,
		E_BUFFER_Length => S_BUFFER_Length,	
		E_BUFFER_Data_Out => S_BUFFER_Data_Out,		
		E_BUFFER_Load => S_BUFFER_Load	
);

S_RX_Reset <= E_RX_Reset ;
S_RX_Clock_In <= E_RX_Clock_In;	
S_RX_Baudrate <= E_RX_Baudrate;	
S_RX_Baudrate_5x <= E_RX_Baudrate_5x;			
S_RX_Enable <= E_RX_Enable;	
S_RX_One_or_two_Stoppbits <= E_RX_One_or_two_Stoppbits;		
S_RX_Paritybit <= E_RX_Paritybit;	
E_RX_Data_Parallel_Out <= S_RX_Data_Out; -- 8 bit
S_RX_Data_Serial_In <= E_RX_Data_Serial_In;
E_RX_Data_Out_Length <= S_RX_Data_Out_Length; -- 8 bit

end A_RX;

