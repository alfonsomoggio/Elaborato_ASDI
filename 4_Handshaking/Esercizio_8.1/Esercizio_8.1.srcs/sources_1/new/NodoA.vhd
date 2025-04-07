library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA is
  Port (
        START : in STD_LOGIC;
        CLK_A : in STD_LOGIC;
        RST : in STD_LOGIC;
        ACK : in STD_LOGIC;
        REQ : out STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
   );
end NodoA;

architecture Structural of NodoA is
    signal tmp_read_mem, tmp_en_count, tmp_load_reg, carry : STD_LOGIC;
    signal tmp_addr : STD_LOGIC_VECTOR(2 downto 0);
    signal mem_out : STD_LOGIC_VECTOR(3 downto 0);
    
    component ROM
        Generic ( N : integer;
                  DIM : integer;   
                  M : integer
        );
        Port(
            clk : in STD_LOGIC; 
            read : in STD_LOGIC; 
            addr : in STD_LOGIC_VECTOR(DIM-1 downto 0); 
            data : out STD_LOGIC_VECTOR(M-1 downto 0)
        ); 
    end component;
    
    component counter
        Generic (
            MAX_VALUE : integer;
            DIM : integer
        );
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
    
    component Registro
        Port (
            D : in STD_LOGIC_VECTOR(3 downto 0);
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            EN : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component UCA
        Port (
            CLK_A : in STD_LOGIC;
            RST : in STD_LOGIC;
            START : in STD_LOGIC;
            ACK : in STD_LOGIC;
            CONT_MAX : in STD_LOGIC;
            REQ: out STD_LOGIC;
            READ_MEM : out STD_LOGIC;
            EN_COUNT : out STD_LOGIC;
            LOAD_REG : out STD_LOGIC
        );
    end component;
    
begin

    MEM : ROM 
        Generic Map(N => 8, DIM => 3,  M => 4)
        Port Map(
            clk => CLK_A, 
            read => tmp_read_mem, 
            addr => tmp_addr,
            data => mem_out
        ); 
     
     COUNT : counter
        Generic Map(MAX_VALUE => 7, DIM => 3)
        Port Map( 
            CLK => CLK_A,
            RST => RST,
            EN => tmp_en_count,
            SET => '0',
            SET_VALUE => "000",
            COUNT => tmp_addr,
            CARRY => carry
        );
        
      REG : Registro
        Port Map(
            D => mem_out,
            CLK => CLK_A,
            RST => RST,
            EN => tmp_load_reg,
            Q => DATA_OUT
        );
      
      control_unit : UCA
        Port Map(
            CLK_A => CLK_A,
            RST => RST,
            START => START,
            ACK => ACK,
            CONT_MAX => carry,
            REQ => REQ,
            READ_MEM => tmp_read_mem,
            EN_COUNT => tmp_en_count,
            LOAD_REG => tmp_load_reg
        );
    
end Structural;
