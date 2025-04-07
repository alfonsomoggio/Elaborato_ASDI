library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sistema_PO_PC is
    Generic (
        N : integer := 8;
        ADDR_WIDTH : integer := 3
    );
    Port (
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        START  : in  STD_LOGIC;
        ROM_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        MEM_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end sistema_PO_PC;

architecture Structural of sistema_PO_PC is
    signal ADDR   : STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
    signal DATA_ROM : STD_LOGIC_VECTOR(7 downto 0);
    signal DATA_M : STD_LOGIC_VECTOR(3 downto 0);
    signal EN, READ, WRITE, CONT_MAX : STD_LOGIC;
    signal clock_out : STD_LOGIC;
    
    component clock_divider
        generic(
				clock_frequency_in : integer;
				clock_frequency_out : integer 
				);
        Port ( clock_in : in  STD_LOGIC;
               reset : in STD_LOGIC;
               clock_out : out  STD_LOGIC);
    end component;
    
    component ROM
        Generic (N : integer; ADDR_WIDTH : integer);
        Port(
            CLK : in STD_LOGIC;
            READ : in STD_LOGIC;
            ADDR : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
            DATA : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component M
        Port(
            x : in STD_LOGIC_VECTOR(7 downto 0); -- Ingresso a 8 bit
            y : out STD_LOGIC_VECTOR(3 downto 0) -- Uscita a 4 bit
           );
    end component;
    
    component MEM
        Generic (N : integer; ADDR_WIDTH : integer);
        Port (
            CLK : in STD_LOGIC;
            WRITE : in STD_LOGIC;
            ADDR : in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
            DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
            DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component counter
        Generic ( MAX_VALUE : integer; DIM : integer);
        Port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            EN  : in STD_LOGIC;
            SET : in STD_LOGIC;
            SET_VALUE : in STD_LOGIC_VECTOR(DIM-1 downto 0);
            COUNT : out STD_LOGIC_VECTOR(DIM-1 downto 0);
            CARRY : out STD_LOGIC
        );
    end component;
    
    component control_unit
        Port (
            CLK : in STD_LOGIC;
            START  : in STD_LOGIC; 
            RST : in STD_LOGIC;
            CONT_MAX  : in STD_LOGIC;
            EN  : out STD_LOGIC;
            READ  : out STD_LOGIC;
            WRITE  : out STD_LOGIC 
        );
    end component;
    
begin
    ROM_OUT <= DATA_ROM;
    
    
    divisore_frequenza : clock_divider
        Generic Map(clock_frequency_in => 10000000, clock_frequency_out => 1)
        Port Map(
            clock_in => CLK,
            reset => RESET,
            clock_out => clock_out
        );
    
    memoria_ROM : ROM
        Generic Map(N => N, ADDR_WIDTH => ADDR_WIDTH)
        Port Map(
            CLK => clock_out,
            READ => READ,
            ADDR => ADDR,
            DATA => DATA_ROM
        );
        
     macchina_M : M
        Port Map(
            x => DATA_ROM,
            y => DATA_M
        );
        
     memoria_MEM : MEM
        Generic Map(N => N, ADDR_WIDTH => ADDR_WIDTH)
        Port Map(
            CLK => clock_out,
            WRITE => WRITE,
            ADDR => ADDR,
            DATA_IN => DATA_M,
            DATA_OUT => MEM_OUT
        );
        
     contatore : counter
        Generic Map(MAX_VALUE => N-1, DIM => ADDR_WIDTH)
        Port Map( 
            CLK => clock_out,
            RST => RESET,
            EN => EN,
            SET => '0',
            SET_VALUE => (others => '0'),
            COUNT => ADDR,
            CARRY => CONT_MAX
        );
        
     u_c : control_unit
        Port Map(
            CLK => clock_out,
            START => START,
            RST => RESET,  
            CONT_MAX => CONT_MAX,
            EN => EN,
            READ => READ,
            WRITE  => WRITE 
        );

end Structural;
