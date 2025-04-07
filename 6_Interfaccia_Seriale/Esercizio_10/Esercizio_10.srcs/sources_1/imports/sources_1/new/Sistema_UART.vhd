library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_UART is
  Port (
        START : in STD_LOGIC;
        RST : in STD_LOGIC;
        CLK : in STD_LOGIC
   );
end Sistema_UART;

architecture Structural of Sistema_UART is
    
    signal internal_tx : STD_LOGIC; 
    
    component Sistema_A
        Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           START : in STD_LOGIC;
           TXD : out STD_LOGIC
        );
    end component;
    
    component Sistema_B
        Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           RXD : in STD_LOGIC
        );  
    end component;
    
begin
    
    A : Sistema_A
        port map(
            CLK => CLK,
            RST => RST,
            START => START,
            TXD =>  internal_tx         
        );
        
    B : Sistema_B
        port map(
            CLK => CLK,
            RST => RST,
            RXD => internal_tx        
        );

end Structural;
