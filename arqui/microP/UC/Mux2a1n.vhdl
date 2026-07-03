library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1_n is
    Port (
        I0 : in  STD_LOGIC;  -- Entrada 0 del multiplexor (seleccionada si S='0')
        I1 : in  STD_LOGIC;  -- Entrada 1 del multiplexor (seleccionada si S='1')
        S  : in  STD_LOGIC;  -- Selector del multiplexor
        Y  : out STD_LOGIC   -- Salida del multiplexor
    );
end Mux_2a1_n;

architecture Arq_Mux_2a1n of Mux_2a1_n is
begin
    Y <= I0 when S = '0' else I1;
end Arq_Mux_2a1n;
