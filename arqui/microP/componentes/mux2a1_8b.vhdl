library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1_8b is
    Port (
        I0 : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0 (8 bits)
        I1 : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1 (8 bits)
        S  : in STD_LOGIC;                     -- Selector (1 bit): 0->I0, 1->I1
        Y  : out STD_LOGIC_VECTOR(7 downto 0) -- Salida multiplexada (8 bits)
    );
end Mux_2a1_8b;

architecture Arq_Mux_2a1_8b of Mux_2a1_8b is
begin
    Y <= (I0 and (7 downto 0 => not S)) or 
         (I1 and (7 downto 0 => S));
end Arq_Mux_2a1_8b;