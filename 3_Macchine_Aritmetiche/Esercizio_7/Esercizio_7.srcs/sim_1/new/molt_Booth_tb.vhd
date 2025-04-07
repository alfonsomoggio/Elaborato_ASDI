LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_molt_Booth IS
END tb_molt_Booth;

ARCHITECTURE testbench OF tb_molt_Booth IS 

    COMPONENT molt_Booth
        PORT (
            clock, reset, start : IN STD_LOGIC;
            X, Y : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            P : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL clock, reset, start : STD_LOGIC := '0';
    SIGNAL X, Y : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL P : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    CONSTANT clk_period : TIME := 20 ns;
    
BEGIN
    
    DUT : molt_Booth
        PORT MAP (
            clock => clock,
            reset => reset,
            start => start,
            X => X,
            Y => Y,
            P => P
        );
    
    clock_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            clock <= '0';
            WAIT FOR clk_period / 2;
            clock <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;
    
    stim_proc: PROCESS
    BEGIN		
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;
        
        -- Test case 1: 3 * 2
        X <= "00000011"; -- 3
        Y <= "00000010"; -- 2
        WAIT FOR 40 ns;
        start <= '1';
        WAIT FOR 20 ns;
        start <= '0';
        WAIT FOR 700 ns;
        
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;
        
        -- Test case 2: -4 * 3
        X <= "11111100"; -- -4 (Two's complement)
        Y <= "00000011"; -- 3
        WAIT FOR 40 ns;
        start <= '1';
        WAIT FOR 20 ns;
        start <= '0';
        WAIT FOR 700 ns;
        
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 20 ns;
        
        -- Test case 3: -5 * -6
        X <= "11111011"; -- -5
        Y <= "11111010"; -- -6
        WAIT FOR 40 ns;
        start <= '1';
        WAIT FOR 20 ns;
        start <= '0';
        WAIT FOR 700 ns;
        
        WAIT;
    END PROCESS;
    
END testbench;
