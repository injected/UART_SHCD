----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:47 11/13/2010 
-- Design Name: 
-- Module Name:    TX - Behavioral 
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

entity E_TX is
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
end E_TX;

architecture E_TX of E_TX is

		SIGNAL S_TX_Reset: 				 		STD_LOGIC;
		SIGNAL S_TX_Clock_In:						STD_LOGIC;	
	   SIGNAL S_TX_Baudrate: 					STD_LOGIC;		
		SIGNAL S_TX_Enable:						STD_LOGIC;	
		SIGNAL S_TX_Enable_old:						STD_LOGIC;
	   SIGNAL S_TX_Do_Save:						STD_LOGIC;
		SIGNAL S_TX_One_or_two_Stoppbits:		STD_LOGIC;		
		SIGNAL S_TX_Paritybit:					STD_LOGIC;	
		SIGNAL S_TX_Data:							STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		SIGNAL S_TX_Serial_Out:						STD_LOGIC;			
		SIGNAL S_TX_Busy:						STD_LOGIC;			
		
		SIGNAL S_TRANSMITT_Enable:						STD_LOGIC;			
		SIGNAL S_TRANSMITT_Paritybit:					STD_LOGIC;	
		SIGNAL S_TRANSMITT_Data:							STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
		SIGNAL S_TRANSMITT_Busy:						STD_LOGIC;		

		SIGNAL S_GENERATE_PARITYBIT_Enable:					STD_LOGIC;	
		SIGNAL S_GENERATE_PARITYBIT_Data:						STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		SIGNAL S_GENERATE_PARITYBIT_Paritiy_Out:				STD_LOGIC;	
		SIGNAL S_GENERATE_PARITYBIT_Busy:				STD_LOGIC;		

		SIGNAL S_BUFFER_Data_In:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		SIGNAL S_BUFFER_Save:				STD_LOGIC;
		SIGNAL S_BUFFER_Save_Busy:				STD_LOGIC;		
		SIGNAL S_BUFFER_Length:					INTEGER; -- 8 bit;		
		SIGNAL S_BUFFER_Data_Out:			STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		SIGNAL S_BUFFER_Load:					STD_LOGIC;	
		SIGNAL S_BUFFER_Load_Busy:					STD_LOGIC;			

		SIGNAL S_BUFFER_LOAD_STATE:			INTEGER;
	
		
component E_TRANSMITT 
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
  end component;

component E_GENERATE_PARITYBIT
Port(
		E_GENERATE_PARITYBIT_Reset: 				 		IN  STD_LOGIC;
		E_GENERATE_PARITYBIT_Clock_In:					IN  STD_LOGIC;		
		E_GENERATE_PARITYBIT_Start_Calc:						IN  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Data:							IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_GENERATE_PARITYBIT_Paritiy_Out:				OUT  STD_LOGIC;	
		E_GENERATE_PARITYBIT_Busy:							OUT  STD_LOGIC	
);
end component;

component E_BUFFER
Port(
		E_BUFFER_Reset: 				 		IN  STD_LOGIC;
		E_BUFFER_Clock_In:					IN  STD_LOGIC;	
		E_BUFFER_Data_In:						IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Save:							IN  STD_LOGIC;
		E_BUFFER_Save_Busy:					OUT  STD_LOGIC;		
		-- E_BUFFER_Length:						OUT INTEGER;		
		E_BUFFER_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Load:							IN  STD_LOGIC;		
		E_BUFFER_Load_Busy:					OUT  STD_LOGIC		
);
end component;
  
begin  

C_TRANSMITT: E_TRANSMITT 
PORT MAP 
(
		E_TRANSMITT_Reset => S_TX_Reset,
		E_TRANSMITT_Clock_In => S_TX_Clock_In,
	   E_TRANSMITT_Baudrate =>	S_TX_Baudrate,
		E_TRANSMITT_Enable => S_TRANSMITT_Enable,
		E_TRANSMITT_One_or_two_Stoppbits => S_TX_One_or_two_Stoppbits,
		E_TRANSMITT_Paritybit => S_TRANSMITT_Paritybit,
		E_TRANSMITT_Data => S_TRANSMITT_Data,
		E_TRANSMITT_Serial_Out => S_TX_Serial_Out,
		E_TRANSMITT_Busy => S_TRANSMITT_Busy
);  

C_GENERATE_PARITYBIT: E_GENERATE_PARITYBIT
PORT MAP
(
		E_GENERATE_PARITYBIT_Reset => S_TX_Reset,
		E_GENERATE_PARITYBIT_Clock_In => S_TX_Clock_In,	
		E_GENERATE_PARITYBIT_Start_Calc => S_GENERATE_PARITYBIT_Enable,
		E_GENERATE_PARITYBIT_Data => S_BUFFER_Data_Out,
		E_GENERATE_PARITYBIT_Paritiy_Out => S_GENERATE_PARITYBIT_Paritiy_Out, 		
		E_GENERATE_PARITYBIT_Busy => S_GENERATE_PARITYBIT_Busy
);

C_BUFFER: E_BUFFER
PORT MAP
(
		E_BUFFER_Reset => S_TX_Reset,
		E_BUFFER_Clock_In => S_TX_Clock_In,
		E_BUFFER_Data_In => S_TX_Data,
		E_BUFFER_Save => S_BUFFER_Save,
		E_BUFFER_Save_Busy => S_BUFFER_Save_Busy,		
		--E_BUFFER_Irq => S_BUFFER_Irqv -- TODO: implement!!
		--E_BUFFER_Length => S_BUFFER_Length,	
		E_BUFFER_Data_Out => S_BUFFER_Data_Out,		
		E_BUFFER_Load => S_BUFFER_Load,
		E_BUFFER_Load_Busy => S_BUFFER_Load_Busy			
);

S_TX_Reset <= E_TX_Reset;
S_TX_Clock_In <= E_TX_Clock_In;				
S_TX_Baudrate <= E_TX_Baudrate;						
S_TX_Enable <= E_TX_Enable;					
S_TX_One_or_two_Stoppbits <= E_TX_One_or_two_Stoppbits;			
S_TX_Paritybit <= E_TX_Paritybit;				
S_TX_Data <= E_TX_Data;	
E_TX_Serial_Out <= S_TX_Serial_Out; 
E_TX_Busy <= S_TX_Busy; 


	P1 : process (
		S_TX_Reset,
		S_TX_Clock_In
	)
	begin
			-- Resetfall
			IF(E_TX_RESET = '0')
			THEN
				S_TX_Busy <= '0';
				S_TX_Enable_old <= '0';
				S_TX_Do_Save <= '0';
				
				S_BUFFER_Load <= '0';
				S_GENERATE_PARITYBIT_Enable <= '0';
				S_TRANSMITT_Enable <= '0';
				S_BUFFER_LOAD_STATE <= 0;	
			
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_TX_Clock_In = '1' AND S_TX_Clock_In'EVENT)
			THEN
			  
			   -- Erkennung ob ein Datenbyte versendet werden soll
			   IF(S_TX_Enable = '1' and S_TX_Enable_old = '0')
				THEN
					S_TX_Do_Save <= '1';
				ELSE
				  S_TX_Enable_old	<= S_TX_Enable;
				END IF;
				
			   -- Abspeichern des Datenbytes im Buffer
				IF(S_TX_Do_Save = '1' and S_TX_Busy = '0')
				THEN
					S_TX_Busy <= '1';			  
					S_BUFFER_Save <= '1';			  
				ELSIF (S_TX_Busy = '1')
				THEN
					IF (S_BUFFER_Save_Busy = '0')
					THEN
							S_TX_Do_Save <= '0';
							S_TX_Busy <= '0';
					END IF;
				END IF;
			  
				-- Daten aus dem Buffer holen, Paritybit berechnen und versenden
				IF ((S_BUFFER_Load = '1' and S_BUFFER_Load_Busy = '0' and S_GENERATE_PARITYBIT_Enable = '1' and S_GENERATE_PARITYBIT_Busy = '0'	and S_TRANSMITT_Enable = '1' and S_TRANSMITT_Busy = '0'))-- or (S_BUFFER_LOAD_STATE = 6))
				THEN
					S_BUFFER_Load <= '0';
					S_GENERATE_PARITYBIT_Enable <= '0';
					S_TRANSMITT_Enable <= '0';
					S_BUFFER_LOAD_STATE <= 0;	
					
				ELSIF (S_BUFFER_LOAD_STATE = 0 and S_BUFFER_Length > 0)
				THEN
					S_BUFFER_Load <= '1';
					S_BUFFER_LOAD_STATE <= 1;
				
				ELSIF (S_BUFFER_LOAD_STATE = 1)
				THEN
					IF (S_BUFFER_Load_Busy = '0')
					THEN
					S_BUFFER_LOAD_STATE <= 2;
					END IF;
					
				ELSIF (S_BUFFER_LOAD_STATE = 2)
				THEN
					S_GENERATE_PARITYBIT_Enable <= '1';
					S_BUFFER_LOAD_STATE <= 3;
				
				ELSIF (S_BUFFER_LOAD_STATE = 3)
				THEN
					IF (S_GENERATE_PARITYBIT_Busy = '0')
					THEN
					S_BUFFER_LOAD_STATE <= 4;
					END IF;				


				ELSIF (S_BUFFER_LOAD_STATE = 4)
				THEN
					S_TRANSMITT_Enable <= '1';
					S_BUFFER_LOAD_STATE <= 5;
				
				ELSIF (S_BUFFER_LOAD_STATE = 5)
				THEN
					IF (S_TRANSMITT_Busy = '0')
					THEN
					S_BUFFER_LOAD_STATE <= 6;
					END IF;				
				END IF;
			  
			  
			END IF;
	end process;


		
end E_TX;

