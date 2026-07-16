library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Deco2a4 is
    Port ( 
        S : in  STD_LOGIC_VECTOR(1 downto 0); -- Entrada de selección (2 bits)
        Y : out STD_LOGIC_VECTOR(3 downto 0)  -- Salida descodificada (4 líneas)
    );
end Deco2a4;

architecture Arq_Deco2a4 of Deco2a4 is
begin
    Y(0) <= (not S(1)) and (not S(0));
    Y(1) <= (not S(1)) and S(0);
    Y(2) <= S(1) and (not S(0));
    Y(3) <= S(1) and S(0);
end Arq_Deco2a4;