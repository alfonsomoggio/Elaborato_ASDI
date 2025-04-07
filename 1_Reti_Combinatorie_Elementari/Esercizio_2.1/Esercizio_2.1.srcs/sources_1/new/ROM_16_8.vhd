----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 17:01:19
-- Design Name: 
-- Module Name: ROM_16_8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_16_8 is 
    Port(
		addr: in STD_LOGIC_VECTOR(3 downto 0); -- Indirizzo di 4 bit in ingresso (su 16 locazioni)
		data: out STD_LOGIC_VECTOR(7 downto 0) -- Uscita su 8 bit
	);
end ROM_16_8;

architecture Behavioral of ROM_16_8 is

begin
	-- Mappatura dei 4 bit sulle 16 celle, per poi produrre l'uscita a 8 bit
	with addr select -- Costrutto da evitare per ROM più grandi (nel caso usare metodo prof)
		data <= "00000001" when "0000", -- Locazione 0 => contenuto messo sul primo bit in uscita
				"00000010" when "0001", -- Locazione 1
                "00000100" when "0010", -- Locazione 2
                "00001000" when "0011", -- Locazione 3
                "00010000" when "0100", -- Locazione 4
                "00100000" when "0101", -- Locazione 5
                "01000000" when "0110", -- Locazione 6
                "10000000" when "0111", -- Locazione 7
                "10000001" when "1000", -- Locazione 8
                "10000010" when "1001", -- Locazione 9
                "10000100" when "1010", -- Locazione 10
                "10001000" when "1011", -- Locazione 11
                "10010000" when "1100", -- Locazione 12
                "10100000" when "1101", -- Locazione 13
                "11000000" when "1110", -- Locazione 14
                "10100000" when "1111", -- Locazione 15
                "--------" when others; -- Valore di default

end Behavioral;
