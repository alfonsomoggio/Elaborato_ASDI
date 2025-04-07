library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gestione_priorita is
  Port (
        dest_0 : in STD_LOGIC_VECTOR(1 downto 0);
        dest_1 : in STD_LOGIC_VECTOR(1 downto 0);
        dest_2 : in STD_LOGIC_VECTOR(1 downto 0);
        dest_3 : in STD_LOGIC_VECTOR(1 downto 0);
        attiva_0 : in STD_LOGIC;
        attiva_1 : in STD_LOGIC;
        attiva_2 : in STD_LOGIC;
        attiva_3 : in STD_LOGIC;
        src : out STD_LOGIC_VECTOR(1 downto 0);
        dst : out STD_LOGIC_VECTOR(1 downto 0)
    );
end gestione_priorita;

architecture Behavioral of gestione_priorita is

    signal richiesta_attiva : STD_LOGIC_VECTOR(3 downto 0);
    signal indice_sorgente : STD_LOGIC_VECTOR(1 downto 0);

begin

    richiesta_attiva <= attiva_3 & attiva_2 & attiva_1 & attiva_0;
    
    process(richiesta_attiva)
    begin
        if richiesta_attiva(0) = '1' then         
            indice_sorgente <= "00";
        elsif richiesta_attiva(1) = '1' then      
            indice_sorgente <= "01";
        elsif richiesta_attiva(2) = '1' then       
            indice_sorgente <= "10";
        elsif richiesta_attiva(3) = '1' then       
            indice_sorgente <= "11";
        else
            indice_sorgente <= "00";               
        end if;
    end process;
    
    -- selezioniamo la sorgente in base alla priorità
    src <= indice_sorgente;
    
    process(indice_sorgente, dest_0, dest_1, dest_2, dest_3)
    begin
        case indice_sorgente is
            when "00" =>
                dst <= dest_0;
            when "01" =>
                dst <= dest_1;
            when "10" =>
                dst <= dest_2;
            when "11" =>
                dst <= dest_3;
            when others =>
                dst <= "00";
        end case;
    end process;
    
end Behavioral;
