library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity convertitore_bin_bcd is
    Port ( 
        BIN_IN  : in  STD_LOGIC_VECTOR(5 downto 0); -- Numero binario in input (0-59)
        BCD_OUT : out STD_LOGIC_VECTOR(7 downto 0) -- Output BCD (due cifre)
    );
end convertitore_bin_bcd;

architecture Behavioral of convertitore_bin_bcd is
begin
    process(BIN_IN)
        variable tens : integer := 0;
        variable ones : integer := 0;
    begin
        tens := (conv_integer(BIN_IN) / 10);
        ones := (conv_integer(BIN_IN) mod 10);
        BCD_OUT <= conv_std_logic_vector(tens, 4) & conv_std_logic_vector(ones, 4);
    end process;
end Behavioral;
