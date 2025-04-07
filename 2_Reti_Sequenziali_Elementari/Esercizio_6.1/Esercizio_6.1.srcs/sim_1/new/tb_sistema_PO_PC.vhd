library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_sistema_PO_PC is
end tb_sistema_PO_PC;

architecture testbench of tb_sistema_PO_PC is

    -- Componenti per il testbench
    component sistema_PO_PC
        Generic (N : integer := 8; ADDR_WIDTH : integer := 3);
        Port (  
            CLK    : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            START  : in  STD_LOGIC
        );
    end component;

    -- Segnali per il testbench
    signal CLK    : STD_LOGIC := '0';
    signal RESET  : STD_LOGIC := '0';
    signal START  : STD_LOGIC := '0';

    -- Ciclo del clock
    constant CLK_PERIOD : time := 10 ns;

begin

    -- U Instanziazione del componente sotto test
    uut: sistema_PO_PC
        Generic map (N => 8, ADDR_WIDTH => 3)
        Port map (
            CLK => CLK,
            RESET => RESET,
            START => START
        );

    -- Generazione del clock
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimoli per il testbench
    stimulus_process : process
    begin
        -- Reset del sistema
        RESET <= '1';
        START <= '0';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Avvio del processo con START
        START <= '1';
        wait for 20 ns;

        START <= '0';
        wait for 40 ns;

       
        -- Finiamo il test
        wait for 100 ns;


       
        wait;
    end process;

end testbench;
