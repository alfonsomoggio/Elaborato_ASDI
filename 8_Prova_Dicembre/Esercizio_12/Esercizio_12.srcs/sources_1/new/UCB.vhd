library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCB is
  Port (
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        REQ : in STD_LOGIC;
        COUNT_MAX : in STD_LOGIC;
        ACK : out STD_LOGIC;
        EN_COUNT : out STD_LOGIC;
        LOAD_ACC : out STD_LOGIC;
        LOAD_A : out STD_LOGIC
   );
end UCB;

architecture Behavioral of UCB is

    type stato is (IDLE, Q1, Q2, Q3, Q4, Q5);

    signal stato_corrente : stato := IDLE;
    signal stato_prossimo : stato;

begin


    -- Parte Combinatoria
    stato_uscita : process(stato_corrente, req, count_max)
    begin
        ACK <= '0';
        EN_COUNT <= '0';
        LOAD_ACC <= '0';
        LOAD_A <= '0';
        
        case stato_corrente is
            
            when IDLE =>
                if (REQ = '0') then
                    stato_prossimo <= IDLE;
                else 
                    stato_prossimo <= Q1;
                end if;
             
            when Q1 =>
                LOAD_A <= '1';
                ACK <= '1';
                stato_prossimo <= Q2;
            
            when Q2 =>
                --acquisizione operandi 
                ACK <= '1'; 
                LOAD_A <= '1';       
                stato_prossimo <= Q3;
                           
            when Q3 =>
                --calcolo somma
                ACK <= '1';
                stato_prossimo <= Q4;
            
            when Q4 =>
                LOAD_ACC <= '1';
                stato_prossimo <= Q5;
            
            when Q5 =>
                EN_COUNT <= '1';
                stato_prossimo <= IDLE;
        end case;            
    end process;
    
    -- Parte Sequenziale
    mem: process (CLK)
    begin
        if( CLK'event and CLK = '1' ) then
            if( RST = '1') then
               stato_corrente <= IDLE;
            else
               stato_corrente <= stato_prossimo;
            end if;
       end if;
    end process;



end Behavioral;
