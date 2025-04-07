library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port (
        i: in STD_LOGIC;
        sel_i : in STD_LOGIC;
        A: in STD_LOGIC;
        M: in STD_LOGIC;
        sel_m : in STD_LOGIC;
        i_out : out STD_LOGIC;
        M_out : out STD_LOGIC          
   );
end control_unit;


architecture Behavioral of control_unit is
    
    signal reg_i, reg_m : std_logic;

begin
    process (A) begin
        if (A'event and A='1') then
            if (sel_i = '1') then
                reg_i <= i;
            elsif (sel_M = '1') then
                reg_M <= M;
            end if;
        end if;
    end process;
        
    i_out <= reg_i;
    M_out <= reg_m;

end Behavioral;
