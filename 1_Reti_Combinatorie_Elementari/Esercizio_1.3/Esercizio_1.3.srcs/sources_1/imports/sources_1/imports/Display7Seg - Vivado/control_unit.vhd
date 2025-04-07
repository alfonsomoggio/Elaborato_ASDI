library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port ( 
		   clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
           load_sel : in  STD_LOGIC;
		   value8_in : in STD_LOGIC_VECTOR(7 downto 0); --valore acquisito mediante 8 switch
		   valuesel_in : in STD_LOGIC_VECTOR(5 downto 0);
		   valuesel_out : out STD_LOGIC_VECTOR(5 downto 0);
           value16_out : out STD_LOGIC_VECTOR(15 downto 0) --valore su 16 bit, formato dai due valori da 8 bit acquisiti
			  );
end control_unit;

architecture Behavioral of control_unit is

signal reg_value : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal reg_valuesel_out : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin


value16_out <= reg_value;
valuesel_out <= reg_valuesel_out;



main: process(clock)
begin

	if clock'event and clock = '1' then
	   if reset = '1' then
		  reg_value <= (others => '0');
	   else
		  if load_first_part = '1' then
			reg_value(7 downto 0) <= value8_in;
		  elsif load_second_part = '1' then
			reg_value(15 downto 8) <= value8_in;
		  elsif load_sel = '1' then
			reg_valuesel_out <= valuesel_in;
		  end if;
	 end if;
	end if;

end process;


end Behavioral;

