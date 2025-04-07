library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_register_tb is
end shift_register_tb;

architecture test of shift_register_tb is

    constant N : integer := 5;
    signal Sx_in, Dx_in, CLK, RST, SHIFT_MODE, SHIFT_AMOUNT : STD_LOGIC;
    signal Q : STD_LOGIC_VECTOR(N-1 downto 0);

    component shift_register_structural
        Generic (N : integer := 5);
        Port (
            Sx_in : in STD_LOGIC;
            Dx_in : in STD_LOGIC;
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            SHIFT_MODE : in STD_LOGIC;
            SHIFT_AMOUNT : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;

begin

    uut: shift_register_structural
        generic map (N => N)
        port map (
            Sx_in => Sx_in,
            Dx_in => Dx_in,
            CLK => CLK,
            RST => RST,
            SHIFT_MODE => SHIFT_MODE,
            SHIFT_AMOUNT => SHIFT_AMOUNT,
            Q => Q
        );

    -- Clock process
    process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    process
    begin
        -- Reset
        RST <= '1';
        Sx_in <= '0';
        Dx_in <= '0';
        SHIFT_MODE <= '0';
        SHIFT_AMOUNT <= '0';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;

        -- Shift Right by 1
        Sx_in <= '1';
        SHIFT_MODE <= '1';
        SHIFT_AMOUNT <= '0';
        wait for 20 ns;

        -- Shift Right by 2
        Sx_in <= '0'; 
        SHIFT_AMOUNT <= '1';
        wait for 20 ns;

        -- Shift Left by 1
        Dx_in <= '1';
        SHIFT_MODE <= '0';
        SHIFT_AMOUNT <= '0';
        wait for 20 ns;

        -- Shift Left by 2
        Dx_in <= '0';
        SHIFT_AMOUNT <= '1';
        wait for 20 ns;
        
        -- Stop Simulation
        wait;
    end process;

end test;
