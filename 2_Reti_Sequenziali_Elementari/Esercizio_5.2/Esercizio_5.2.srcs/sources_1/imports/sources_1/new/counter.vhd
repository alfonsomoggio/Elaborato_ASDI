library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
  Generic (
        MAX_VALUE : integer := 59;
        DIM : integer := 6
  );
  
  Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        EN  : in STD_LOGIC;
        SET : in STD_LOGIC;
        SET_VALUE : in STD_LOGIC_VECTOR(DIM-1 downto 0);
        COUNT : out STD_LOGIC_VECTOR(DIM-1 downto 0);
        CARRY : out STD_LOGIC
  );
end counter;

architecture Behavioral of counter is
    signal count_tmp : STD_LOGIC_VECTOR(DIM-1 downto 0) := (others => '0');
begin
    process(CLK) begin
    if (RST = '1') then
        count_tmp <= (others => '0');
    elsif (CLK'event and CLK='1') then
        if (SET='1') then
            count_tmp <= SET_VALUE;
        elsif (EN='1') then
            if(count_tmp = CONV_STD_LOGIC_VECTOR(MAX_VALUE, DIM)) then
                count_tmp <= (others => '0');
            else
                count_tmp <= count_tmp + 1;
            end if;
         end if;
    end if;
    end process;
    
    COUNT <= count_tmp;
    CARRY <= '1' when (count_tmp = CONV_STD_LOGIC_VECTOR(MAX_VALUE, DIM)) else '0';

end Behavioral;
