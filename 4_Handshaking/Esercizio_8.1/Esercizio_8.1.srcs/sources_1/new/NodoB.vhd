library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoB is
  Port (
        CLK_B : in STD_LOGIC;
        RST : in STD_LOGIC;
        DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
        REQ : in STD_LOGIC;
        ACK : out STD_LOGIC
   );
end NodoB;

architecture Structural of NodoB is
    signal tmp_read_mem, tmp_write_mem, tmp_en_count, tmp_load_reg, en_sum : STD_LOGIC;
    signal tmp_addr : STD_LOGIC_VECTOR(2 downto 0);
    signal mem_out, tmp_reg_out, tmp_sum_out : STD_LOGIC_VECTOR(3 downto 0);
    
    component MEM
        Generic(   
            N : integer;
            DIM : integer;   
            M : integer
        );
        Port(
            clk : in STD_LOGIC; 
            read : in STD_LOGIC;
            write : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(M-1 downto 0);
            addr : in STD_LOGIC_VECTOR(DIM-1 downto 0); 
            data_out : out STD_LOGIC_VECTOR(M-1 downto 0)
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
    
    component UCB
        Port (
            CLK_B : in STD_LOGIC;
            RST : in STD_LOGIC;
            REQ : in STD_LOGIC;
            COUNT : in STD_LOGIC_VECTOR(2 downto 0);
            ACK: out STD_LOGIC;
            READ_MEM : out STD_LOGIC;
            WRITE_MEM : out STD_LOGIC;
            EN_COUNT : out STD_LOGIC;
            EN_SUM : out STD_LOGIC;
            LOAD_REG : out STD_LOGIC
        );
    end component;
        
    component SUM 
        Generic (
            M : integer  -- Numero di bit dei numeri da sommare
        );
        Port (
            clk  : in  STD_LOGIC;  -- Clock
            A    : in  STD_LOGIC_VECTOR(M-1 downto 0); -- Primo operando
            B    : in  STD_LOGIC_VECTOR(M-1 downto 0); -- Secondo operando
            SUM  : out STD_LOGIC_VECTOR(M-1 downto 0)  -- Risultato della somma
        );
    end component;

    
begin

     MEMORIA : MEM
        Generic Map(N => 8, DIM => 3,  M => 4)
        Port Map(
            clk => CLK_B, 
            read => tmp_read_mem, 
            write => tmp_write_mem,
            data_in => tmp_sum_out,  
            addr => tmp_addr,
            data_out => mem_out
        ); 
     
     SOMMA : SUM
        Generic Map(
                M => 4
            )
        Port Map(
            clk  => CLK_B,
            A => tmp_reg_out,
            B => mem_out,
            SUM => tmp_sum_out
        );
     
     COUNT : counter
        Generic Map(MAX_VALUE => 7, DIM => 3)
        Port Map( 
            CLK => CLK_B,
            RST => RST,
            EN => tmp_en_count,
            SET => '0',
            SET_VALUE => "000",
            COUNT => tmp_addr,
            CARRY => open
        );
        
      REG : Registro
        Port Map(
            D => DATA_IN,
            CLK => CLK_B,
            RST => RST,
            EN => tmp_load_reg,
            Q => tmp_reg_out
        );
      
      control_unit : UCB
        Port Map(
            CLK_B => CLK_B,
            RST => RST,
            REQ => REQ,
            COUNT => tmp_addr,
            ACK => ACK,
            READ_MEM => tmp_read_mem,
            WRITE_MEM => tmp_write_mem,
            EN_COUNT => tmp_en_count,
            LOAD_REG => tmp_load_reg
        );
    
end Structural;
