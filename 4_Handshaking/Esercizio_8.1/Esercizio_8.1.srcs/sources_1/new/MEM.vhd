library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM is
  Generic(   
        N : integer := 8;
        DIM : integer := 3;   
        M : integer := 4
  );
  Port(
        clk : in STD_LOGIC; 
        read : in STD_LOGIC;
        write : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(3 downto 0);
        addr : in STD_LOGIC_VECTOR(2 downto 0); 
        data_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end MEM;

architecture Behavioral of MEM is
    -- Definizione della memoria come array di N locazioni di M bit
    type memory_type is array (0 to N-1) of STD_LOGIC_VECTOR(M-1 downto 0);
    
    -- Inizializzazione
    signal mem : memory_type := (
        "0001", "0010", "0100", "1000",
        "1001", "1010", "1100", "1111"
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if write = '1' then
                -- Scrittura: aggiorna la memoria all'indirizzo specificato
                mem(CONV_INTEGER(addr)) <= data_in;
            elsif read = '1' then
                -- Lettura: assegna il valore della memoria a data_out
                data_out <= mem(CONV_INTEGER(addr));
            end if;
        end if;
    end process;
end Behavioral;
