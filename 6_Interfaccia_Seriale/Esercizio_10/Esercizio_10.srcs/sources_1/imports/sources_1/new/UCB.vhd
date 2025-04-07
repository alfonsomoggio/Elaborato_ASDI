library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UCB is
  Port (
        clk: in STD_LOGIC; 
		rst: in STD_LOGIC;
		rda: in STD_LOGIC;
		rxd: in STD_LOGIC;
		write: out STD_LOGIC; 
		rd: out STD_LOGIC; 
		en_cont: out STD_LOGIC
   );
end UCB;

architecture Behavioral of UCB is
    type stato is (S0, S1, S2, S3); 
	
	signal stato_corrente : stato := S0; 
	signal stato_prossimo : stato; 
	
begin
    -- PARTE COMBINATORIA: 
	stato_uscita : process(stato_corrente, rda, rxd)
	begin
	   write <= '0';
	   en_cont <= '0';
	   rd <= '0';
	   
	   case stato_corrente is
	       when S0 =>
	           rd <= '1';
	           if (rxd = '1') then
	               stato_prossimo <= S0;
	           else
	               stato_prossimo <= S1;
	           end if;
	       when S1 => 
	           if (RDA = '0') then
	               stato_prossimo <= S1;
	           else 
	               stato_prossimo <= S2;
	           end if;
	       when S2 =>
	           write <= '1';
	           stato_prossimo <= S3;
	       when S3 =>
	           en_cont <= '1';
	           stato_prossimo <= S0;
	   end case;
	end process;

    -- PARTE SEQUENZIALE: 
	mem: process(clk)
	begin
		if(clk'event AND clk = '1') then
			if(rst = '1') then
				stato_corrente <= S0; 
			else
				stato_corrente <= stato_prossimo; 
			end if; 
		end if; 
	end process; 

end Behavioral;
