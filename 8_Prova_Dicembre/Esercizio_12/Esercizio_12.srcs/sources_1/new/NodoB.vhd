library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoB is
  Port (
        CLK_B : in STD_LOGIC;
        RST : in STD_LOGIC;
        REQ : in STD_LOGIC;
        DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
        ACK : out STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)      
   );
end NodoB;

architecture Structural of NodoB is
    
    signal tmp_load_A, tmp_load_acc, tmp_en_count, tmp_count_max : STD_LOGIC;
    signal reg_a_out, CLA_out, acc_out : STD_LOGIC_VECTOR(3 downto 0);
    
     component Registro 
        Port (
                D : in STD_LOGIC_VECTOR(3 downto 0);
                CLK : in STD_LOGIC;
                RST : in STD_LOGIC;
                EN : in STD_LOGIC;
                Q : out STD_LOGIC_VECTOR(3 downto 0)
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
    
    component SOMMATORE_CLA
        Port (
            X : in STD_LOGIC_VECTOR(3 downto 0);
            Y : in STD_LOGIC_VECTOR(3 downto 0);
            CIN : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;
    
    component UCB
        Port (
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            REQ : in STD_LOGIC;
            COUNT_MAX : in STD_LOGIC;
            ACK : out STD_LOGIC;
            EN_COUNT : out STD_LOGIC;
            LOAD_ACC : out STD_LOGIC;
            LOAD_A : out STD_LOGIC
       );
    end component;
    
begin

    control_unit : UCB 
        Port Map(
            CLK => CLK_B,
            RST => RST,
            REQ => REQ,
            COUNT_MAX => tmp_count_max,
            ACK => ACK,
            EN_COUNT => tmp_en_count,
            LOAD_ACC => tmp_load_acc,
            LOAD_A => tmp_load_A
       );

    Sum : SOMMATORE_CLA
        Port Map(
            X => reg_a_out, 
            Y => acc_out,
            CIN => '0',
            S => CLA_out,
            COUT => OPEN
        );

    cont : counter 
            Generic Map(
                MAX_VALUE => 7,
                DIM => 3
            )  
            Port Map( 
                CLK => CLK_B,
                RST => RST,
                EN => tmp_en_count,
                SET => '0',
                SET_VALUE => "000",
                COUNT => OPEN,
                CARRY => tmp_count_max
            );    

    Rba : Registro
        Port Map(
                D => Data_in,
                CLK => CLK_B,
                RST => RST,
                EN => tmp_load_A,
                Q=> reg_a_out
        );
        
    ACC : Registro 
        Port Map(
                D => CLA_out,
                CLK => CLK_B,
                RST => RST,
                EN => tmp_load_acc,
                Q=> acc_out
        );
    
    R : Registro 
        Port Map(
                D => acc_out,
                CLK => CLK_B,
                RST => RST,
                EN => tmp_count_max,
                Q => Data_out
        );

end Structural;
