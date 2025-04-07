library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_shift_register is
end tb_shift_register;

architecture testbench of tb_shift_register is
    constant N : integer := 8;
    signal SI         : STD_LOGIC := '0';
    signal RST        : STD_LOGIC := '0';
    signal CLK        : STD_LOGIC := '0';
    signal SHIFT_AMOUNT : integer range 0 to 1 := 0;
    signal SHIFT_MODE : STD_LOGIC := '0';
    signal SO         : STD_LOGIC_VECTOR(N-1 downto 0);
    
    constant clk_period : time := 20 ns;

    component shift_register_behavioral
        generic (N : integer := 8);
        port (
            SI         : in  STD_LOGIC;
            RST        : in  STD_LOGIC;
            CLK        : in  STD_LOGIC;
            SHIFT_AMOUNT : in integer range 0 to 1;
            SHIFT_MODE : in  STD_LOGIC;
            SO         : out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;

begin
   clk_process : process
   begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
   end process;

    uut: shift_register_behavioral
        generic map (N => N)
        port map (
            SI => SI,
            RST => RST,
            CLK => CLK,
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            SHIFT_MODE => SHIFT_MODE,
            SO => SO
        );

    process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for 10 ns;
        RST <= '0';
        wait for 10 ns;
        
        -- Shift a sinistra di 1 posizione
        SHIFT_MODE <= '1';
        SHIFT_AMOUNT <= 1;
        SI <= '1';
        wait for 20 ns;
        
        -- Shift a destra di 1 posizione
        SHIFT_MODE <= '0';
        SHIFT_AMOUNT <= 1;
        SI <= '1';
        wait for 20 ns;

        -- Shift a destra di 2 posizioni
        SHIFT_MODE <= '0';
        SHIFT_AMOUNT <= 2;
        SI <= '1';
        wait for 20 ns;
        
        -- Shift a sinistra di 2 posizioni
        SHIFT_MODE <= '1';
        SHIFT_AMOUNT <= 2;
        SI <= '1';
        wait for 20 ns;

        wait;
    end process;
end testbench;