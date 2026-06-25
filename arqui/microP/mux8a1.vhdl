library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8a1 is
    Port(
        I0,I1,I2,I3,I4,I5,I6,I7 : in STD_LOGIC_VECTOR(7 downto 0);
        S : in STD_LOGIC_VECTOR(2 downto 0);
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Mux8a1;

architecture Arq_Mux8a1 of Mux8a1 is

signal D0,D1,D2,D3,D4,D5,D6,D7 : STD_LOGIC;

begin

D0 <= not S(2) and not S(1) and not S(0);
D1 <= not S(2) and not S(1) and     S(0);
D2 <= not S(2) and     S(1) and not S(0);
D3 <= not S(2) and     S(1) and     S(0);
D4 <=     S(2) and not S(1) and not S(0);
D5 <=     S(2) and not S(1) and     S(0);
D6 <=     S(2) and     S(1) and not S(0);
D7 <=     S(2) and     S(1) and     S(0);

Y <= (I0 and (7 downto 0 => D0)) or
     (I1 and (7 downto 0 => D1)) or
     (I2 and (7 downto 0 => D2)) or
     (I3 and (7 downto 0 => D3)) or
     (I4 and (7 downto 0 => D4)) or
     (I5 and (7 downto 0 => D5)) or
     (I6 and (7 downto 0 => D6)) or
     (I7 and (7 downto 0 => D7));

end Arq_Mux8a1;
