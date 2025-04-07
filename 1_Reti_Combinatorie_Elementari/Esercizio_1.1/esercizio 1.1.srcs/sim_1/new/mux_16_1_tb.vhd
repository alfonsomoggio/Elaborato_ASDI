----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2025 16:58:15
-- Design Name: 
-- Module Name: mux_16_1_tb - Behavioral
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

entity tb_mux_16_1 is
end tb_mux_16_1;

architecture tb of tb_mux_16_1 is

    -- Dichiarazione del componente mux_16_1
    component mux_16_1
        port (
            b0  : in std_logic;
            b1  : in std_logic;
            b2  : in std_logic;
            b3  : in std_logic;
            b4  : in std_logic;
            b5  : in std_logic;
            b6  : in std_logic;
            b7  : in std_logic;
            b8  : in std_logic;
            b9  : in std_logic;
            b10 : in std_logic;
            b11 : in std_logic;
            b12 : in std_logic;
            b13 : in std_logic;
            b14 : in std_logic;
            b15 : in std_logic;
            s0  : in std_logic;
            s1  : in std_logic;
            s2  : in std_logic;
            s3  : in std_logic;
            y0  : out std_logic
        );
    end component;

    -- Segnali di test
    signal input  : std_logic_vector(15 downto 0) := (others => '0');
    signal control : std_logic_vector(3 downto 0) := (others => '0');
    signal output : std_logic := '0';

begin

    -- Istanza del multiplexer 16:1
    uut: mux_16_1
        port map (
            b0  => input(0),
            b1  => input(1),
            b2  => input(2),
            b3  => input(3),
            b4  => input(4),
            b5  => input(5),
            b6  => input(6),
            b7  => input(7),
            b8  => input(8),
            b9  => input(9),
            b10 => input(10),
            b11 => input(11),
            b12 => input(12),
            b13 => input(13),
            b14 => input(14),
            b15 => input(15),
            s0  => control(0),
            s1  => control(1),
            s2  => control(2),
            s3  => control(3),
            y0  => output
        );

    -- Processo di stimolo
    stim_proc: process
    begin
        wait for 100 ns;

        -- Imposta i valori di input e selezione
        input <= "1010101010101010"; -- Alterna ingressi 1 e 0

        -- Test per selezioni
        control <= "0000"; -- Seleziona b0 (1)
        wait for 10 ns;

        control <= "0001"; -- Seleziona b1 (0)
        wait for 10 ns;

        control <= "0010"; -- Seleziona b2 (1)
        wait for 10 ns;

        control <= "0011"; -- Seleziona b3 (0)
        wait for 10 ns;
        
        wait; -- Termina la simulazione
    end process;

end tb;
