library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Calcola_Riporti is
  Port (
        
        G : in STD_LOGIC_VECTOR(3 downto 0);
        P : in STD_LOGIC_VECTOR(3 downto 0);
        Cin : in STD_LOGIC;
        C : out STD_LOGIC_VECTOR(4 downto 0)
         );
end Calcola_Riporti;

architecture Behavioral of Calcola_Riporti is
    
begin
    
    C(0) <= Cin;
    C(1) <= G(0) or (P(0) and Cin);
    C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
    C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
    C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);

end Behavioral;
