library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4a1 is
    Port (
        I   : in  STD_LOGIC_VECTOR (3 downto 0);  -- Cuatro entradas de 1 bit (I0, I1, I2, I3)
        S   : in  STD_LOGIC_VECTOR (1 downto 0);  -- Selector de 2 bits: 00->I0, 01->I1, 10->I2, 11->I3
        Y   : out STD_LOGIC                       -- Salida seleccionada (1 bit)
    );
end mux_4a1;

architecture Arq_mux_4a1 of mux_4a1 is
begin

    Y <= (I(0) and (not S(1)) and (not S(0))) or
         (I(1) and (not S(1)) and      S(0) ) or
         (I(2) and      S(1)  and (not S(0))) or
         (I(3) and      S(1)  and      S(0) );

end Arq_mux_4a1;