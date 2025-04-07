library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Handshaking is
  Port (
        CLK_A : in STD_LOGIC;
        CLK_B : in STD_LOGIC;
        START : in STD_LOGIC;
        RST : in STD_LOGIC;
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
  );
end Handshaking;

architecture Structural of Handshaking is

    signal tmp_req : STD_LOGIC;
    signal tmp_ack : STD_LOGIC;
    signal data_outA : STD_LOGIC_VECTOR(3 downto 0);

    component NodoA
        Port (
            START : in STD_LOGIC;
            CLK_A : in STD_LOGIC;
            RST : in STD_LOGIC;
            ACK : in STD_LOGIC;
            REQ : out STD_LOGIC;
            DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component NodoB
        Port (
            CLK_B : in STD_LOGIC;
            RST : in STD_LOGIC;
            DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
            REQ : in STD_LOGIC;
            ACK : out STD_LOGIC
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
            DATA_OUT => data_outA
        );
        
     B : NodoB
        Port Map(
            CLK_B => CLK_B,
            RST => RST,
            DATA_IN => data_outA,
            REQ => tmp_req,
            ACK => tmp_ack
        );
end Structural;
