library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_completo is
    Port (
        A    : in  STD_LOGIC;   -- Entrada A
        B    : in  STD_LOGIC;   -- Entrada B
        Cin  : in  STD_LOGIC;   -- Acarreo de entrada
        S    : out STD_LOGIC;   -- Suma (resultado bit)
        Cout : out STD_LOGIC    -- Acarreo de salida
    );
end sumador_completo;

architecture Arq_sumador_completo of sumador_completo is
begin

    S <= A xor B xor Cin;
    
    Cout <= (A and B) or (Cin and (A xor B));

end Arq_sumador_completo;