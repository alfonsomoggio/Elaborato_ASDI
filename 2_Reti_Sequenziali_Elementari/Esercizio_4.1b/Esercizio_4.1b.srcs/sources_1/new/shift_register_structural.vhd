library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shift_register_structural is
  Generic (N : integer := 5);
  
  Port (
        Sx_in : in STD_LOGIC;
        Dx_in : in STD_LOGIC;
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        SHIFT_MODE : in STD_LOGIC;
        SHIFT_AMOUNT : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(N-1 downto 0)
  
   );
end shift_register_structural;

architecture structural of shift_register_structural is
    signal Q_temp : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal D_temp : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

    component FF 
        port (
              D : in STD_LOGIC;
              CLK : in STD_LOGIC;
              RST : in STD_LOGIC;
              Q : out STD_LOGIC
        );
    end component;
    
    component mux_4_1
        port( 	a0 : in STD_LOGIC;
                a1 : in STD_LOGIC;
                a2 : in STD_LOGIC;
                a3 : in STD_LOGIC;
                s0 : in STD_LOGIC;
                s1 : in STD_LOGIC;
                y : out STD_LOGIC
        );
    end component;
    

begin

    -- Generazione registri
    gen_reg : for i in 0 to N-1 generate
       regi : FF port map(
                        D => D_temp(i),
                        CLK => CLK,
                        RST => RST,
                        Q => Q_temp(i)
                 );
    end generate;          
                 
    -- Generazione multiplexer
    MUXN_1 : mux_4_1 port map(
                                a0 => Q_temp(N-2),
                                a1 => Q_temp(N-3),
                                a2 => Sx_in,
                                a3 => Sx_in,
                                s0 => SHIFT_AMOUNT,
                                s1 => SHIFT_MODE,
                                y => D_temp(N-1)  
                      ); 
                       
    MUXN_2 : mux_4_1 port map(
                                a0 => Q_temp(N-3),
                                a1 => Q_temp(N-4),
                                a2 => Q_temp(N-1),
                                a3 => Sx_in,
                                s0 => SHIFT_AMOUNT,
                                s1 => SHIFT_MODE,
                                y => D_temp(N-2)       
                      );     
    
    gen_mux : for index in N-3 downto 2 generate
        MUXi : mux_4_1 port map(
                                a0 => Q_temp(index-1),
                                a1 => Q_temp(index-2),
                                a2 => Q_temp(index+1),
                                a3 => Q_temp(index+2),
                                s0 => SHIFT_AMOUNT,
                                s1 => SHIFT_MODE,
                                y => D_temp(index)       
                      );
    end generate;
    
    MUX1 :  mux_4_1 port map(
                                a0 => Q_temp(0),
                                a1 => Dx_in,
                                a2 => Q_temp(2),
                                a3 => Q_temp(3),
                                s0 => SHIFT_AMOUNT,
                                s1 => SHIFT_MODE,
                                y => D_temp(1)       
                      );
                      
    MUX0 :  mux_4_1 port map(
                                a0 => Dx_in,
                                a1 => Dx_in,
                                a2 => Q_temp(1),
                                a3 => Q_temp(2),
                                s0 => SHIFT_AMOUNT,
                                s1 => SHIFT_MODE,
                                y => D_temp(0)       
                      );                                
    Q <= Q_temp;
end structural;
