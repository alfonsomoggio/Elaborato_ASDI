library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity M is
    Port(
        x : in STD_LOGIC_VECTOR(7 downto 0); -- Ingresso a 8 bit
        y : out STD_LOGIC_VECTOR(3 downto 0) -- Uscita a 4 bit
       );
end M;


architecture Behavioral of M is -- Mettere in uscita solo i 4 MSB
	
begin
	y <= x(7 downto 4); 
    
end Behavioral;
