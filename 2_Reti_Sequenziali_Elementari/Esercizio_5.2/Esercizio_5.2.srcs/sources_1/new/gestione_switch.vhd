library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gestione_switch is
  Port (
        CLK : in STD_LOGIC;
        IMPOSTA_SEC : in STD_LOGIC;
        IMPOSTA_MIN : in STD_LOGIC;
        IMPOSTA_HR : in STD_LOGIC;
        SET_SWITCH : in STD_LOGIC_VECTOR(5 downto 0);
        ORARIO_COMPLETO : out STD_LOGIC_VECTOR(16 downto 0)
        );
end gestione_switch;

architecture Behavioral of gestione_switch is
    signal tmp_orario_completo : STD_LOGIC_VECTOR(16 downto 0);
begin
    
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (IMPOSTA_SEC = '1') then
                tmp_orario_completo(5 downto 0) <= set_switch; 
            elsif (IMPOSTA_MIN = '1') then
                tmp_orario_completo(11 downto 6) <= set_switch;
            elsif (IMPOSTA_HR = '1') then
                tmp_orario_completo(16 downto 12) <= set_switch(4 downto 0);
            end if;
        end if;
    
    end process;
    
    ORARIO_COMPLETO <= tmp_orario_completo;
    
end Behavioral;
