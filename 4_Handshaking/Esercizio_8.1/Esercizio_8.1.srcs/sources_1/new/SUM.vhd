library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SUM is
    Generic (
        M : integer := 4  -- Numero di bit dei numeri da sommare
    );
    Port (
        clk  : in  STD_LOGIC;  -- Clock
        A    : in  STD_LOGIC_VECTOR(M-1 downto 0); -- Primo operando
        B    : in  STD_LOGIC_VECTOR(M-1 downto 0); -- Secondo operando
        SUM  : out STD_LOGIC_VECTOR(M-1 downto 0)  -- Risultato della somma
    );
end SUM;

architecture Behavioral of SUM is
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            SUM <= A + B;       
        end if;
    end process;
    
end Behavioral;
