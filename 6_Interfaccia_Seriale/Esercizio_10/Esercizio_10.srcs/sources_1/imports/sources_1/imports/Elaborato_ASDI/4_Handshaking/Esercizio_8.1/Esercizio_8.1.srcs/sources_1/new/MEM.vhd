library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM is
  Port(
        clk : in STD_LOGIC; 
        read : in STD_LOGIC;
        write : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        addr : in STD_LOGIC_VECTOR(2 downto 0); 
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end MEM;

architecture Behavioral of MEM is
    -- Definizione della memoria come array di N locazioni di M bit
    type memory_type is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    
    signal mem : memory_type := (others => "00000000");  -- Inizializzazione della memoria

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if write = '1' then
                mem(CONV_INTEGER(addr)) <= data_in;
            elsif read = '1' then
                data_out <= mem(CONV_INTEGER(addr));
            end if;
        end if;
    end process;
end Behavioral;
