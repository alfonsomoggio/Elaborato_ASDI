library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA is
  Port (
        START : in STD_LOGIC;
        CLK_A : in STD_LOGIC;
        RST : in STD_LOGIC;
        ACK : in STD_LOGIC;
        REQ : out STD_LOGIC;
        DATA : out STD_LOGIC_VECTOR(3 downto 0)
   );
end NodoA;

architecture Structural of NodoA is
    
    signal en_count, tmp_read, tmp_load, cont_max : STD_LOGIC;
    signal tmp_count : STD_LOGIC_VECTOR(2 downto 0);
    signal tmp_data : STD_LOGIC_VECTOR(3 downto 0);
    
    component ROM
        Port(
            clk : in STD_LOGIC; 
            read : in STD_LOGIC; 
            addr : in STD_LOGIC_VECTOR(2 downto 0); 
            data : out STD_LOGIC_VECTOR(3 downto 0)
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
            SET_VALUE : in STD_LOGIC_VECTOR(2 downto 0);
            COUNT : out STD_LOGIC_VECTOR(2 downto 0);
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
            START : in STD_LOGIC;
            ACK : in STD_LOGIC;
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            CONT_MAX : in STD_LOGIC;
            REQ : out STD_LOGIC;
            READ : out STD_LOGIC;
            INCR_ADDR : out STD_LOGIC;
            LOAD_OUT_A : out STD_LOGIC
        );
    end component;
    
begin
    
    control_unit : UCA
        Port Map(
            START => START,
            ACK => ACK,
            CLK => CLK_A,
            RST => RST,
            CONT_MAX => cont_max,
            REQ => REQ,
            READ => tmp_read,
            INCR_ADDR => en_count,
            LOAD_OUT_A => tmp_load
        );
        
     count : counter 
        Generic Map(
            MAX_VALUE => 7,
            DIM => 3
        ) 
        Port Map( 
            CLK => CLK_A,
            RST => RST,
            EN => en_count,
            SET => '0',
            SET_VALUE => "000",
            COUNT => tmp_count,
            CARRY => cont_max
        );
        
     memoria : ROM
         Port Map(
            clk => CLK_A, 
            read => tmp_read, 
            addr => tmp_count, 
            data => tmp_data
         );

     reg : Registro
            Port Map(
                D => tmp_data,
                CLK => CLK_A,
                RST => RST,
                EN => tmp_load,
                Q => DATA
            );

end Structural;
