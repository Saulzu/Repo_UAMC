library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4a1 is
    Port (
        I   : in  STD_LOGIC_VECTOR (3 downto 0);
        S   : in  STD_LOGIC_VECTOR (1 downto 0);
        Y   : out STD_LOGIC
    );
end mux_4a1;

architecture Arq_mux_4a1 of mux_4a1 is
begin

    Y <= (I(0) and (not S(1)) and (not S(0))) or
         (I(1) and (not S(1)) and      S(0) ) or
         (I(2) and      S(1)  and (not S(0))) or
         (I(3) and      S(1)  and      S(0) );

end Arq_mux_4a1;