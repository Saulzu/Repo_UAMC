library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Deco2a4 is
    Port (
        S : in  STD_LOGIC_VECTOR(1 downto 0);  -- Entrada de selección (2 bits)
        Y : out STD_LOGIC_VECTOR(3 downto 0)   -- Salida descodificada (4 líneas, solo una activa en '1')
    );
end Deco2a4;

architecture Arq_Deco2a4 of Deco2a4 is
    signal s0_n, s1_n : STD_LOGIC;  -- Inversas de las líneas de entrada
begin
    s0_n <= not S(0);
    s1_n <= not S(1);

    Y(0) <= s1_n and s0_n;
    Y(1) <= s1_n and S(0);
    Y(2) <= S(1) and s0_n;
    Y(3) <= S(1) and S(0);

end Arq_Deco2a4;