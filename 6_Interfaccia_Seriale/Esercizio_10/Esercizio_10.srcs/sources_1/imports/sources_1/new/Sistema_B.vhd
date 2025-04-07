library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_B is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           RXD : in STD_LOGIC
         );  
end Sistema_B;

architecture structural of Sistema_B is
    signal en_count, tmp_write : STD_LOGIC;
    signal tmp_count : STD_LOGIC_VECTOR(2 downto 0);
    signal tmp_data : STD_LOGIC_VECTOR(7 downto 0);
    signal txd_temp : STD_LOGIC := '0'; 
    
    signal UART_RDA : STD_LOGIC;  
    signal UART_RD : STD_LOGIC;
   
     component counter
        Generic (
            MAX_VALUE : integer;
            DIM : integer
        );  
        Port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            EN  : in STD_LOGIC;
            SET : in STD_LOGIC;
            SET_VALUE : in STD_LOGIC_VECTOR(2 downto 0);
            COUNT : out STD_LOGIC_VECTOR(2 downto 0);
            CARRY : out STD_LOGIC
        );    
    end component;
    
    component MEM
        Port(
            clk : in STD_LOGIC; 
            read : in STD_LOGIC;
            write : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(7 downto 0);
            addr : in STD_LOGIC_VECTOR(2 downto 0); 
            data_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component Rs232RefComp
    	port (
    		TXD     : out STD_LOGIC := '1';
            RXD     : in  STD_LOGIC;
            CLK     : in  STD_LOGIC;
            DBIN    : in  STD_LOGIC_VECTOR (7 downto 0);
            DBOUT   : out STD_LOGIC_VECTOR (7 downto 0);
            RDA     : inout STD_LOGIC;
            TBE     : inout STD_LOGIC := '1';
            RD      : in  STD_LOGIC;
            WR      : in  STD_LOGIC;
            PE      : out STD_LOGIC;
            FE      : out STD_LOGIC;
            OE      : out STD_LOGIC;
            RST     : in  STD_LOGIC := '0'
    	);
    end component;
    
    component UCB
        Port (
            clk: in STD_LOGIC; 
            rst: in STD_LOGIC;
            rda: in STD_LOGIC;
            rxd: in STD_LOGIC;
            write: out STD_LOGIC; 
            rd: out STD_LOGIC; 
            en_cont: out STD_LOGIC
        );
    end component;

begin

    control_unit : UCB
        Port Map(
            clk => CLK, 
            rst => RST,
            rda => UART_RDA,
            rxd => RXD,
            write => tmp_write, 
            rd => UART_RD, 
            en_cont => en_count
        );
    
    UART_B: Rs232RefComp
        port map (
            TXD => txd_temp,
            RXD => RXD,
            CLK => CLK,
            DBIN => (others => '0'),
            DBOUT => tmp_data,
            RDA => UART_RDA,
            RD => UART_RD,
            WR => '0',
            RST => RST
        );   
    
    memoria : MEM
          Port Map(
            clk => CLK,
            read => '0',
            write => tmp_write,
            data_in => tmp_data,
            addr => tmp_count,
            data_out => open
        );
        
    count : counter
        Generic Map(
            MAX_VALUE => 7,
            DIM => 3
        ) 
        Port Map( 
            CLK => CLK,
            RST => RST,
            EN => en_count,
            SET => '0',
            SET_VALUE => "000",
            COUNT => tmp_count,
            CARRY => OPEN
        );


end structural;
