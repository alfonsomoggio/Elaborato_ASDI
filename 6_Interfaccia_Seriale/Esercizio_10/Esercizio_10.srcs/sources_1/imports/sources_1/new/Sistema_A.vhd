library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_A is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           START : in STD_LOGIC;
           TXD : out STD_LOGIC
          );
end Sistema_A;

architecture structural of Sistema_A is
    signal en_count, tmp_read : STD_LOGIC;
    signal tmp_count : STD_LOGIC_VECTOR(2 downto 0);
    signal tmp_data : STD_LOGIC_VECTOR(7 downto 0);
    signal dbout_tmp : STD_LOGIC_VECTOR(7 downto 0);
    
    signal UART_TBE : STD_LOGIC;
    signal UART_WR : STD_LOGIC;

    component ROM
        Port(
            clk : in STD_LOGIC; 
            read : in STD_LOGIC; 
            addr : in STD_LOGIC_VECTOR(2 downto 0); 
            data : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
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

    component UCA
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
    end component;
begin

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
    
    memoria : ROM
         Port Map(
            clk => CLK, 
            read => tmp_read, 
            addr => tmp_count, 
            data => tmp_data
         );
         
    UART_A: Rs232RefComp
        port map (
            TXD => TXD,
            RXD => '0',
            CLK => CLK,
            DBIN => tmp_data,
            DBOUT => dbout_tmp,
            TBE => UART_TBE,
            RD => '0',
            WR => UART_WR,
            RST => RST
        );
        
     control_unit : UCA
        port map(
            start => START, 
            clk => CLK,
            rst => RST,
            addr => tmp_count, 
            tbe => UART_TBE,
            read => tmp_read,
            wr => UART_WR, 
            en_cont => en_count
	    );


end structural;
