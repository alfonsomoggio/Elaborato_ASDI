library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port(
        clk : in STD_LOGIC; 
        read : in STD_LOGIC; 
        addr : in STD_LOGIC_VECTOR(2 downto 0); 
        data : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ROM;
 
architecture Behavioral of ROM is
	signal data_reg : STD_LOGIC_VECTOR(7 downto 0);
	
	type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);
    constant ROM : rom_type := (
        "00000001", 
        "00000010", 
        "00000011", 
        "00000100", 
        "00000101",
        "00000110",
        "00000111", 
        "00001000");
    
begin
	process(clk)
    begin
        if rising_edge(clk) then
            if READ = '1' then
                -- Legge il valore dalla ROM all'indirizzo specificato
                data_reg <= ROM(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
	
    data <= data_reg;
end Behavioral;