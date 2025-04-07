library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sistema_UART_tb is
end Sistema_UART_tb;

architecture testbench of Sistema_UART_tb is

    -- Component under test (CUT)
    component Sistema_UART
        Port (
            START : in STD_LOGIC;
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC
        );
    end component;
    
    -- Signal declarations
    signal START_tb : STD_LOGIC := '0';
    signal RST_tb   : STD_LOGIC := '0';
    signal CLK_tb   : STD_LOGIC := '0';
    
    -- Clock period definition
    constant CLK_PERIOD : time := 1 ns;
    
begin
    
    -- Instantiate the CUT
    uut: Sistema_UART
        port map (
            START => START_tb,
            RST => RST_tb,
            CLK => CLK_tb
        );
    
    -- Clock process
    CLK_process: process
    begin
        while true loop
            CLK_tb <= '0';
            wait for CLK_PERIOD / 2;
            CLK_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin    
        -- Reset the system
        RST_tb <= '1';
        wait for 20 ns;
        RST_tb <= '0';
        
        -- Apply START signal
        wait for 30 ns;
        START_tb <= '1';
        wait for 40 ns;
        START_tb <= '0';
        
        -- More test cases can be added here
        
        wait;
    end process;
    
end testbench;
