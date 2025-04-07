library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Handshaking_tb is
end Handshaking_tb;

architecture testbench of Handshaking_tb is

    signal CLK_A, CLK_B, START, RST : STD_LOGIC := '0';
    
    constant CLK_PERIOD_A : time := 10 ns;
    constant CLK_PERIOD_B : time := 15 ns;
    
    component Handshaking
        Port (
            CLK_A : in STD_LOGIC;
            CLK_B : in STD_LOGIC;
            START : in STD_LOGIC;
            RST : in STD_LOGIC
        );
    end component;
    
begin
    
    -- Instanza del DUT (Device Under Test)
    DUT: Handshaking
        port map (
            CLK_A => CLK_A,
            CLK_B => CLK_B,
            START => START,
            RST => RST
        );
    
    -- Processo per generare il clock A
    process
    begin
        while true loop
            CLK_A <= '0';
            wait for CLK_PERIOD_A/2;
            CLK_A <= '1';
            wait for CLK_PERIOD_A/2;
        end loop;
    end process;
    
    -- Processo per generare il clock B
    process
    begin
        while true loop
            CLK_B <= '0';
            wait for CLK_PERIOD_B/2;
            CLK_B <= '1';
            wait for CLK_PERIOD_B/2;
        end loop;
    end process;
    
    -- Processo di test
    process
    begin
        -- Reset iniziale
        RST <= '1';
        START <= '0';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- Avvio della comunicazione
        START <= '1';
        wait for 50 ns;
        START <= '0';
        
        -- Attendere il completamento della trasmissione
        wait for 200 ns;
        
        -- Fine simulazione
        wait;
    end process;
    
end testbench;
