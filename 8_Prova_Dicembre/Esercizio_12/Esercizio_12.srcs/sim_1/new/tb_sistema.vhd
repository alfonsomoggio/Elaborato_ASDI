library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sistema_tb is
end Sistema_tb;

architecture testbench of Sistema_tb is

    signal CLK_A : STD_LOGIC := '0';
    signal CLK_B : STD_LOGIC := '0';
    signal RST : STD_LOGIC := '1';
    signal START : STD_LOGIC := '0';
    signal DATA_OUT : STD_LOGIC_VECTOR(3 downto 0);

    constant CLK_A_PERIOD : time := 10 ns; 
    constant CLK_B_PERIOD : time := 20 ns;

    component Sistema
        Port (
            CLK_A : in STD_LOGIC;
            CLK_B : in STD_LOGIC;
            RST : in STD_LOGIC;
            START : in STD_LOGIC;
            DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin

    UUT: Sistema
        port map (
            CLK_A => CLK_A,
            CLK_B => CLK_B,
            RST => RST,
            START => START,
            DATA_OUT => DATA_OUT
        );

    -- Processo per generare il clock A
    process
    begin
        while true loop
            CLK_A <= '0';
            wait for CLK_A_PERIOD / 2;
            CLK_A <= '1';
            wait for CLK_A_PERIOD / 2;
        end loop;
    end process;

    -- Processo per generare il clock B
    process
    begin
        while true loop
            CLK_B <= '0';
            wait for CLK_B_PERIOD / 2;
            CLK_B <= '1';
            wait for CLK_B_PERIOD / 2;
        end loop;
    end process;

    -- Stimolo del testbench
    process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for 50 ns;
        RST <= '0';

        -- Attivazione del segnale START
        wait for 20 ns;
        START <= '1';
        wait for 20 ns;
        START <= '0';

        -- Attendere per osservare il comportamento
        wait for 500 ns;
        
        -- Fine della simulazione
        wait;
    end process;

end testbench;
