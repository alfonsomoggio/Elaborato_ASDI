library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ******************************************************************************* --
-- Definizione di un componente MUX 2:1 attraverso 
-- l'utilizzo di vari costrutti al livello di astrazione dataflow/behavioral
-- ******************************************************************************* --


-- Definizione dell'interfaccia del modulo mux_2_1.
entity mux_2_1 is

	port( 	a0 	: in STD_LOGIC;
			a1 	: in STD_LOGIC;
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
end mux_2_1;



architecture dataflow_v1 of mux_2_1 is
	
	begin
		y 	<= 	a0 when s = '0' else	
				a1 when s = '1' else
				'-'; --specifico cosa succede quando s non assume valore 0 o 1
				-- perchè s è uno STD_LOGIC, non un BIT
				
		

end dataflow_v1;