library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema is
  Port (
        CLK_A : in STD_LOGIC;
        CLK_B : in STD_LOGIC;
        RST : in STD_LOGIC;
        START : in STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
   );
end Sistema;

architecture Structural of Sistema is
    
    signal tmp_ack, tmp_req : STD_LOGIC;
    signal data_out_A : STD_LOGIC_VECTOR(3 downto 0);
    
    component NodoA
        Port (
        START : in STD_LOGIC;
        CLK_A : in STD_LOGIC;
        RST : in STD_LOGIC;
        ACK : in STD_LOGIC;
        REQ : out STD_LOGIC;
        DATA : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component NodoB
        Port (
        CLK_B : in STD_LOGIC;
        RST : in STD_LOGIC;
        REQ : in STD_LOGIC;
        DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
        ACK : out STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)      
        );
    end component;

begin

    A : NodoA
        Port Map(
            START => START,
            CLK_A => CLK_A,
            RST => RST,
            ACK => tmp_ack,
            REQ => tmp_req,
            DATA => data_out_A
        );
        
    B : NodoB 
        Port Map(
            CLK_B => CLK_B,
            RST => RST,
            REQ => tmp_req,
            DATA_IN => data_out_A,
            ACK => tmp_ack,
            DATA_OUT => DATA_OUT     
        );

end Structural;
