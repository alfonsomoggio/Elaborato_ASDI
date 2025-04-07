library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity molt_Booth is
  Port (
        clock, reset, start : in STD_LOGIC;
        X, Y: in std_logic_vector(7 downto 0);
        P: out std_logic_vector(15 downto 0)
  );
end molt_Booth;

architecture structural of molt_Booth is
    
    component unita_operativa
        Port (
            X, Y : in STD_LOGIC_VECTOR(7 downto 0);
            clock, reset : in STD_LOGIC;
            loadAQ, shiftAQ, loadM, sub, selAQ, count_in : in STD_LOGIC;
            COUNT : out STD_LOGIC_VECTOR(2 downto 0);
            q0, q_1 : out STD_LOGIC;
            P : out STD_LOGIC_VECTOR(15 downto 0)
       );
    end component;
    
    component unita_controllo
        Port (
            clock, reset, start : in STD_LOGIC;
            COUNT : in STD_LOGIC_VECTOR(2 downto 0);
            q0, q_1 : in STD_LOGIC;
            loadAQ, shiftAQ, loadM, sub, selAQ, count_in : out STD_LOGIC
       );
    end component;
    
    signal tmp_loadAQ, tmp_shiftAQ, tmp_loadM, tmp_sub, tmp_selAQ, tmp_count_in : STD_LOGIC;
    signal tmp_count : STD_LOGIC_VECTOR(2 downto 0);
    signal tmp_q0, tmp_q_1 : STD_LOGIC;
    signal temp_p: std_logic_vector(15 downto 0);
    
begin
    
    UO : unita_operativa
        port map(
            X => X,
            Y => Y,
            clock => clock,
            reset => reset,
            loadAQ => tmp_loadAQ,
            shiftAQ => tmp_shiftAQ,
            loadM => tmp_loadM,
            sub => tmp_sub,
            selAQ => tmp_selAQ,
            count_in => tmp_count_in,
            COUNT => tmp_count,
            q0 => tmp_q0,
            q_1 => tmp_q_1,
            P => temp_P
        );
    
    UC : unita_controllo
        port map(
            clock => clock,
            reset => reset,
            start => start,
            COUNT => tmp_count,
            q0 => tmp_q0,
            q_1 => tmp_q_1,
            loadAQ => tmp_loadAQ, 
            shiftAQ => tmp_shiftAQ, 
            loadM => tmp_loadM, 
            sub => tmp_sub, 
            selAQ => tmp_selAQ, 
            count_in => tmp_count_in
        );

    P<=temp_p;
    
end structural;
