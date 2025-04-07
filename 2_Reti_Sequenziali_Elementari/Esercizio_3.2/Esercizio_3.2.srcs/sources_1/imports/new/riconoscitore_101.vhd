library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore_101 is
    port(
        i: in STD_LOGIC; 
        A: in STD_LOGIC;  -- Segnale di tempificazione
        M: in STD_LOGIC; 
        RST: in std_logic;
        Y: out STD_LOGIC
    );
end riconoscitore_101; 


architecture Behavioral of riconoscitore_101 is
    type stato is (S0, S1, S2, S3, S4);
    signal stato_corrente : stato:=S0; 
    signal stato_prossimo : stato; 
    
-- PARTE COMBINATORIA:     
begin
    stato_uscita: process(stato_corrente, i, M) begin
    Y <= '0'; -- Default output
        if(M = '1') then
            case stato_corrente is
                when S0 => 
                    if (i='1') then
                        stato_prossimo <= S1;
                        Y <= '0';
                    else
                        stato_prossimo <= S0;
                        Y <= '0';
                    end if; 
                when S1 => 
                    if( i = '0') then
                        stato_prossimo <= S2;
                        Y <= '0'; 
                    else
                        stato_prossimo <= S1;
                        Y <= '0'; 
                    end if;             
                when S2 =>
                    if (i = '1') then        
                        stato_prossimo <= S0; 
                        Y <= '1';
                    else
                        stato_prossimo <= S0;
                        Y <= '0';
                    end if;
                 when others => stato_prossimo <= S0;
            end case;
        elsif(M = '0') then
            case stato_corrente is 
                when S0 =>
                    if (i='1') then
                        stato_prossimo <= S2;
                        Y <= '0';
                    else
                        stato_prossimo <= S1;
                        Y <= '0';
                    end if; 
                when S1 =>       
                    stato_prossimo <= S3;
                    Y <= '0';
                when S2 =>
                    if (i='0') then
                        stato_prossimo <= S4;
                        Y <= '0';
                    else
                        stato_prossimo <= S3;
                        Y <= '0';
                    end if;
                 when S3 =>       
                    stato_prossimo <= S0;
                    Y <= '0';  
                 when S4 =>
                    if (i='1') then
                        stato_prossimo <= S0;
                        Y <= '1';
                    else
                        stato_prossimo <= S0;
                        Y <= '0';
                    end if;                   
            end case; 
        end if;
    end process; 

-- PARTE SEQUENZIALE -> stato corrente aggiornato solo sul fronte di salita del clock:
    mem: process(A)
    begin
        if( A'event and A = '1' ) then
            if ( RST = '1') then 
                stato_corrente <= S0;  
            else 
                stato_corrente <= stato_prossimo; 
            end if; 
        end if;
    end process; 
end Behavioral;

