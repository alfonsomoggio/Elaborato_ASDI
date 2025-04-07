library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Definizione dell'interfaccia del modulo mux_2_1.
entity demux_1_2 is

	port( 	a 	: in STD_LOGIC_VECTOR(1 downto 0);
			s 	: in STD_LOGIC;
			y0 	: out STD_LOGIC_VECTOR(1 downto 0);
			y1 	: out STD_LOGIC_VECTOR(1 downto 0)
	);
		
end demux_1_2;

architecture dataflow of demux_1_2 is
	
	begin
		y0 <= a when s = '0' else "UU";
		y1 <= a when s = '1' else "UU"; 	
			
end dataflow;