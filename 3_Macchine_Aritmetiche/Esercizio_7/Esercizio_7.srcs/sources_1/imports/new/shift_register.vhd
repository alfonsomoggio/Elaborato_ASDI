library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---shift register che contiene inizialmente una stringa di 8 zeri e il moltiplicatore X
---al termine dell'operazione di moltiplicazione conterrà il risultato A+Q

entity shift_register is
	port( parallel_in: in std_logic_vector(16 downto 0); 
		  clock, reset, load, shift: in std_logic;
		  q0, q_1 : out STD_LOGIC;
		  parallel_out: out std_logic_vector(16 downto 0));		  
end shift_register;

architecture behavioural of shift_register is

	signal temp: std_logic_vector(16 downto 0);
	
	begin
	
	SR: process(clock)
		begin
		   if(clock'event and clock='1') then
			 if(reset='1') then 
			   temp <=(others=>'0');
			 else
			    if(load='1') then --caricamento iniziale del moltiplicatore
                          temp(16 downto 0) <= parallel_in;
                          --temp(0) <= '0';
                    elsif(shift='1') then 							
                          temp(16) <= temp(16);
                          temp(15 downto 0) <= temp(16 downto 1);                        
                    end if;
               end if; 
			
		   end if;
		end process;
	
	parallel_out <= temp;
	q0 <= temp(1);
	q_1 <= temp(0);
	end behavioural;
		
			