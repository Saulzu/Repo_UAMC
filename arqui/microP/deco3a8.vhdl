library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco_3a8 is
    Port (
        S : in  STD_LOGIC_VECTOR (2 downto 0);
        Y : out STD_LOGIC_VECTOR (7 downto 0)
    );
end deco_3a8;

architecture Arq_deco_3a8 of deco_3a8 is
begin

    Y(0) <= (not S(2)) and (not S(1)) and (not S(0));
    Y(1) <= (not S(2)) and (not S(1)) and      S(0) ;
    Y(2) <= (not S(2)) and      S(1)  and (not S(0));
    Y(3) <= (not S(2)) and      S(1)  and      S(0) ;
    Y(4) <=      S(2)  and (not S(1)) and (not S(0));
    Y(5) <=      S(2)  and (not S(1)) and      S(0) ;
    Y(6) <=      S(2)  and      S(1)  and (not S(0));
    Y(7) <=      S(2)  and      S(1)  and      S(0) ;

end Arq_deco_3a8;