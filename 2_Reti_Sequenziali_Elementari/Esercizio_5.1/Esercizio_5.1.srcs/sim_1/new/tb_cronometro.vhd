LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_cronometro IS
END tb_cronometro;

ARCHITECTURE testbench OF tb_cronometro IS
    
    -- Component declaration for the Unit Under Test (UUT)
    COMPONENT cronometro
    PORT(
        CLK : IN  STD_LOGIC;
        RST : IN  STD_LOGIC;
        SET : IN  STD_LOGIC;
        SET_SEC : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        SET_MIN : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        SET_HR  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        SEC : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        MIN : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        HR  : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
    END COMPONENT;
    
    -- Signals
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL SET : STD_LOGIC := '0';
    SIGNAL SET_SEC : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SET_MIN : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SET_HR  : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SEC : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL MIN : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL HR  : STD_LOGIC_VECTOR(4 DOWNTO 0);
    
    -- Clock period definition
    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: cronometro PORT MAP (
        CLK => CLK,
        RST => RST,
        SET => SET,
        SET_SEC => SET_SEC,
        SET_MIN => SET_MIN,
        SET_HR => SET_HR,
        SEC => SEC,
        MIN => MIN,
        HR => HR
    );

    -- Clock process definitions
    CLK_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR CLK_PERIOD/2;
            CLK <= '1';
            WAIT FOR CLK_PERIOD/2;
        END LOOP;
    END PROCESS;
    
    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Reset the system
        RST <= '1';
        WAIT FOR 20 ns;
        RST <= '0';
        WAIT FOR 100 ns;
        
        -- Set the initial time
        SET <= '1';
        SET_SEC <= "101101"; -- 45 seconds
        SET_MIN <= "011110"; -- 30 minutes
        SET_HR  <= "01100";  -- 12 hours
        WAIT FOR 20 ns;
        SET <= '0';
        
        -- Run simulation for some time
        WAIT FOR 500 ns;
        
        -- End simulation
        WAIT;
    END PROCESS;
END testbench;
