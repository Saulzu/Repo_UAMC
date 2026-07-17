library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sumador_16b is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0); -- Primer operando (16 bits)
        B    : in  STD_LOGIC_VECTOR(15 downto 0); -- Segundo operando (16 bits)
        Cin  : in  STD_LOGIC;                     -- Acarreo de entrada
        S    : out STD_LOGIC_VECTOR(15 downto 0); -- Resultado de la suma (16 bits)
        Cout : out STD_LOGIC                      -- Acarreo de salida
    );
end Sumador_16b;

architecture Arq_Sumador_16b of Sumador_16b is

    component sumador_completo is
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal C_interno : STD_LOGIC_VECTOR(16 downto 0);

begin
    C_interno(0) <= Cin;

    GEN_SUMADORES: for i in 0 to 15 generate
        SUM_INST: sumador_completo port map (
            A    => A(i),
            B    => B(i),
            Cin  => C_interno(i),      -- Entra el acarreo de la etapa anterior
            S    => S(i),              -- Sale el bit de suma
            Cout => C_interno(i + 1)   -- Sale el acarreo a la siguiente etapa
        );
    end generate GEN_SUMADORES;

    Cout <= C_interno(16);

end Arq_Sumador_16b;