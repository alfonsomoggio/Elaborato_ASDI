----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2025 11:47:20
-- Design Name: 
-- Module Name: shift_register_behavioral - Behavioral
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
use IEEE.NUMERIC_STD.ALL; 

entity shift_register_behavioral is
    -- Numero di bit del registro, 8 di def.
    generic (
        N: integer := 8
    );
 port(
        SI: in STD_LOGIC; 
        RST: in STD_LOGIC;
        CLK: in STD_LOGIC;
        SHIFT_AMOUNT: in integer range 0 to 1; -- Y = 1 o 2 posizioni shiftabili; 
        SHIFT_MODE: in STD_LOGIC; -- '0' shift a destra, e '1' shift a sinistra
        SO: out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end shift_register_behavioral;

architecture behavioral of shift_register_behavioral is
    signal tmp_reg: STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if(CLK'event and CLK='1') then
            if(RST='1') then
               tmp_reg <= (others => '0'); 
            else
                if SHIFT_MODE = '1' then -- Shift a destra
                    if SHIFT_AMOUNT = 1 then
                       tmp_reg <= SI & tmp_reg(N-1 downto 1); -- Shift di 1 posizione
                    elsif SHIFT_AMOUNT = 2 then
                       tmp_reg <= SI & SI & tmp_reg(N-1 downto 2); -- Shift di 2 posizioni
                    end if;
                else -- Shift a sinistra
                    if SHIFT_AMOUNT = 1 then
                        tmp_reg <= tmp_reg(N-2 downto 0) & SI; -- Shift di 1 posizione
                    elsif SHIFT_AMOUNT = 2 then
                        tmp_reg <= tmp_reg(N-3 downto 0) & SI & SI; -- Shift di 2 posizioni
                    end if;
                end if;
            end if;
        end if;
    end process;
    SO <= tmp_reg;
end behavioral;

