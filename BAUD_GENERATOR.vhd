----------------------------------------------------------------------------------
-- Company: HS Weingarten
-- Engineer: 
-- 
-- Create Date:    10:02:31 11/05/2010 
-- Design Name: 
-- Module Name:    Baud_Generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Revision 0.02 - started hacking around
-- Revision 0.03 - working now, but with hard coded rates
-- Revision 0.9 - fully working
-- 
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity E_BAUD_GENERATOR is
	Port 
	( 
		E_BAUD_GENERATOR_Reset: 				IN  STD_LOGIC;
		E_BAUD_GENERATOR_Clock_In:				IN  STD_LOGIC;		
		E_BAUD_GENERATOR_Freq_Settings:		IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit		
		E_BAUD_GENERATOR_Baudrate: 			OUT STD_LOGIC;
		E_BAUD_GENERATOR_Baudrate_5x: 		OUT STD_LOGIC
	);
end E_BAUD_GENERATOR;

architecture A_BAUD_GENERATOR of E_BAUD_GENERATOR is

  -- CPU/Base Clock
  CONSTANT E_CLOCK_IN:									INTEGER := 50000000;
  
  -- Base Divisor for 50 Mhz (see E_CLOCK_IN)
  -- 2400 baud = 20833.33 | 9600 baud = 5208.33
  CONSTANT E_CLOCK_DIVISOR_BASE: 					INTEGER := 20833;
  
  -- calculated divisor
  SIGNAL E_CLOCK_DIVISOR:								INTEGER := 0;
  SIGNAL E_CALC_CLOCK_DIVISOR:						INTEGER := 0;
  
  -- counter value
  SIGNAL E_Clock_Generator_Counter: 				INTEGER := 0;
  
  -- event: output
  SIGNAL E_Clock_Generator_Event_Flag: 			STD_LOGIC := '0'; 
  SIGNAL E_Clock_Generator_Event_Flag5x:			STD_LOGIC := '0'; 

  SIGNAL E_Clock_Divisor_Counter1:					INTEGER := 0;
  SIGNAL E_Clock_Divisor_Counter2:					INTEGER := 0;

begin


	-- Counter, just counts the clock
	P_COUNTER : PROCESS
	 (
		E_BAUD_GENERATOR_CLock_In,
		E_BAUD_GENERATOR_Reset
	 )
	 BEGIN
	 
		IF (E_BAUD_GENERATOR_Reset = '0')
			THEN 
			E_Clock_Generator_Counter <= 0;
		 
		ELSIF (E_BAUD_GENERATOR_CLock_In = '1' AND E_BAUD_GENERATOR_CLock_In'EVENT)
			THEN
			-- count
			E_Clock_Generator_Counter <= E_Clock_Generator_Counter + 1;
			
			-- reset counter if clock value reached
			IF E_Clock_Generator_Counter = E_CLOCK_IN THEN
				E_Clock_Generator_Counter <= 0;
			END IF;
			
		END IF;
		
	END PROCESS P_COUNTER;


	-- generate output baud rates
	P_GENOUTPUT : PROCESS 
	(	
		E_BAUD_GENERATOR_CLock_In,
		E_BAUD_GENERATOR_Reset
	)
	BEGIN
	IF (E_BAUD_GENERATOR_Reset = '0') THEN 
		E_Clock_Generator_Event_Flag <= '0';
		E_Clock_Generator_Event_Flag5x <= '0';	 
	ELSIF (E_BAUD_GENERATOR_CLock_In = '1' AND E_BAUD_GENERATOR_CLock_In'EVENT)
		THEN
		
		-- Calculate Clock Divisor
		case E_BAUD_GENERATOR_Freq_Settings is
			when "000" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE;
							  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 5;
			when "001" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 2;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 10;
			when "010" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 4;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 20;
			when "011" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 8;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 40;
			when "100" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 16;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 80;
			when "101" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 32;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 160;
			when "110" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 64;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 320;
			when "111" => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 128;
										  E_CALC_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE / 640;
			when others => E_CLOCK_DIVISOR <= E_CLOCK_DIVISOR_BASE;
		end case;
		
		
		
		-- external rate
		IF (E_Clock_Divisor_Counter1 < E_CLOCK_DIVISOR) THEN
			E_Clock_Divisor_Counter1 <= E_Clock_Divisor_Counter1 + 1;			
		ELSIF (E_Clock_Divisor_Counter1 = E_CLOCK_DIVISOR) THEN
			E_Clock_Generator_Event_Flag <= NOT E_Clock_Generator_Event_Flag;
			E_Clock_Divisor_Counter1 <= 1;
		END IF;
		
		-- internal baud rate (needed for rx)
		IF (E_Clock_Divisor_Counter2 < E_CALC_CLOCK_DIVISOR) THEN
			E_Clock_Divisor_Counter2 <= E_Clock_Divisor_Counter2 + 1;			
		ELSIF (E_Clock_Divisor_Counter2 = E_CALC_CLOCK_DIVISOR) THEN
			E_Clock_Generator_Event_Flag5x <= NOT E_Clock_Generator_Event_Flag5x;
			E_Clock_Divisor_Counter2 <= 1;
		END IF;
		
	END IF;
	
	END PROCESS P_GENOUTPUT;

-- connect signales to output (port)
E_BAUD_GENERATOR_Baudrate <= E_Clock_Generator_Event_Flag;
E_BAUD_GENERATOR_Baudrate_5x <= E_Clock_Generator_Event_Flag5x;

end A_BAUD_GENERATOR;


