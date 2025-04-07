library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Omega_Network is
  Port (
        input_0 : in STD_LOGIC_VECTOR(1 downto 0);
        input_1 : in STD_LOGIC_VECTOR(1 downto 0);
        input_2 : in STD_LOGIC_VECTOR(1 downto 0);
        input_3 : in STD_LOGIC_VECTOR(1 downto 0);
        src : in STD_LOGIC_VECTOR(1 downto 0);
        dst : in STD_LOGIC_VECTOR(1 downto 0);
        output_0 : out STD_LOGIC_VECTOR(1 downto 0);
        output_1 : out STD_LOGIC_VECTOR(1 downto 0);
        output_2 : out STD_LOGIC_VECTOR(1 downto 0);
        output_3 : out STD_LOGIC_VECTOR(1 downto 0)
   );
end Omega_Network;

architecture Structural of Omega_Network is
    
    signal internal_out0, internal_out1, internal_out2, internal_out3 : STD_LOGIC_VECTOR(1 downto 0);
    
    component switch_elementare
        Port (
            X1 : in STD_LOGIC_VECTOR(1 downto 0);
            X2 : in STD_LOGIC_VECTOR(1 downto 0);
            SRC : in STD_LOGIC;
            DST : in STD_LOGIC;
            Y1 : out STD_LOGIC_VECTOR(1 downto 0);
            Y2 : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

begin
    
    s0 : switch_elementare
        port map(
            X1 => input_0,
            X2 => input_2,
            SRC => src(1),
            DST => dst(1),
            Y1 => internal_out0,
            Y2 => internal_out1
        );
     
     s1 : switch_elementare
        port map(
            X1 => input_1,
            X2 => input_3,
            SRC => src(1),
            DST => dst(1),
            Y1 => internal_out2,
            Y2 => internal_out3
        );
        
     s2 : switch_elementare
        port map(
            X1 => internal_out0,
            X2 => internal_out2,
            SRC => src(0),
            DST => dst(0),
            Y1 => output_0,
            Y2 => output_1
        );
        
     s3 : switch_elementare
        port map(
            X1 => internal_out1,
            X2 => internal_out3,
            SRC => src(0),
            DST => dst(0),
            Y1 => output_2,
            Y2 => output_3
        );

end Structural;
