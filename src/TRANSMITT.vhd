----------------------------------------------------------------------------------
-- Company: HS Weingarten
-- Engineer: kgl
-- 
-- Create Date:    13:19:32 11/13/2010 
-- Design Name: 
-- Module Name:    E_TRANSMITT - A_TRANSMITT 
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

entity E_TRANSMITT is
Port (
		E_TRANSMITT_Reset: 				 		IN  STD_LOGIC;
		E_TRANSMITT_Clock_In:					IN  STD_LOGIC;
	   E_TRANSMITT_Baudrate: 					IN  STD_LOGIC;
		E_TRANSMITT_Enable:						IN  STD_LOGIC;
		E_TRANSMITT_One_or_two_Stoppbits:	IN  STD_LOGIC;
		E_TRANSMITT_Paritybit:					IN  STD_LOGIC;
		E_TRANSMITT_Data:							IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_TRANSMITT_Serial_Out:					OUT  STD_LOGIC;
		E_TRANSMITT_Busy:							OUT  STD_LOGIC
);
end E_TRANSMITT;

architecture A_TRANSMITT of E_TRANSMITT is
	CONSTANT START_STATE:			INTEGER 		:= 12;
	CONSTANT END_STATE:				INTEGER 		:= 99;
	SIGNAL Serial_Out: 				STD_LOGIC 	:= '1';
	SIGNAL Current_State: 			INTEGER 		:= END_STATE;
	SIGNAL Last_Baudrate_Value: 	STD_LOGIC 	:= '0';
	SIGNAL Busy_Flag:					STD_LOGIC	:= '0';
	SIGNAL Last_Enable_Value:		STD_LOGIC	:= '0';
begin

	P1 : process (
		E_TRANSMITT_Clock_In,
		E_TRANSMITT_Reset
	)
	begin
		-- flankenwechsel erkennen und state in 12 (startzustand) setzten
		IF(E_TRANSMITT_Enable = '1' AND Last_Enable_Value = '0')
			THEN
			Current_State <= START_STATE;
		END IF;
		
		IF(E_TRANSMITT_Enable = '1') 
			THEN

			IF (E_TRANSMITT_Reset = '0')
				THEN
				Serial_Out <= '1';
				Current_State <= END_STATE;
			ELSIF (E_TRANSMITT_Clock_In = '1' AND E_TRANSMITT_Clock_In'EVENT)
				THEN
				-- changed signal
				IF (E_TRANSMITT_Baudrate = '1' AND Last_Baudrate_Value = '0')
					THEN
					Busy_Flag <= '1';
					case Current_State is
						-- start bit
						when START_STATE => 
							Serial_Out <= '0';
							Current_State <= 0;
						-- parity bit
						when 8 => 
							Serial_Out <= E_TRANSMITT_Paritybit;
							Current_State <= 10;
						-- stop bit
						when 10 => 
							-- first stop bit
							Serial_Out <= '1';
							IF(E_TRANSMITT_One_or_two_Stoppbits = '1')
							THEN
								Current_State <= 11;
							ELSIF(E_TRANSMITT_One_or_two_Stoppbits = '0')
							THEN
								Current_State <= END_STATE;
							END IF;
						-- stop bit 2
						when 11 =>
							-- second stop bit
							Serial_Out <= '1';
							Current_State <= END_STATE;
						-- final state (end zustand)
						when END_STATE =>
							Busy_Flag <= '0';
						-- data
						when others => 
							Serial_Out <= E_TRANSMITT_Data(Current_State);
							Current_State <= Current_State+1;
					end case;
					
				END IF; -- baudratenwechsel
				Last_Baudrate_Value  <= E_TRANSMITT_Baudrate;
			END IF; -- reset + clock
		END IF; -- enable
		Last_Enable_Value <= E_TRANSMITT_Enable;
	end process;



-- connect
E_TRANSMITT_Serial_Out <= Serial_Out;
E_TRANSMITT_Busy <= Busy_Flag;

end A_TRANSMITT;

