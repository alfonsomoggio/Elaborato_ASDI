library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calcola_Somme is
  Port (
        P : in STD_LOGIC_VECTOR(3 downto 0);
        C : in STD_LOGIC_VECTOR(3 downto 0);
        S : out STD_LOGIC_VECTOR(3 downto 0)
        );
end Calcola_Somme;

architecture Behavioral of Calcola_Somme is
begin
    
    S <= P xor C;
        
end Behavioral;
