library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro is
  Port (
        D : in STD_LOGIC_VECTOR(3 downto 0);
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        EN : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(3 downto 0)
   );
end Registro;

architecture Behavioral of Registro is
    signal Q_reg : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin
    process (CLK) 
    begin
        if (CLK'event and CLK='1') then
            if (RST = '1') then
                Q_reg <= (others => '0');
            elsif (EN = '1') then
                Q_reg <= D;
            end if;
         end if;
    end process;
    
    Q <= Q_reg;

end Behavioral;
