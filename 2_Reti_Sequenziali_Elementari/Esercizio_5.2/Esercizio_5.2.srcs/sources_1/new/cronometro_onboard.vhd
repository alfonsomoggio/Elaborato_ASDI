library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity cronometro_onboard is
    Port (
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            SET : in STD_LOGIC;
            IMPOSTA_SEC : in STD_LOGIC;
            IMPOSTA_MIN : in STD_LOGIC;
            IMPOSTA_HR : in STD_LOGIC;
            SET_SWITCH : in STD_LOGIC_VECTOR(5 downto 0);
            anodes_out : out  STD_LOGIC_VECTOR (7 downto 0);
            cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
       );
end cronometro_onboard;

architecture Structural of cronometro_onboard is
    
    signal tmp_orario_completo : STD_LOGIC_VECTOR(16 downto 0);
    signal tmp_sec, tmp_min, tmp_hr_extended : STD_LOGIC_VECTOR(5 downto 0);
    signal tmp_hr : STD_LOGIC_VECTOR(4 downto 0);
    signal sec_bcd, min_bcd, hr_bcd : STD_LOGIC_VECTOR(7 downto 0);
    signal display_value : std_logic_vector(31 downto 0);
    
    component cronometro 
        Port (
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            SET : in STD_LOGIC;
            SET_SEC : in STD_LOGIC_VECTOR(5 downto 0);
            SET_MIN : in STD_LOGIC_VECTOR(5 downto 0);
            SET_HR : in STD_LOGIC_VECTOR(4 downto 0);
            SEC : out STD_LOGIC_VECTOR(5 downto 0);
            MIN : out STD_LOGIC_VECTOR(5 downto 0);
            HR : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    component display_seven_segments 
        Generic( 
				CLKIN_freq : integer; 
				CLKOUT_freq : integer
				);
        Port ( CLK : in  STD_LOGIC;
               RST : in  STD_LOGIC;
               VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
               ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
               DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
               ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
               CATHODES : out  STD_LOGIC_VECTOR (7 downto 0)
               );
     end component;
     
     component gestione_switch
        Port (
                CLK : in STD_LOGIC;
                IMPOSTA_SEC : in STD_LOGIC;
                IMPOSTA_MIN : in STD_LOGIC;
                IMPOSTA_HR : in STD_LOGIC;
                SET_SWITCH : in STD_LOGIC_VECTOR(5 downto 0);
                ORARIO_COMPLETO : out STD_LOGIC_VECTOR(16 downto 0)
            );
     end component;
     
     component convertitore_bin_bcd 
        Port ( 
            BIN_IN  : in  STD_LOGIC_VECTOR(5 downto 0); -- Numero binario in input (0-59)
            BCD_OUT : out STD_LOGIC_VECTOR(7 downto 0) -- Output BCD (due cifre)
        );
     end component;

begin
    tmp_hr_extended <= "0" & tmp_hr;
    -- Conversione Binario -> BCD
    sec_conv : convertitore_bin_bcd port map(BIN_IN => tmp_sec, BCD_OUT => sec_bcd);
    min_conv : convertitore_bin_bcd port map(BIN_IN => tmp_min, BCD_OUT => min_bcd);
    hr_conv  : convertitore_bin_bcd port map(BIN_IN => tmp_hr_extended, BCD_OUT => hr_bcd);
        
    display_value <= "00000000" & hr_bcd & min_bcd & sec_bcd;
    
    crono : cronometro
        Port Map(
            CLK => CLK,
            RST => RST,
            SET => SET,
            SET_SEC => tmp_orario_completo(5 downto 0),
            SET_MIN => tmp_orario_completo(11 downto 6),
            SET_HR => tmp_orario_completo(16 downto 12),
            SEC => tmp_sec,
            MIN => tmp_min,
            HR => tmp_hr
        );
    
    dss : display_seven_segments 
        Generic Map(CLKIN_freq => 100000000, CLKOUT_freq=> 500)
        Port Map(
            CLK => CLK,
            RST => RST,
            VALUE => display_value,
            ENABLE => "00111111",
            DOTS => "00010100",
            ANODES => ANODES_OUT,
            CATHODES => CATHODES_OUT
        );
    
    gest_sw : gestione_switch
        Port Map(
            CLK => CLK,
            IMPOSTA_SEC => IMPOSTA_SEC,
            IMPOSTA_MIN => IMPOSTA_MIN,
            IMPOSTA_HR => IMPOSTA_HR,
            SET_SWITCH => SET_SWITCH,
            ORARIO_COMPLETO => tmp_orario_completo
        );
        
end Structural;
