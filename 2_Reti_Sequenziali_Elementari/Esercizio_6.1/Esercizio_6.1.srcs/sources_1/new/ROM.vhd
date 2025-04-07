library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
  Generic (N : integer := 8; ADDR_WIDTH : integer := 3);
  Port (
        CLK : in STD_LOGIC;
        READ : in STD_LOGIC;
        ADDR : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        DATA : out STD_LOGIC_VECTOR(7 downto 0)
   );
end ROM;

architecture Behavioral of ROM is
type rom_type is array (0 to N-1) of std_logic_vector(7 downto 0);
signal ROM : rom_type := (
                            "00000000", 
                            "00010000", 
                            "00100000", 
                            "00110000",
                            "01000000",
                            "01010000",
                            "01110000", 
                            "10000000"
                          );
attribute rom_style : string;
attribute rom_style of ROM : signal is "block";

begin
    process(CLK) begin
        if rising_edge(CLK) then
            if(READ = '1') then
                DATA <= ROM(to_integer(unsigned(ADDR)));
            end if;
        end if;
    end process;
end Behavioral;
