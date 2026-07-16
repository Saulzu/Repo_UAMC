library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1_8b is
    Port (
        I0 : in STD_LOGIC_VECTOR(7 downto 0);
        I1 : in STD_LOGIC_VECTOR(7 downto 0);
        S  : in STD_LOGIC;
        Y  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Mux_2a1_8b;

architecture Arq_Mux_2a1_8b of Mux_2a1_8b is
begin
    -- Lógica puramente booleana aplicando la máscara del selector a todo el vector
    Y <= (I0 and (7 downto 0 => not S)) or 
         (I1 and (7 downto 0 => S));
end Arq_Mux_2a1_8b;