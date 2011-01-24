-- Funktionsbeschreibung:

-- Aus den logischen Werte der drei Eingangpins ermittelt die Funktion welcher logische Wert haeufiger
-- anliegt und gibt diesen zurueck. 

-- Pinbeschreibung:

	-- Eingaenge:
			--E_DECISION_Value1 					Wert 1
         --E_DECISION_Value2 					Wert 2
         --E_DECISION_Value3					Wert 3

	-- Ausgaenge:
         --E_DECISION_Result : 				Ausgabewert


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity E_DECISION is
    Port ( 
			E_DECISION_Value1 : 				IN  STD_LOGIC;
         E_DECISION_Value2 : 				IN  STD_LOGIC;
         E_DECISION_Value3 : 				IN  STD_LOGIC;
         E_DECISION_Result : 				OUT  STD_LOGIC);
end E_DECISION;

architecture A_DECISION of E_DECISION is
		
SIGNAL S_DECISION_Value1 : 	STD_LOGIC;
SIGNAL S_DECISION_Value2 :  	STD_LOGIC;
SIGNAL S_DECISION_Value3 :  	STD_LOGIC;
SIGNAL S_DECISION_Result :   	STD_LOGIC;
SIGNAL S_Array: 					STD_LOGIC_VECTOR(2 DOWNTO 0);

begin

S_Array(0) <= S_DECISION_Value3;
S_Array(1) <= S_DECISION_Value2;
S_Array(2) <= S_DECISION_Value1;


S_DECISION_Value1 <= E_DECISION_Value1;
S_DECISION_Value2 <= E_DECISION_Value2;
S_DECISION_Value3 <= E_DECISION_Value3;
E_DECISION_Result <= S_DECISION_Result;

  with S_Array select
      S_DECISION_Result <=    
				'0' when "000",
				'0' when "001",
				'0' when "010",
				'1' when "011",
				'0' when "100",
				'1' when "101",
				'0' when "110",
				'1' when "111",
				'0' when others;


end A_DECISION;

