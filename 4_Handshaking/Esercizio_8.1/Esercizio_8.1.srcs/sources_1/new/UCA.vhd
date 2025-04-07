library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UCA is
  Port (
        CLK_A : in STD_LOGIC;
        RST : in STD_LOGIC;
        START : in STD_LOGIC;
        ACK : in STD_LOGIC;
        CONT_MAX : in STD_LOGIC;
        REQ: out STD_LOGIC;
        READ_MEM : out STD_LOGIC;
        EN_COUNT : out STD_LOGIC;
        LOAD_REG : out STD_LOGIC
   );
end UCA;

architecture Behavioral of UCA is
    type stato is (IDLE, S1, S2, S3, S4, S5);

    signal stato_corrente : stato := IDLE;
    signal stato_prossimo : stato;

begin
-- Parte combinatoria
    comb: process(stato_corrente, START, ACK, CONT_MAX)
    begin
        REQ <= '0';
        READ_MEM <= '0';
        EN_COUNT <= '0';
        LOAD_REG <= '0';
        
        case stato_corrente is
            when IDLE =>
                if(start = '0') then
                    stato_prossimo <= IDLE;
                elsif(start = '1') then
                    stato_prossimo <= S1;
                end if;
            
            when S1 =>
                READ_MEM <= '1';
                stato_prossimo <= S2;
                
            when S2 =>
                REQ <= '1';
                LOAD_REG <= '1';
                stato_prossimo <= S3;
            
            when S3 => 
                REQ <= '1';
                if (ACK = '0') then
                    stato_prossimo <= S3;
                else
                    stato_prossimo <= S4;
                end if;
            
            when S4 => 
                if (ACK = '1') then
                    stato_prossimo <= S4;
                else
                    stato_prossimo <= S5;
                end if;
             
            when S5 =>
                EN_COUNT <= '1';
                if (CONT_MAX /= '1') then
                    stato_prossimo <= S1;
                else
                    stato_prossimo <= IDLE;
                end if;
                
        end case;
    end process;


-- Parte Sequenziale
    mem: process (CLK_A)
    begin
        if( CLK_A'event and CLK_A = '1' ) then
            if( RST = '1') then
               stato_corrente <= IDLE;
            else
               stato_corrente <= stato_prossimo;
            end if;
       end if;
    end process;

end Behavioral;
