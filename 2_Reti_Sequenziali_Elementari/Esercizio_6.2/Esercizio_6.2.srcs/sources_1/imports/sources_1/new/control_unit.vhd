library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port (
        CLK : in STD_LOGIC;
        START  : in STD_LOGIC;
        RST : in STD_LOGIC;
        CONT_MAX  : in STD_LOGIC;  
        EN  : out STD_LOGIC;
        READ  : out STD_LOGIC;
        WRITE  : out STD_LOGIC 
   );
end control_unit;

architecture Structural of control_unit is
    type state is (IDLE, LETTURA, SCRITTURA, INCR_CONT);
    signal current_state,next_state : state;
begin
    
    reg_stato: process(CLK)
          begin
          if(CLK'event and CLK='1') then
             if(RST='1') then 
                current_state <= IDLE;
            else 
                current_state <= next_state;
             end if;
          end if;
    end process;
    
    comb : process(current_state, START, CONT_MAX) begin
        EN  <= '0';
        READ  <= '0';
        WRITE  <= '0';
        
        case current_state is
            
            when IDLE =>
                
                if START = '1' then
                    next_state <= LETTURA;
                else
                    next_state <= IDLE;             
                end if;
            
            when LETTURA =>
                READ  <= '1';
                next_state <= SCRITTURA;
            
            when SCRITTURA =>
                WRITE  <= '1';               
                next_state <= INCR_CONT;
                
            when INCR_CONT =>
                EN <= '1';
                if (CONT_MAX /= '1')  then
                    next_state <= LETTURA;
                else
                    next_state <= IDLE;
                end if;
                        
        end case;     
    end process;  

end Structural;
