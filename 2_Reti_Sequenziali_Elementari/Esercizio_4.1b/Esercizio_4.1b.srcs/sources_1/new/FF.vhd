library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF is
  Port (
        D : in STD_LOGIC;
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        Q : out STD_LOGIC
   );
end FF;

architecture Behavioral of FF is
    signal Q_reg : STD_LOGIC := '0';
begin
    process (CLK) 
    begin
        if (CLK'event and CLK='1') then
            if (RST = '1') then
                Q_reg <= '0';
            else
                Q_reg <= D;
            end if;
         end if;
    end process;
    
    Q <= Q_reg;

end Behavioral;
