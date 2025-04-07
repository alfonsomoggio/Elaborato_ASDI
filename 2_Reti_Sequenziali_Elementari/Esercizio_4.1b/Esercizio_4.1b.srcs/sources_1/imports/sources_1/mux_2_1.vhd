library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_2_1.
entity mux_2_1 is

	port( 	a0 	: in STD_LOGIC;
			a1 	: in STD_LOGIC;
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
end mux_2_1;

architecture behavioral of mux_2_1 is
	
	begin
		process (s,a0,a1)
            begin
               case s is
                  when '0' => y <= a0;
                  when '1' => y <= a1;
                  when others => y <= '-';
               end case;
            end process;

end behavioral;


