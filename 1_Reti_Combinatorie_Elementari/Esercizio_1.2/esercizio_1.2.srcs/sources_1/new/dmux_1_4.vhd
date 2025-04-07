----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 16:45:13
-- Design Name: 
-- Module Name: dmux_1_4 - Behavioral
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

entity dmux_1_4 is
  Port (  c0 : in STD_LOGIC; 
          s4 : in STD_LOGIC;
          s5 : in STD_LOGIC;
          d0 : out STD_LOGIC; 
          d1 : out STD_LOGIC; 
          d2 : out STD_LOGIC; 
          d3 : out STD_LOGIC
  );
end dmux_1_4;

 architecture Behavioral of dmux_1_4 is
    signal sel: std_logic_vector(1 downto 0); 
begin
    sel <= s5 & s4;  
    process(c0, s4, s5)
    begin
    
        d0 <= '0';
        d1 <= '0';
        d2 <= '0';
        d3 <= '0'; 
        
        case sel is
            when "00" =>
                d0 <= c0;
            when "01" =>
                d1 <= c0;
            when "10" =>
                d2 <= c0;
            when "11" =>
                d3 <= c0;
            when others =>
                d0 <= '0';
                d1 <= '0';
                d2 <= '0';
                d3 <= '0';
        end case;
        
    end process;
    
end Behavioral;
