library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calcola_G_P is
  Port (
        X : in STD_LOGIC_VECTOR(3 downto 0);
        Y : in STD_LOGIC_VECTOR(3 downto 0);
        P : out STD_LOGIC_VECTOR(3 downto 0);
        G : out STD_LOGIC_VECTOR(3 downto 0)
        );
end Calcola_G_P;

architecture Behavioral of Calcola_G_P is

begin
    G <= X and Y;
    P <= X xor Y;

end Behavioral;
