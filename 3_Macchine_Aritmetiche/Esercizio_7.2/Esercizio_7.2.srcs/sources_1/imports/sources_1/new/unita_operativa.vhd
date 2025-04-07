library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is
  Port (
        X, Y : in STD_LOGIC_VECTOR(7 downto 0);
        clock, reset : in STD_LOGIC;
        loadAQ, shiftAQ, loadM, sub, selAQ, count_in : in STD_LOGIC;
        COUNT : out STD_LOGIC_VECTOR(2 downto 0);
        q0, q_1 : out STD_LOGIC;
        P : out STD_LOGIC_VECTOR(15 downto 0)
   );
end unita_operativa;

architecture structural of unita_operativa is
    
    component shift_register
        port( parallel_in: in std_logic_vector(16 downto 0); 
              clock, reset, load, shift: in std_logic;
              q0, q_1 : out std_logic;
              parallel_out: out std_logic_vector(16 downto 0));	
    end component;
    
    component registro8
        port( A: in std_logic_vector(7 downto 0);
              clk, res, load: in std_logic;
              B: out std_logic_vector(7 downto 0));
    end component;
    
    component cont_mod8
        port( clock, reset: in std_logic;
              count_in: in std_logic;
              count: out std_logic_vector(2 downto 0));
    end component;
    
    component adder_sub
        port( X, Y: in std_logic_vector(7 downto 0);
              cin: in std_logic;
              Z: out std_logic_vector(7 downto 0);
              cout: out std_logic);
    end component;
    
    component mux_21 is
	generic (width : integer);
	port( x0, x1: in std_logic_vector(width-1 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(width-1 downto 0));
	end component;
	
    
    signal tmp_out_M : STD_LOGIC_VECTOR(7 downto 0);
    signal AQ_init: std_logic_vector(16 downto 0); --segnale in input all'SR 
    signal sum: std_logic_vector(7 downto 0); --uscita del parallel adder 
	signal AQ_sum_in : std_logic_vector(16 downto 0); 
	signal AQ_out: std_logic_vector(16 downto 0); --segnale temporaneo uscita dell'SR
	signal AQ_in: std_logic_vector(16 downto 0); --segnale in input all'SR 
	signal riporto: std_logic; -- riporto in uscita dell'adder che non utilizziamo
    
begin
    
    -- 1) predisposizione del secondo operando della somma: 
    M : registro8
        port map(
            A => Y,
            clk => clock,
            res => reset,
            load => loadM,
            B => tmp_out_M
        );
    
    -- 2) predisposizione del primo operando della somma:
    
    --stringa da 17 bit da inserire nello shift register A.Q durante la fare di inizializzazone:
    --è ottenuta concatenando 00000000 con il moltiplicatore X e con uno 0 finale
    AQ_init <= "00000000" & X & '0';  --valore da inserire all'inizio nello shift register
    
    --stringa di 17 bit da inserire nello shift register A.Q durante la fase operativa dopo aver effettuato la somma
    AQ_sum_in <=sum & AQ_out(8 downto 0); 
    
    -- mux per selezionare l'ingresso parallelo dello shift register: valore iniziale AQ_init 
    -- oppure uscita dell'adder AQ_sum_in
    MUX_SR_parallel_in : mux_21 
        generic map (width => 17) 
        port map(
            x0 => AQ_init, 
            x1 => AQ_sum_in, 
            s => selAQ, 
            y => AQ_in
        );
    
    
    -- 3) shift register A.Q
    AQ : shift_register
        port map(
            parallel_in => AQ_in,
            clock => clock,
            reset => reset,
            load => loadAQ,
            shift => shiftAQ,
            q0 => q0,
            q_1 => q_1,
            parallel_out => AQ_out
        );
    
    -- 4) sommatore
    ADD_SUB : adder_sub
        port map(
            X => AQ_out(16 downto 9),
            Y => tmp_out_M,
            cin => sub,
            Z => sum,
            cout => riporto
        );
    
    --5) contatore
    CONT : cont_mod8
        port map(
            clock => clock,
            reset => reset,
            count_in => count_in,
            count => count
        );
    
    --6) uscita del moltiplicatore, corrispondente al valore contenuto nello shift register

	P<=AQ_out(16 downto 1);

end structural;
