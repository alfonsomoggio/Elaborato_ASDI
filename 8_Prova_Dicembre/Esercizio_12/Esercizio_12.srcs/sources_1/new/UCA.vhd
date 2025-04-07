library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UCA is
  Port (
        START : in STD_LOGIC;
        ACK : in STD_LOGIC;
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        CONT_MAX : in STD_LOGIC;
        REQ : out STD_LOGIC;
        READ : out STD_LOGIC;
        INCR_ADDR : out STD_LOGIC;
        LOAD_OUT_A : out STD_LOGIC
   );
end UCA;

architecture Behavioral of UCA is
    type stato is (IDLE, S1, S2, S3, S4);

    signal stato_corrente : stato := IDLE;
    signal stato_prossimo : stato;
    
    
begin

-- Parte Combinatoria
    stato_uscita : process(stato_corrente, START, CONT_MAX, ACK)
    begin
        REQ <= '0';
        READ <= '0';
        INCR_ADDR <= '0';
        LOAD_OUT_A <= '0';
    
        case stato_corrente is     
            when IDLE =>
                if (START = '0') then
                    stato_prossimo <= IDLE;
                else
                    stato_prossimo <= S1;
                    end if;
            
            when S1 =>
                READ <= '1';            
                stato_prossimo <= S2;
            
            when S2 =>
                REQ <= '1';
                LOAD_OUT_A <= '1';
                if (ACK = '0') then
                    stato_prossimo <= S2;
                else 
                    stato_prossimo <= S3;
                end if;
             
             when S3 =>               
                if (ACK = '1') then
                    stato_prossimo <= S3;
                else 
                    stato_prossimo <= S4;
                end if;
                
             when S4 =>
                INCR_ADDR <= '1';
                if (CONT_MAX /= '1') then 
                    stato_prossimo <= S1;
                else 
                    stato_prossimo <= IDLE;
                end if;            
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
