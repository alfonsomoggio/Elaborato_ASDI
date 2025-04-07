library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_elementare is
  Port (
        X1 : in STD_LOGIC_VECTOR(1 downto 0);
        X2 : in STD_LOGIC_VECTOR(1 downto 0);
        SRC : in STD_LOGIC;
        DST : in STD_LOGIC;
        Y1 : out STD_LOGIC_VECTOR(1 downto 0);
        Y2 : out STD_LOGIC_VECTOR(1 downto 0)
   );
end switch_elementare;

architecture structural of switch_elementare is
    
    signal internal_y : STD_LOGIC_VECTOR(1 downto 0);
    
    component mux_2_1
        port( 	
            a0 	: in STD_LOGIC_VECTOR(1 downto 0);
			a1 	: in STD_LOGIC_VECTOR(1 downto 0);
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC_VECTOR(1 downto 0)
	    );
    end component;
    
    component demux_1_2
        port( 	
            a 	: in STD_LOGIC_VECTOR(1 downto 0);
			s 	: in STD_LOGIC;
			y0 	: out STD_LOGIC_VECTOR(1 downto 0);
			y1 	: out STD_LOGIC_VECTOR(1 downto 0)
	    );
    end component;
    
begin
    
    mux : mux_2_1
        port map(
            a0 => X1,
            a1 => X2,
            s => SRC,
            y => internal_y
        );
        
     demux : demux_1_2
        port map(
            a => internal_y,
            s => DST,
            y0 => Y1,
            y1 => Y2
        );

end structural;
