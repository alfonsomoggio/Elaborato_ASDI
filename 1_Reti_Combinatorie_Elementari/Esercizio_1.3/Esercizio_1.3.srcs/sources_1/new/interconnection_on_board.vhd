----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity interconnection_on_board is
	Port (
		  clock : in  STD_LOGIC; --clock board
		  reset : in  STD_LOGIC; --reset, associato a un bottone
		  load_first_part : in  STD_LOGIC; --comando di caricamento 8bit meno significativi, associato a un bottone
		  load_second_part : in  STD_LOGIC; --comando di caricaernto 8bit più significativi, associato a un bottone
		  load_sel : in  STD_LOGIC; 
		  value8_in : in STD_LOGIC_VECTOR(7 downto 0);
		  valuesel_in : in STD_LOGIC_VECTOR(5 downto 0);
		  led : out STD_LOGIC_VECTOR(3 downto 0)
		  );
end interconnection_on_board;

architecture Structural of interconnection_on_board is

COMPONENT control_unit
	PORT(
		   clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
           load_sel : in  STD_LOGIC;
		   value8_in : in STD_LOGIC_VECTOR(7 downto 0); --valore acquisito mediante 8 switch
		   valuesel_in : in STD_LOGIC_VECTOR(5 downto 0);
		   valuesel_out : out STD_LOGIC_VECTOR(5 downto 0); 

           value16_out : out STD_LOGIC_VECTOR(15 downto 0) --valore su 16 bit, formato dai due valori da 8 bit acquisiti
		);
END COMPONENT;

COMPONENT interconnection
    port(
             -- 16 sorgenti per il MUX + 4 selezioni
        sorgenti     : in STD_LOGIC_VECTOR(15 downto 0); 
        sorgenti_sel : in STD_LOGIC_VECTOR(3 downto 0); 
        -- 2 selezione per il DEMUX + 4 output
        destinazioni_sel : in STD_LOGIC_VECTOR(1 downto 0); 
        destinazioni     : out STD_LOGIC_VECTOR(3 downto 0)
    
    );
END COMPONENT;

signal cu_value : std_logic_vector(15 downto 0);
signal cu_valuesel : std_logic_vector(5 downto 0);

begin

cu: control_unit PORT MAP(
		clock => clock,
		reset => reset,
		load_first_part => load_first_part,
		load_second_part => load_second_part,
		load_sel => load_sel,
		value8_in => value8_in,
		valuesel_in => valuesel_in,
		valuesel_out => cu_valuesel,
		value16_out => cu_value
	);

i : interconnection  port map(
        sorgenti => cu_value,
        sorgenti_sel => cu_valuesel (5 downto 2),
        destinazioni_sel => cu_valuesel (1 downto 0),
        destinazioni => led
);

end Structural;

