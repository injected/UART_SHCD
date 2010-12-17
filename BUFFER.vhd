----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:17 11/13/2010 
-- Design Name: 
-- Module Name:    E_BUFFER - Behavioral 
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

entity E_BUFFER is
Port(
		E_BUFFER_Reset: 				 		IN  STD_LOGIC;
		E_BUFFER_Clock_In:					IN  STD_LOGIC;	
		E_BUFFER_Data_In:						IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Save:							IN  STD_LOGIC;
		E_BUFFER_Save_Busy:					OUT  STD_LOGIC;		
		E_BUFFER_Length:						OUT INTEGER;		
		E_BUFFER_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Load:							IN  STD_LOGIC;		
		E_BUFFER_Load_Busy:					OUT  STD_LOGIC			
);
end E_BUFFER;

architecture A_BUFFER of E_BUFFER is

begin

E_BUFFER_Data_Out <= E_BUFFER_Data_In;
E_BUFFER_Save_Busy <= '0';
E_BUFFER_Load_Busy <= '0';
E_BUFFER_Length <= 1;

end A_BUFFER;

