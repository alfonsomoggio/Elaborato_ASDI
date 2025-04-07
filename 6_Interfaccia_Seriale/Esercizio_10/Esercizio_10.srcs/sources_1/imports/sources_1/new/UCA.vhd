library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UCA is
	port(
		start: in STD_LOGIC; 
		clk: in STD_LOGIC; 
		rst: in STD_LOGIC;
		addr: in STD_LOGIC_VECTOR(2 downto 0); 
		tbe: in STD_LOGIC;
		read: out STD_LOGIC; 
		wr: out STD_LOGIC; 
		en_cont: out STD_LOGIC
	);
end UCA; 


architecture Behavioral of UCA is
	type stato is (IDLE, S1, S2, S3, S4); 
	
	signal stato_corrente : stato := IDLE; 
	signal stato_prossimo : stato; 
	
begin
	-- PARTE COMBINATORIA: 
	stato_uscita : process(stato_corrente, start, addr, tbe)
	begin
		read <= '0'; 
		wr <= '0'; 
	    en_cont <= '0';
		
		case stato_corrente is
		when IDLE =>   
			if(start = '0') then
				stato_prossimo <= IDLE; 
			else
				stato_prossimo <= S1; 
			end if;
		
		when S1 =>
			read <= '1';
			stato_prossimo <= S2;
		
		
		when S2 => 
			wr <= '1'; 
			stato_prossimo <= S3;
			
		when S3 =>   
			if(tbe = '0') then
				stato_prossimo <= S3; 
			else
				stato_prossimo <= S4; 
			end if;
	    
	    when S4 =>
	       en_cont <= '1';
	       if (addr /= "111") then
	           stato_prossimo <= S1;
	       else 
	           stato_prossimo <= IDLE;
	       end if; 
		end case; 
	end process; 
	
-- PARTE SEQUENZIALE: 
	mem: process(clk)
	begin
		if(clk'event AND clk = '1') then
			if(rst = '1') then
				stato_corrente <= IDLE; 
			else
				stato_corrente <= stato_prossimo; 
			end if; 
		end if; 
	end process; 
end behavioral;
			
		
		
		
		
		
		
		