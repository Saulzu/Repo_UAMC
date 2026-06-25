library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1 is
    Port (
        I0 : in  STD_LOGIC;
        I1 : in  STD_LOGIC;
        S  : in  STD_LOGIC;
        Y  : out STD_LOGIC
    );
end Mux_2a1;

architecture Arq_Mux_2a1 of Mux_2a1 is
begin
    Y <= I0 when S = '0' else I1;
end Arq_Mux_2a1;
