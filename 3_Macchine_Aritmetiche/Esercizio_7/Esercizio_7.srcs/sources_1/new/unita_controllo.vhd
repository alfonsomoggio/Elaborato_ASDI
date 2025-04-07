library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_controllo is
  Port (
        clock, reset, start : in STD_LOGIC;
        COUNT : in STD_LOGIC_VECTOR(2 downto 0);
        q0, q_1 : in STD_LOGIC;
        loadAQ, shiftAQ, loadM, sub, selAQ, count_in : out STD_LOGIC
   );
end unita_controllo;

architecture Behavioral of unita_controllo is
    
    type state is (idle, acquisisci_op, scan, somma, sottrazione, shift, incr_cont, wait_op);
	signal current_state : state := IDLE;
	signal next_state : state;
    
begin

    parte_comb : process(current_state, start, count)
    begin
        loadAQ <= '0';
        shiftAQ <= '0';
        loadM <= '0';
        sub <= '0';      
        count_in <= '0';
        
        case current_state is 
            
            when idle =>
                selAQ <= '0';         
                if (start = '0') then
                    next_state <= idle;
                else
                    next_state <= acquisisci_op;
                end if;
            
            when acquisisci_op =>
                loadM <= '1';
                loadAQ <= '1';
                next_state <= wait_op;
            
            when wait_op =>
                selAQ <= '1';
                next_state <= scan;
            
            when scan =>
                --selAQ <= '1';
                if (q0 = '0' and q_1 = '1') then
                    next_state <= somma;
                elsif (q0 = '1' and q_1 = '0') then
                    next_state <= sottrazione;
                else
                    next_state <= shift;
                end if;
            
            when somma =>
                sub <= '0';
                loadAQ <= '1';
                next_state <= shift;
                
            when sottrazione =>
                sub <= '1';
                loadAQ <= '1';
                next_state <= shift; 
                
            when shift =>
                shiftAQ <= '1';
                next_state <= incr_cont;
            
            when incr_cont =>
                count_in <= '1';
                if (count /= "111") then
                    next_state <= scan;
                else
                    next_state <= idle;
                end if;        
        end case;        
    end process;



    parte_sequenziale : process(clock)
    begin
        if(clock'event and clock='1') then
         if(reset='1') then 
            current_state <=idle;
        else 
            current_state <=next_state;
         end if;
        end if;
    end process;
    


end Behavioral;
