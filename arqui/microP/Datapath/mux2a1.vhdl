library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1 is
    Port (
        I0 : in  STD_LOGIC;  -- Entrada 0 (seleccionada si S='0')
        I1 : in  STD_LOGIC;  -- Entrada 1 (seleccionada si S='1')
        S  : in  STD_LOGIC;  -- Selector
        Y  : out STD_LOGIC   -- Salida
    );
end Mux_2a1;

architecture Arq_Mux_2a1 of Mux_2a1 is
begin
    Y <= I0 when S = '0' else I1;
end Arq_Mux_2a1;
