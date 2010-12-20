-- Funktionsbeschreibung:

-- Die E_UART gibt alle empfangenen Bytes an den LEDs aus. Beim Druecken des Joystick wird ein
-- Dummybyte ueber die TX-Leitung versendet. Das Low-Nibble des Dummybytes wird durch die
-- Schalter SW3-SW0 eingestellt. Das High-Nibble hat den Wert 0xF.

-- Pinbeschreibung

	-- Eingaenge:
		-- E_UART_Reset			Reset
		-- E_UART_Clock_In		Takt
		-- E_UART_Data_In			Low-Nibble des zu versendenden Dummybytes
		-- S_UART_Send				Positive Flanke versendet Dummybyte (Joystick)
		-- E_UART_Serial_In		RX

	-- Ausgaenge:
		-- E_UART_Data_Out		Letztes Datenbyte das ueber RX empfangen wurde 
		-- E_UART_Serial_Out		TX		
		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity E_UART is
	Port 
	( 
		E_UART_Reset: 				 		IN  STD_LOGIC;
		E_UART_Clock_In:					IN  STD_LOGIC;		
		E_UART_Data_In:					IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- 8 bit		
		E_UART_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_UART_Send:						IN  STD_LOGIC;			
		E_UART_Serial_In:					IN  STD_LOGIC;
		E_UART_Serial_Out:				OUT  STD_LOGIC
	);
end E_UART;


architecture A_UART of E_UART is
  
  
SIGNAL S_UART_Reset: 				 	STD_LOGIC;
SIGNAL S_UART_Clock_In:					STD_LOGIC;			
SIGNAL S_UART_Data_In:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit	
SIGNAL S_UART_Data_Out:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
SIGNAL S_UART_Send:						STD_LOGIC;	
SIGNAL S_UART_Serial_In:				STD_LOGIC;
SIGNAL S_UART_Serial_Out:				STD_LOGIC;

SIGNAL S_BAUD_GENERATOR_Baudrate: 			STD_LOGIC;
SIGNAL S_BAUD_GENERATOR_Baudrate_5x: 		STD_LOGIC;
SIGNAL S_BAUD_GENERATOR_Freq_Settings:		STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit
 
SIGNAL S_RX_Load: 			STD_LOGIC;
SIGNAL S_RX_Busy: 			STD_LOGIC; 
SIGNAL S_RX_irq: 				STD_LOGIC; 

SIGNAL S_Send_Old: 					STD_LOGIC;
SIGNAL S_Send_Event: 				STD_LOGIC; 
SIGNAL S_Send_Event_Handshake: 	STD_LOGIC;

  component E_BAUD_GENERATOR Port
    (
		E_BAUD_GENERATOR_Reset: 				IN  STD_LOGIC;
		E_BAUD_GENERATOR_Clock_In:				IN  STD_LOGIC;		
		E_BAUD_GENERATOR_Freq_Settings:		IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 bit		
		E_BAUD_GENERATOR_Baudrate: 			OUT STD_LOGIC;
		E_BAUD_GENERATOR_Baudrate_5x: 		OUT STD_LOGIC
	);
  end component;


component E_RX 
Port (
		E_RX_Reset: 				 		IN  STD_LOGIC;
		E_RX_Clock_In:						IN  STD_LOGIC;	
	   E_RX_Baudrate_5x: 				IN  STD_LOGIC;			
		E_RX_Load:							IN  STD_LOGIC;	
		E_RX_Busy:							OUT STD_LOGIC;	
		E_RX_Data_Parallel_Out:			OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RX_Data_Serial_In:				IN  STD_LOGIC;
		E_RX_irq:							OUT  STD_LOGIC
);
end component;
  
begin

S_UART_Reset <= E_UART_Reset;
S_UART_Clock_In <= E_UART_Clock_In;
S_UART_Data_In(3 DOWNTO 0) <= E_UART_Data_In;
S_UART_Data_In(7 DOWNTO 4) <= "1111";
E_UART_Data_Out <= S_UART_Data_Out;	
S_UART_Send <= E_UART_Send;
S_UART_Serial_In <= E_UART_Serial_In;	
E_UART_Serial_Out <= S_UART_Serial_Out;

S_BAUD_GENERATOR_Freq_Settings <= "000";


C_BAUD_GENERATOR: E_BAUD_GENERATOR PORT MAP
	(
		E_BAUD_GENERATOR_Reset => S_UART_Reset,
		E_BAUD_GENERATOR_Clock_In => S_UART_Clock_In,	
		E_BAUD_GENERATOR_Freq_Settings => S_BAUD_GENERATOR_Freq_Settings,	
		E_BAUD_GENERATOR_Baudrate => S_BAUD_GENERATOR_Baudrate,
		E_BAUD_GENERATOR_Baudrate_5x => S_BAUD_GENERATOR_Baudrate_5x 
	);


C_RX: E_RX 
PORT MAP (
		E_RX_Reset => S_UART_Reset,
		E_RX_Clock_In => S_UART_Clock_In,
	   E_RX_Baudrate_5x => S_BAUD_GENERATOR_Baudrate_5x,		
		E_RX_Load => S_RX_Load,	
		E_RX_Busy => S_RX_Busy,			
		E_RX_Data_Parallel_Out => S_UART_Data_Out,
		E_RX_Data_Serial_In => S_UART_Serial_In,
		E_RX_irq => S_RX_irq
);



	Send_Event_erkennen : process (
		S_UART_Reset,
		S_UART_Clock_In
	)
	begin
			-- Resetfall
			IF(S_UART_Reset = '0')
			THEN	
			S_Send_Old <= '0';
			S_Send_Event <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_UART_Clock_In = '1' AND S_UART_Clock_In'EVENT)
			THEN
				IF (S_UART_Send = '1' AND S_Send_Old = '0')
				THEN
				S_Send_Event <= '1';
				ELSIF (S_Send_Event_Handshake = '1')
				THEN
				S_Send_Event <= '0';
				ELSE
				-- Nothing to do
				END IF;
			S_Send_Old <= S_UART_Send;
			END IF;
	end process;


	Dummybyte_senden : process (
		S_UART_Reset,
		S_UART_Clock_In
	)
	begin
			-- Resetfall
			IF(S_UART_Reset = '0')
			THEN	
			S_Send_Event_Handshake <= '0';	
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_UART_Clock_In = '1' AND S_UART_Clock_In'EVENT)
			THEN
				IF (S_Send_Event = '1')
				THEN
				S_Send_Event_Handshake <= '1';
				ELSIF (S_Send_Event = '0' AND S_Send_Event_Handshake = '1')
				THEN
				S_Send_Event_Handshake <= '0';
				ELSE
				-- Nothing to do
				END IF;			
			ELSE
				-- Nothing to do
			END IF;
	end process;
	
	Empfangene_Werte_auslesen : process (
		S_UART_Reset,
		S_UART_Clock_In
	)
	begin
			-- Resetfall
			IF(S_UART_Reset = '0')
			THEN	
			S_Send_Event_Handshake <= '0';	
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_UART_Clock_In = '1' AND S_UART_Clock_In'EVENT)
			THEN
				IF (S_RX_irq = '1')
				THEN
				-- ToDo FSM
				S_Send_Event_Handshake <= '0';
				ELSE
				-- Nothing to do
				END IF;			
			ELSE
				-- Nothing to do
			END IF;
	end process;


end A_UART;

