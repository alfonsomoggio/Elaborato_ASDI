library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Switch_Multistadio_TB is
end Switch_Multistadio_TB;

architecture testbench of Switch_Multistadio_TB is

    component Switch_Multistadio
        Port (
            input_0 : in STD_LOGIC_VECTOR(1 downto 0);
            input_1 : in STD_LOGIC_VECTOR(1 downto 0);
            input_2 : in STD_LOGIC_VECTOR(1 downto 0);
            input_3 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_0 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_1 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_2 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_3 : in STD_LOGIC_VECTOR(1 downto 0);
            attiva_0 : in STD_LOGIC;
            attiva_1 : in STD_LOGIC;
            attiva_2 : in STD_LOGIC;
            attiva_3 : in STD_LOGIC;
            output_0 : out STD_LOGIC_VECTOR(1 downto 0);
            output_1 : out STD_LOGIC_VECTOR(1 downto 0);
            output_2 : out STD_LOGIC_VECTOR(1 downto 0);
            output_3 : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal input_0, input_1, input_2, input_3 : STD_LOGIC_VECTOR(1 downto 0);
    signal dest_0, dest_1, dest_2, dest_3 : STD_LOGIC_VECTOR(1 downto 0);
    signal attiva_0, attiva_1, attiva_2, attiva_3 : STD_LOGIC;
    signal output_0, output_1, output_2, output_3 : STD_LOGIC_VECTOR(1 downto 0);

begin

    DUT: Switch_Multistadio
        port map (
            input_0 => input_0,
            input_1 => input_1,
            input_2 => input_2,
            input_3 => input_3,
            dest_0 => dest_0,
            dest_1 => dest_1,
            dest_2 => dest_2,
            dest_3 => dest_3,
            attiva_0 => attiva_0,
            attiva_1 => attiva_1,
            attiva_2 => attiva_2,
            attiva_3 => attiva_3,
            output_0 => output_0,
            output_1 => output_1,
            output_2 => output_2,
            output_3 => output_3
        );

    process
    begin
        
        -- definisco i valori di input dei 4 nodi sorgente
        input_0 <= "00"; 
        input_1 <= "01"; 
        input_2 <= "10"; 
        input_3 <= "11";
        -- assegno una destinazione ad ogni nodo sorgente
        dest_0 <= "00"; 
        dest_1 <= "01"; 
        dest_2 <= "10"; 
        dest_3 <= "11";
        
        -- verifico il corretto funzionamento delle priorità, attivando i diversi nodi
        attiva_0 <= '1'; 
        attiva_1 <= '1'; 
        attiva_2 <= '1'; 
        attiva_3 <= '1';
        
        wait for 20 ns;        
        attiva_0 <= '0'; 
        
        wait for 20 ns;        
        attiva_1 <= '0';
        
        wait for 20 ns;        
        attiva_2 <= '0';
        
    
        wait;
    end process;
    
end testbench;
