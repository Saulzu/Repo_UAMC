library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1 is
    Port (
        I : in STD_LOGIC_VECTOR(1 downto 0); -- I(0) funciona como I0, I(1) como I1
        S : in STD_LOGIC;                    -- Selector (1 bit)
        Y : out STD_LOGIC                    -- Salida (1 bit)
    );
end Mux_2a1;

architecture Arq_Mux_2a1 of Mux_2a1 is
begin
    Y <= (I(0) and not S) or (I(1) and S);
end Arq_Mux_2a1;