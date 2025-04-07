----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 17:01:19
-- Design Name: 
-- Module Name: Sistema_S - Behavioral
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

entity Sistema_S is
    Port(
		addr: in STD_LOGIC_VECTOR(3 downto 0); 
		out_final: out STD_LOGIC_VECTOR(3 downto 0)
	);   
end Sistema_S;

architecture Behavioral of Sistema_S is
-- Segnale di interconnessione 
	signal data_rom: STD_LOGIC_VECTOR(7 downto 0); 
begin
-- Dichirazione oggetti:
	ROM_16_8: entity work.ROM_16_8 -- Uso libreria work (contiene tutte le entità, architettura ecc che sono stati compilati nel progetto attuale)
		port map(
			addr => addr,
			data => data_rom
		);
	
	M: entity work.M
		port map(
			x => data_rom, 
			y => out_final
		);

end Behavioral;
