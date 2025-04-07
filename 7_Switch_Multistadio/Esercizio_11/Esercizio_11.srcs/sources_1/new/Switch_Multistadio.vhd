library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Switch_Multistadio is
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
end Switch_Multistadio;

architecture Structural of Switch_Multistadio is
    
    signal tmp_src, tmp_dst : STD_LOGIC_VECTOR(1 downto 0);
    
    component Omega_Network
        Port (
            input_0 : in STD_LOGIC_VECTOR(1 downto 0);
            input_1 : in STD_LOGIC_VECTOR(1 downto 0);
            input_2 : in STD_LOGIC_VECTOR(1 downto 0);
            input_3 : in STD_LOGIC_VECTOR(1 downto 0);
            src : in STD_LOGIC_VECTOR(1 downto 0);
            dst : in STD_LOGIC_VECTOR(1 downto 0);
            output_0 : out STD_LOGIC_VECTOR(1 downto 0);
            output_1 : out STD_LOGIC_VECTOR(1 downto 0);
            output_2 : out STD_LOGIC_VECTOR(1 downto 0);
            output_3 : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    component gestione_priorita
        Port (
            dest_0 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_1 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_2 : in STD_LOGIC_VECTOR(1 downto 0);
            dest_3 : in STD_LOGIC_VECTOR(1 downto 0);
            attiva_0 : in STD_LOGIC;
            attiva_1 : in STD_LOGIC;
            attiva_2 : in STD_LOGIC;
            attiva_3 : in STD_LOGIC;
            src : out STD_LOGIC_VECTOR(1 downto 0);
            dst : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
begin

    O_N : Omega_Network
        port map(
            input_0 => input_0,
            input_1 => input_1,
            input_2 => input_2,
            input_3 => input_3,
            src => tmp_src,
            dst => tmp_dst,
            output_0 => output_0,
            output_1 => output_1,
            output_2 => output_2,
            output_3 => output_3
        );

    G_P : gestione_priorita
        port map(
            dest_0 => dest_0,
            dest_1 => dest_1,
            dest_2 => dest_2,
            dest_3 => dest_3,
            attiva_0 => attiva_0,
            attiva_1 => attiva_1,
            attiva_2 => attiva_2,
            attiva_3 => attiva_3,
            src => tmp_src,
            dst => tmp_dst
        );

end Structural;
