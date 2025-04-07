----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 17:20:50
-- Design Name: 
-- Module Name: tb_sistemaS - Behavioral
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

entity tb_Sistema_S is
end tb_Sistema_S;

architecture tb of tb_Sistema_S is

    component Sistema_S
        port (
            addr      : in std_logic_vector (3 downto 0);
            out_final : out std_logic_vector (3 downto 0)
        );
    end component;

    signal addr      : std_logic_vector (3 downto 0) := (others => '0');
    signal out_final : std_logic_vector (3 downto 0);

begin

    uut : Sistema_S
        port map (
            addr      => addr,
            out_final => out_final
        );

    stim_proc: process
    begin
        -- Inizializzazione dei segnali
        addr <= "0000"; -- Indirizzo iniziale

        wait for 100 ns;

        -- Stimoli per testare il comportamento
        addr <= "0001"; -- Indirizzo 1
        wait for 10 ns;

        addr <= "0110"; -- Indirizzo 2
        wait for 10 ns;

        addr <= "1100"; -- Indirizzo 3
        wait for 10 ns;

        addr <= "1101"; -- Indirizzo 4
        wait for 10 ns;

        wait;
    end process;

end tb;

