library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCB is
    Port (
        CLK_B : in STD_LOGIC;
        RST : in STD_LOGIC;
        REQ : in STD_LOGIC;
        COUNT : in STD_LOGIC_VECTOR(2 downto 0);
        ACK: out STD_LOGIC;
        READ_MEM : out STD_LOGIC;
        WRITE_MEM : out STD_LOGIC;
        EN_COUNT : out STD_LOGIC;
        EN_SUM : out STD_LOGIC;
        LOAD_REG : out STD_LOGIC
    );
end UCB;

architecture Behavioral of UCB is
    
    type stato is (IDLE, S1, S2, S3);
    signal stato_corrente : stato := IDLE;
    signal stato_prossimo : stato;

begin

-- Parte combinatoria
    comb : process (stato_corrente, req, count) begin
        EN_COUNT <= '0';
        WRITE_MEM <= '0';
        ACK <= '0';
        
        case stato_corrente is
            when IDLE =>
                if (REQ = '0') then
                    stato_prossimo <= IDLE;
                else
                    stato_prossimo <= S1;
                end if;
            
            when S1 => 
                ACK <= '1';
                READ_MEM <= '1';
                LOAD_REG <= '1';
                stato_prossimo <= S2;
                
            when S2 =>
                ACK <= '1';
                stato_prossimo <= S3;
                
            when S3 =>
                WRITE_MEM <= '1';
                EN_COUNT <= '1';
                --ACK <= '0';
                stato_prossimo <= IDLE;
        end case;
    end process;

-- Parte sequenziale
    mem : process(CLK_B) begin
        if rising_edge(CLK_B) then
            if (RST = '1') then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;


end Behavioral;
