-- ToDo -> Diese Entity ist bisher nur ein Dummy.


-- Pinbeschreibung:

	-- Eingaenge:
		-- E_BUFFER_Reset					Reset
		-- E_BUFFER_Clock_In				Takt
		-- E_BUFFER_Data_In				Datenbyte das abgespeichert werden soll
		-- E_BUFFER_Save					Startbefehl des Speichervorgangs		
		-- E_BUFFER_Load					Startbefehl des Ladesvorgangs	

	-- Ausgaenge:
		-- E_BUFFER_Save_Busy			Speichervorgang ist noch aktiv
		-- E_BUFFER_irq					Logisch high = Es sind noch Daten im Buffer	
		-- E_BUFFER_Data_Out				Datenbyte das geladen wurde	
		-- E_BUFFER_Load_Busy:			Ladevorgang ist noch aktiv				
			
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity E_BUFFER is
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
end E_BUFFER;

architecture A_BUFFER of E_BUFFER is


SIGNAL	S_BUFFER_Reset: 				 		STD_LOGIC;
SIGNAL	S_BUFFER_Clock_In:					STD_LOGIC;	
SIGNAL	S_BUFFER_Data_In:						STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
SIGNAL	S_BUFFER_Save:							STD_LOGIC;
SIGNAL	S_BUFFER_Save_Busy:					STD_LOGIC;		
SIGNAL	S_BUFFER_Irq:							STD_LOGIC;			
SIGNAL	S_BUFFER_Data_Out:					STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit		
SIGNAL	S_BUFFER_Load:							STD_LOGIC;		
SIGNAL	S_BUFFER_Load_Busy:					STD_LOGIC;	

SIGNAL	S_Buffer_Content:						INTEGER;

SIGNAL 	S_Save_Old:								STD_LOGIC;	
SIGNAL 	S_Save_Event:							STD_LOGIC;	
SIGNAL	S_Save_Event_Handshake:				STD_LOGIC;	


SIGNAL 	S_Load_Old:								STD_LOGIC;	
SIGNAL 	S_Load_Event:							STD_LOGIC;	
SIGNAL	S_Load_Event_Handshake:				STD_LOGIC;	

begin

S_BUFFER_Reset	<= E_BUFFER_Reset;
S_BUFFER_Clock_In	<= E_BUFFER_Clock_In;
S_BUFFER_Data_In <= E_BUFFER_Data_In;	
S_BUFFER_Save <= E_BUFFER_Save;
E_BUFFER_Save_Busy <= S_BUFFER_Save_Busy;
E_BUFFER_Irq <= S_BUFFER_Irq;		
E_BUFFER_Data_Out	<= S_BUFFER_Data_Out;	
S_BUFFER_Load	<= E_BUFFER_Load;		
E_BUFFER_Load_Busy <= S_BUFFER_Load_Busy;


	Irq_setzen_wenn_noch_Daten_vorhanden_sind : process (
		S_BUFFER_Reset,
		S_BUFFER_Clock_In
	)
	begin
			-- Resetfall
			IF(S_BUFFER_Reset = '0')
			THEN	
			S_BUFFER_Irq <= '0';
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_BUFFER_Clock_In = '1' AND S_BUFFER_Clock_In'EVENT)
			THEN
				IF (S_Buffer_Content > 0)
				THEN
					S_BUFFER_Irq <= '1';
				ELSE
					S_BUFFER_Irq <= '0';
				END IF;
			END IF;
	end process;


	Save_Event_erkennen : process (
		S_BUFFER_Reset,
		S_BUFFER_Clock_In
	)
	begin
			-- Resetfall
			IF(S_BUFFER_Reset = '0')
			THEN	
			S_Save_Old <= '0';
			S_Save_Event <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_BUFFER_Clock_In = '1' AND S_BUFFER_Clock_In'EVENT)
			THEN
				IF (S_BUFFER_Save = '1' AND S_Save_Old = '0')
				THEN
				S_Save_Event <= '1';
				ELSIF (S_Save_Event_Handshake = '1')
				THEN
				S_Save_Event <= '0';
				ELSE
				-- Nothing to do
				END IF;
			S_Save_Old <= S_BUFFER_Save;
			END IF;
	end process;


	Load_Event_erkennen : process (
		S_BUFFER_Reset,
		S_BUFFER_Clock_In
	)
	begin
			-- Resetfall
			IF(S_BUFFER_Reset = '0')
			THEN	
			S_Load_Old <= '0';
			S_Load_Event <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_BUFFER_Clock_In = '1' AND S_BUFFER_Clock_In'EVENT)
			THEN
				IF (S_BUFFER_Load = '1' AND S_Load_Old = '0')
				THEN
				S_Load_Event <= '1';
				ELSIF (S_Load_Event_Handshake = '1')
				THEN
				S_Load_Event <= '0';
				ELSE
				-- Nothing to do
				END IF;
			S_Load_Old <= S_BUFFER_Load;
			END IF;
	end process;

-- ToDo hier Code ersetzen

	Dummy : process (
		S_BUFFER_Reset,
		S_BUFFER_Clock_In
	)
	begin
			-- Resetfall
			IF(S_BUFFER_Reset = '0')
			THEN	
			S_Save_Event_Handshake <= '0';
			S_Load_Event_Handshake <= '0';			
			--	Main Loop wird bei jedem Taktereignis aufgerufen			
		   ELSIF (S_BUFFER_Clock_In = '1' AND S_BUFFER_Clock_In'EVENT)
			THEN
				IF (S_Save_Event = '1')
				THEN
				S_Save_Event_Handshake <= '1';
				ELSIF (S_Save_Event = '0' AND S_Save_Event_Handshake = '1')
				THEN
				S_Save_Event_Handshake <= '0';
				ELSIF (S_Load_Event = '1')
				THEN
				S_Load_Event_Handshake <= '1';
				ELSIF (S_Load_Event = '0' AND S_Load_Event_Handshake = '1')
				THEN
				S_Load_Event_Handshake <= '0';
				ELSE
				-- Nothing to do
				END IF;			
			ELSE
				-- Nothing to do
			END IF;
	end process;


S_Buffer_Content <= 1;
S_BUFFER_Data_Out <= S_BUFFER_Data_In;
S_BUFFER_Save_Busy <= '0';
S_BUFFER_Load_Busy <= '0';

end A_BUFFER;

