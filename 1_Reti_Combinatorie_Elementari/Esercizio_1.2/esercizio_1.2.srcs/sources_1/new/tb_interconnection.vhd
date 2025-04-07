----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 17:20:27
-- Design Name: 
-- Module Name: tb_interconnection - Behavioral
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

entity tb_interconnection is
end tb_interconnection;

architecture tb of tb_interconnection is

    component interconnection
        port (
            sorgenti         : in std_logic_vector (15 downto 0);
            sorgenti_sel     : in std_logic_vector (3 downto 0);
            destinazioni_sel : in std_logic_vector (1 downto 0);
            destinazioni     : out std_logic_vector (3 downto 0)
        );
    end component;

    signal sorgenti         : std_logic_vector (15 downto 0) := (others => '0');
    signal sorgenti_sel     : std_logic_vector (3 downto 0) := (others => '0');
    signal destinazioni_sel : std_logic_vector (1 downto 0) := (others => '0');
    signal destinazioni     : std_logic_vector (3 downto 0);

begin

    uut : interconnection
        port map (
            sorgenti         => sorgenti,
            sorgenti_sel     => sorgenti_sel,
            destinazioni_sel => destinazioni_sel,
            destinazioni     => destinazioni
        );

    stim_proc: process
    begin
        -- Inizializzazione dei segnali
        sorgenti         <= "1010101010101010"; -- Valori iniziali per sorgenti
        sorgenti_sel     <= "0000"; -- Selezione iniziale delle sorgenti
        destinazioni_sel <= "00";  -- Selezione iniziale delle destinazioni
        wait for 100 ns;

        -- Stimoli per testare il comportamento

        sorgenti_sel <= "0101";
        destinazioni_sel <= "10"; 
        wait for 200 ns;
        
        sorgenti_sel     <= "0000"; 
        destinazioni_sel <= "00"; 
        wait for 100 ns;
        
        sorgenti_sel <= "0001"; 
        destinazioni_sel <= "01"; 
        wait for 200 ns;
        
        sorgenti_sel     <= "0000";
        destinazioni_sel <= "00"; 
        wait for 100 ns;

        sorgenti_sel <= "0011"; 
        destinazioni_sel <= "11"; 
        wait for 200 ns;
        
        sorgenti_sel     <= "0000"; 
        destinazioni_sel <= "00";  
        wait for 100 ns;

        wait;
    end process;

end tb;

