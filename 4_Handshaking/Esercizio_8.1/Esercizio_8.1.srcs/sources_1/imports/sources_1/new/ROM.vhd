library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Memoria composta da N stringhe di M bit
entity ROM is
    Generic ( N : integer := 8;
              DIM : integer := 3;   
              M : integer := 4
    );
    Port(
        clk : in STD_LOGIC; 
        read : in STD_LOGIC; 
        addr : in STD_LOGIC_VECTOR(DIM-1 downto 0); 
        data : out STD_LOGIC_VECTOR(M-1 downto 0)
    );
end ROM;
 
architecture Behavioral of ROM is
	signal data_out : STD_LOGIC_VECTOR(M-1 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if read = '1' then
    			case addr is
    				when "000" => data_out <= "0001"; -- Locazione 0
    				when "001" => data_out <= "0010"; -- Locazione 1
    				when "010" => data_out <= "0100"; -- Locazione 2
    				when "011" => data_out <= "1000"; -- Locazione 3
    				when "100" => data_out <= "1001"; -- Locazione 4
    				when "101" => data_out <= "1010"; -- Locazione 5
    				when "110" => data_out <= "1100"; -- Locazione 6
    				when "111" => data_out <= "1111"; -- Locazione 7
    				when others => data_out <= "0000"; 
    			end case; 
    		end if; 
    	end if; 
    end process;
    data <= data_out;
end Behavioral;