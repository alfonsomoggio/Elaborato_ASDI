library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
  Generic (N : integer := 8; ADDR_WIDTH : integer := 3);
  Port (
        CLK : in STD_LOGIC;
        WRITE : in STD_LOGIC;
        ADDR : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
   );
end MEM;

architecture Behavioral of MEM is
    type mem_type is array (0 to N-1) of std_logic_vector(3 downto 0);
    signal MEM : mem_type := (others => (others => '0')); -- Inizializza tutta la memoria a 0
begin
    process(CLK) begin
        if rising_edge(CLK) then
            if(WRITE = '1') then
                MEM(to_integer(unsigned(ADDR))) <= DATA_IN;
            end if;
        end if;
    end process;
    
    DATA_OUT <= MEM(conv_integer(ADDR));  -- lettura asincrona

end Behavioral;
