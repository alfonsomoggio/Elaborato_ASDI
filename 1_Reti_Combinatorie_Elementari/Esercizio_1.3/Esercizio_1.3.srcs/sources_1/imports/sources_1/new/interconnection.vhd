----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 17:09:27
-- Design Name: 
-- Module Name: interconnection - structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interconnection is
  Port (
        -- 16 sorgenti per il MUX + 4 selezioni
        sorgenti     : in STD_LOGIC_VECTOR(15 downto 0); 
        sorgenti_sel : in STD_LOGIC_VECTOR(3 downto 0); 
        
        -- 2 selezione per il DEMUX + 4 output
        destinazioni_sel : in STD_LOGIC_VECTOR(1 downto 0); 
        destinazioni     : out STD_LOGIC_VECTOR(3 downto 0) 
   );
end interconnection;

-- LOGICA DI INTERCONNESSIONE: 
architecture structural of interconnection is
    -- Segnale interno tra MUX e DEMUX
    signal mux_output : STD_LOGIC;
    
    -- Dichiarazioni componenti: 
    component mux_16_1 is
        port(
            b0, b1, b2, b3, b4, b5, b6, b7,
            b8, b9, b10, b11, b12, b13, b14, b15 : in STD_LOGIC;
            s0, s1, s2, s3 : in STD_LOGIC;
            y0 : out STD_LOGIC
        ); 
    end component; 
    
    component dmux_1_4 is
        port(
            c0 : in STD_LOGIC;
            s4 : in STD_LOGIC;
            s5 : in STD_LOGIC;
            d0 : out STD_LOGIC; 
            d1 : out STD_LOGIC; 
            d2 : out STD_LOGIC; 
            d3 : out STD_LOGIC
        );
    end component;
    
begin
    -- Istanza del MUX
    MUX: mux_16_1
        port map(
            b0 => sorgenti(0),
            b1 => sorgenti(1),
            b2 => sorgenti(2),
            b3 => sorgenti(3),
            b4 => sorgenti(4),
            b5 => sorgenti(5),
            b6 => sorgenti(6),
            b7 => sorgenti(7),
            b8 => sorgenti(8),
            b9 => sorgenti(9),
            b10 => sorgenti(10),
            b11 => sorgenti(11),
            b12 => sorgenti(12),
            b13 => sorgenti(13),
            b14 => sorgenti(14),
            b15 => sorgenti(15),
            s0 => sorgenti_sel(0), 
            s1 => sorgenti_sel(1),
            s2 => sorgenti_sel(2), 
            s3 => sorgenti_sel(3), 
            y0 => mux_output
        ); 
            
    -- Istanza del DMUX
    DMUX: dmux_1_4 
        port map(
            c0 => mux_output,
            s4 => destinazioni_sel(0),
            s5 => destinazioni_sel(1),
            d0 => destinazioni(0),
            d1 => destinazioni(1),
            d2 => destinazioni(2),
            d3 => destinazioni(3)
        );
        
end structural;