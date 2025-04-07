library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SOMMATORE_CLA is
  Port (
        X : in STD_LOGIC_VECTOR(3 downto 0);
        Y : in STD_LOGIC_VECTOR(3 downto 0);
        CIN : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(3 downto 0);
        COUT : out STD_LOGIC
   );
end SOMMATORE_CLA;

architecture Structural of SOMMATORE_CLA is
    
    signal P_interno, G_interno : STD_LOGIC_VECTOR(3 downto 0);
    signal C_interno : STD_LOGIC_VECTOR(4 downto 0);
    
    component Calcola_G_P is  
        Port (
            X : in STD_LOGIC_VECTOR(3 downto 0);
            Y : in STD_LOGIC_VECTOR(3 downto 0);
            P : out STD_LOGIC_VECTOR(3 downto 0);
            G : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component Calcola_Riporti is
        Port (
            G : in STD_LOGIC_VECTOR(3 downto 0);
            P : in STD_LOGIC_VECTOR(3 downto 0);
            Cin : in STD_LOGIC;
            C : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    component Calcola_Somme is
        Port (
            P : in STD_LOGIC_VECTOR(3 downto 0);
            C : in STD_LOGIC_VECTOR(3 downto 0);
            S : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin

    Generate_Propagate : Calcola_G_P
        Port Map (
            X => X, 
            Y => Y,
            P => P_interno,
            G => G_interno
        );
        
    Riporti : Calcola_Riporti
        Port Map (
            G => G_interno, 
            P => P_interno,
            Cin => CIN,
            C => C_interno
        );
     
     Somme : Calcola_Somme
        Port Map (
            P => P_interno, 
            C => C_interno(3 downto 0),
            S => S
        );
     
     COUT <= c_interno(4);

end Structural;
