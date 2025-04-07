library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_ric is
  Port (
        i: in STD_LOGIC;
        sel_i : in STD_LOGIC; 
        A: in STD_LOGIC;  -- Segnale di tempificazione
        M: in STD_LOGIC;
        sel_m : in STD_LOGIC; 
        RST: in std_logic;
        Y: out STD_LOGIC
   );
end top_level_ric;

architecture structural of top_level_ric is
    signal i_out_tmp : std_logic := '0';
    signal m_out_tmp : std_logic := '0';

    component riconoscitore_101 
        port (
            i : in STD_LOGIC; 
            A : in STD_LOGIC;  -- Segnale di tempificazione
            M : in STD_LOGIC;           
            RST : in std_logic;
            Y : out STD_LOGIC       
        );
    end component;
        
    component control_unit
        port (
                i : in STD_LOGIC;
                sel_i : in STD_LOGIC;
                A : in STD_LOGIC;
                M : in STD_LOGIC;
                sel_m : in STD_LOGIC;
                i_out : out STD_LOGIC;
                M_out : out STD_LOGIC  
        );
    end component; 
   
begin
    
    ric : riconoscitore_101 port map(
                                    i => i_out_tmp,
                                    A => A,
                                    M => m_out_tmp,
                                    RST => RST,
                                    Y => Y                                   
                            );
    
    u_c : control_unit port map(
                                i => i,
                                sel_i => sel_i,
                                A => A,
                                M => M,
                                sel_m => sel_M,
                                i_out => i_out_tmp,
                                M_out => m_out_tmp
                       );
end structural;
