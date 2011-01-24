-- Funktionsbeschreibung:

-- Die E_Receive Entity hoert die RX-Datenleitung ab. Wenn ein Datenbyte ausgelesen werden kann ist die E_RX_irq
-- Leitung auf high. Der Auslesevorgang wird durch eine positive Flanke an E_RX_Load gestartet. Während
-- das E_RX_Busy-Flag auf high ist muss gewartet werden. Danach kann das Datenbyte an E_RX_Data_Parallel_Out ausgelesen
-- werden. Die RX-Leitung wird pro Bit 5 mal abgetastet. Wenn das E_RX_irq-Flag auf logisch low liegt und
-- es werden dennoch Daten ausgelesen, wird der letzte Wert erneut ausgelesen

-- Pinbeschreibung

	-- Eingaenge:
		-- E_RX_Reset						Reset
		-- E_RX_Clock_In					Takt
	   -- E_RX_Baudrate_5x				fuenfache Baudrate fuer Abtastvorgang	
		-- E_RX_Load						Loadflag, postive Flanke laedt neuen Wert, falls dieser vorhanden ist, ins Datenausgangsregister
		-- E_RX_Data_Serial_In			RX-Anschluss

	-- Ausgaenge:
		-- E_RX_Busy						Ladevorgang ist noch nicht abgeschlossen
		-- E_RX_Data_Parallel_Out		Datenbyte das empfangen wurde
		-- E_RX_irq							Logisch 1 wenn noch Daten ausgelesen werden koennen		
		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity E_RX is
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
end E_RX;

architecture A_RX of E_RX is

SIGNAL S_RX_Reset: 				 		STD_LOGIC;
SIGNAL S_RX_Clock_In:					STD_LOGIC;	
SIGNAL S_RX_Baudrate_5x: 				STD_LOGIC;		
SIGNAL S_RX_Load:							STD_LOGIC;	
SIGNAL S_RX_Busy:							STD_LOGIC;	
SIGNAL S_RX_Data_Parallel_Out:		STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_RX_Data_Serial_In:			STD_LOGIC;	
SIGNAL S_RX_irq:							STD_LOGIC;

-- State fuer Auslesen aus Buffer
SIGNAL S_RX_State:						STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 bit	
SIGNAL S_RX_Load_Old:					STD_LOGIC;
-- Positive Flanke signalisiert Ladeevent
SIGNAL S_RX_Load_Event:					STD_LOGIC;
-- Bestaetigung des Ladeevents
SIGNAL S_RX_Load_Event_Handshake:	STD_LOGIC;		
	
SIGNAL S_RECEIVE_Busy:					STD_LOGIC;	
SIGNAL S_RECEIVE_Data:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_RECEIVE_Paritybit:					STD_LOGIC;

-- Status zum Empfangen eines Datenbytes und das Abspeichern in den Buffer
SIGNAL S_RECEIVE_State:				STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 bit		

SIGNAL S_GENERATE_PARITYBIT_Start_Calc:		STD_LOGIC;	
SIGNAL S_GENERATE_PARITYBIT_Data:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
SIGNAL S_GENERATE_PARITYBIT_Paritiy_Out:		STD_LOGIC;		
SIGNAL S_GENERATE_PARITYBIT_Busy:				STD_LOGIC;	


SIGNAL S_BUFFER_Data_In:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
SIGNAL S_BUFFER_Save:					STD_LOGIC;
SIGNAL S_BUFFER_Save_Busy:				STD_LOGIC;	
SIGNAL S_BUFFER_Data_Out:				STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
SIGNAL S_BUFFER_Load:					STD_LOGIC;		
SIGNAL S_BUFFER_Load_Busy:				STD_LOGIC;

	
component E_RECEIVE 
Port (
		E_RECEIVE_Reset: 				 		IN  STD_LOGIC;
		E_RECEIVE_Clock_In:					IN  STD_LOGIC;		
		E_RECEIVE_Baudrate_5x:  			IN  STD_LOGIC;	
		E_RECEIVE_Paritybit:					OUT STD_LOGIC;	
		E_RECEIVE_Data_Parallel_Out:		OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit
		E_RECEIVE_Data_Serial_In:			IN  STD_LOGIC;
		E_RECEIVE_Busy:						OUT  STD_LOGIC
);
  end component;

component E_GENERATE_PARITYBIT
Port(
		E_GENERATE_PARITYBIT_Reset: 				 		IN  STD_LOGIC;
		E_GENERATE_PARITYBIT_Clock_In:					IN  STD_LOGIC;		
		E_GENERATE_PARITYBIT_Start_Calc:					IN  STD_LOGIC;	
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
		E_BUFFER_Irq:							OUT  STD_LOGIC;			
		E_BUFFER_Data_Out:					OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
		E_BUFFER_Load:							IN  STD_LOGIC;		
		E_BUFFER_Load_Busy:					OUT  STD_LOGIC	
);
end component;
	
	
begin


C_RECEIVE: E_RECEIVE 
PORT MAP 
(
		E_RECEIVE_Reset => S_RX_Reset,
		E_RECEIVE_Clock_In => S_RX_Clock_In,
	   E_RECEIVE_Baudrate_5x => S_RX_Baudrate_5x,
		E_RECEIVE_Paritybit => S_RECEIVE_Paritybit,
		E_RECEIVE_Data_Parallel_Out => S_RECEIVE_Data,
		E_RECEIVE_Data_Serial_In => S_RX_Data_Serial_In,
		E_RECEIVE_Busy => S_RECEIVE_Busy		
);  

C_GENERATE_PARITYBIT: E_GENERATE_PARITYBIT
PORT MAP
(
		E_GENERATE_PARITYBIT_Reset => S_RX_Reset,
		E_GENERATE_PARITYBIT_Clock_In => S_RX_Clock_In,	
		E_GENERATE_PARITYBIT_Start_Calc => S_GENERATE_PARITYBIT_Start_Calc,
		E_GENERATE_PARITYBIT_Data => S_GENERATE_PARITYBIT_Data,
		E_GENERATE_PARITYBIT_Paritiy_Out => S_GENERATE_PARITYBIT_Paritiy_Out, 		
		E_GENERATE_PARITYBIT_Busy => S_GENERATE_PARITYBIT_Busy
);

C_BUFFER: E_BUFFER
PORT MAP
(
		E_BUFFER_Reset => S_RX_Reset,
		E_BUFFER_Clock_In => S_RX_Clock_In,
		E_BUFFER_Data_In => S_BUFFER_Data_In,
		E_BUFFER_Save => S_BUFFER_Save,
		E_BUFFER_Save_Busy => S_BUFFER_Save_Busy,
		E_BUFFER_Irq => S_RX_irq,	
		E_BUFFER_Data_Out => S_BUFFER_Data_Out,		
		E_BUFFER_Load => S_BUFFER_Load,
		E_BUFFER_Load_Busy => S_BUFFER_Load_Busy		
);

S_RX_Reset <= E_RX_Reset ;
S_RX_Clock_In <= E_RX_Clock_In;	
S_RX_Baudrate_5x <= E_RX_Baudrate_5x;
E_RX_Busy <= S_RX_Busy; 			
S_RX_Load <= E_RX_Load;		
E_RX_Data_Parallel_Out <= S_RX_Data_Parallel_Out; -- 8 bit
S_RX_Data_Serial_In <= E_RX_Data_Serial_In;
E_RX_irq <= S_RX_irq;


	Load_Event_erkennen : process (
		S_RX_Reset,
		S_RX_Clock_In
	)
	begin
			-- Resetfall
			IF(S_RX_RESET = '0')
			THEN	
			S_RX_Load_Old <= '0';
			S_RX_Load_Event <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_RX_Clock_In = '1' AND S_RX_Clock_In'EVENT)
			THEN
				IF (S_RX_Load = '1' AND S_RX_Load_Old = '0')
				THEN
				S_RX_Load_Event <= '1';
				ELSIF (S_RX_Load_Event_Handshake = '1')
				THEN
				S_RX_Load_Event <= '0';
				ELSE
				-- Nothing to do
				END IF;
			S_RX_Load_Old <= S_RX_Load;
			END IF;
	end process;
	
	
	Daten_aus_Speicher_auslesen : process (
		S_RX_Reset,
		S_RX_Clock_In
	)
	begin
			-- Resetfall
			IF(S_RX_RESET = '0')
			THEN	
			S_RX_State <= "000";
			S_RX_Busy <= '0';
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_RX_Clock_In = '1' AND S_RX_Clock_In'EVENT)
			THEN
				-- Wenn Daten im Buffer sind und diese ausgelesen werden sollen, starte Ladevorgang
				IF (S_RX_State = "000" AND S_RX_Load_Event = '1' AND S_RX_irq = '1')
				THEN
				   S_RX_Load_Event_Handshake <= '1';
					S_BUFFER_Load <= '1';
					S_RX_Busy <= '1';
					S_RX_State <= "001"; 		
				-- Handshakeleitung reseten  
				ELSIF (S_RX_Load_Event = '0' AND S_RX_Load_Event_Handshake = '1')
				THEN
					S_RX_Load_Event_Handshake <= '0';
				-- Wenn die Daten ausgelesen wurden, oder keine Daten mehr im Buffer sind kann auf
				-- das Datenausgangsregister zugeriffen werden
				ELSIF ((S_RX_State = "001" AND S_BUFFER_Load_Busy = '0') OR S_RX_irq = '0' )
				THEN	
					S_RX_Data_Parallel_Out <= S_BUFFER_Data_Out;
					S_BUFFER_Load <= '0';
					S_RX_Busy <= '0';
					S_RX_State <= "000"; 
				ELSE
					-- Nothing to do
				END IF;
			END IF;
	end process;



	Daten_empfangen_und_abspeichern : process (
		S_RX_Reset,
		S_RX_Clock_In
	)
	begin
			-- Resetfall
			IF(S_RX_RESET = '0')
			THEN
				S_GENERATE_PARITYBIT_Start_Calc <= '0';
				S_RECEIVE_State <= "000";
			--	Main Loop wird bei jedem Taktereignis aufgerufen		
		   ELSIF (S_RX_Clock_In = '1' AND S_RX_Clock_In'EVENT)
			THEN
				-- Wenn Receive nicht beschaeftigt ist, Wert auslesen
				IF(S_RECEIVE_State = "000" AND S_RECEIVE_Busy = '0')
				THEN
					S_GENERATE_PARITYBIT_Data <= S_RECEIVE_Data;
					S_GENERATE_PARITYBIT_Start_Calc <= '1';
					S_RECEIVE_State <= "001";
				-- Paritybit berechnen
				ELSIF(S_RECEIVE_State = "001" AND S_GENERATE_PARITYBIT_Busy = '0')
				THEN
					S_GENERATE_PARITYBIT_Start_Calc <= '0';
					-- Paritybit ueberpruefen
					IF(S_GENERATE_PARITYBIT_Paritiy_Out = S_RECEIVE_Paritybit)
					THEN
						S_RECEIVE_State <= "010";						
				   ELSE
						-- ToDo, wenn Parity falsch ist wird das Byte verworfen	
						S_RECEIVE_State <= "000";						
					END IF;
				-- Wenn Buffer nicht beschaeftigt ist Wert abspeichern
				ELSIF(S_RECEIVE_State = "010" AND S_BUFFER_Save_Busy = '0')
				THEN
					S_BUFFER_Data_In <= S_RECEIVE_Data;
					S_BUFFER_Save <= '1';
					S_RECEIVE_State <= "011";					
				-- Warten bis Wert abgespeichert wurde und dann FSM reseten
				ELSIF(S_RECEIVE_State = "011" AND S_BUFFER_Save_Busy = '0')
				THEN				
					S_BUFFER_Save <= '0';
					S_RECEIVE_State <= "000";
				ELSE
					-- Nothing to do
				END IF;
				
				
			END IF;
	end process;

	

end A_RX;

