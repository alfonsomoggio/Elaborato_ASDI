----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2025 10:50:11
-- Design Name: 
-- Module Name: tb_riconoscitore_101 - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.ALL;

entity tb_riconoscitore_101 is
end tb_riconoscitore_101;

architecture testbench of tb_riconoscitore_101 is

component riconoscitore_101
    port(
        i: in STD_LOGIC;
        A: in STD_LOGIC;
        M: in STD_LOGIC;
        RST: in std_logic;
        Y: out STD_LOGIC
        );
end component;

--inputs
signal i, A, M, RST: STD_LOGIC := '0';

--outputs
signal Y: STD_LOGIC;

--signal A period definition
constant A_period : time := 10 ns;

begin
    -- Istanziazione del DUT (Device Under Test)
    uut: riconoscitore_101 port map (
        i => i,
        A => A,
        M => M,
        RST => RST,
        Y => Y
    );

 -- A process definitions
   A_process :process
   begin
		A <= '0';
		wait for A_period/2;
		A <= '1';
		wait for A_period/2;
   end process;

    stim_proc: process
   begin		
      -- insert stimulus here 
        M<='1';
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 30 ns;
		
		M<='0';
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 30 ns;
		
      wait;
     end process;
end testbench;
