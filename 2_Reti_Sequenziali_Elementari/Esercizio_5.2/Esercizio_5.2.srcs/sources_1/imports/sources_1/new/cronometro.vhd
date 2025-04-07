library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro is
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
end cronometro;

architecture Structural of cronometro is
    signal carry_sec, carry_min, enable_sec : STD_LOGIC;
    
    component counter 
        Generic(MAX_VALUE : integer; DIM : integer);
        Port(
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            EN  : in STD_LOGIC;
            SET : in STD_LOGIC;
            SET_VALUE : in STD_LOGIC_VECTOR(DIM-1 downto 0);
            COUNT : out STD_LOGIC_VECTOR(DIM-1 downto 0);
            CARRY : out STD_LOGIC
        );
    end component;
    
    component clock_divider
        Generic(
				clock_frequency_in : integer;
				clock_frequency_out : integer
				);
        Port ( 
               clock_in : in  STD_LOGIC;
               reset : in STD_LOGIC;
               clock_out : out  STD_LOGIC
              );
    end component;
begin
    div : clock_divider
        Generic Map(clock_frequency_in => 100000000, clock_frequency_out => 1)
        Port Map(
                clock_in => CLK,
                reset => RST,
                clock_out => enable_sec
        );
    
    --Contatore secondi
    count_sec : counter
        Generic Map(MAX_VALUE => 59, DIM => 6)
        Port Map(
                CLK => CLK,
                RST => RST,
                EN => enable_sec,
                SET => SET,
                SET_VALUE => SET_SEC,
                COUNT => SEC,
                CARRY => carry_sec
        );
        
     --Contatore minuti
      count_min : counter
        Generic Map(MAX_VALUE => 59, DIM => 6)
        Port Map(
                CLK => CLK,
                RST => RST,
                EN => carry_sec,
                SET => SET,
                SET_VALUE => SET_MIN,
                COUNT => MIN,
                CARRY => carry_min
        );
        
     --Contatore ore
      count_hr : counter
        Generic Map(MAX_VALUE => 23, DIM => 5)
        Port Map(
                CLK => CLK,
                RST => RST,
                EN => carry_min,
                SET => SET,
                SET_VALUE => SET_HR,
                COUNT => HR,
                CARRY => open
        );

end Structural;
