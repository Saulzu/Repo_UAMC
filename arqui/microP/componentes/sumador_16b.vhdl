library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sumador_16b is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        S    : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end Sumador_16b;

architecture Arq_Sumador_16b of Sumador_16b is

    -- 1. Declaramos tu sumador base de 1 bit 
    component sumador_completo is
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -- 2. Creamos un cable interno para conectar los acarreos en cascada.
    -- Necesitamos 17 bits (1 de entrada inicial + 16 salidas de cada sumador)
    signal C_interno : STD_LOGIC_VECTOR(16 downto 0);

begin
    -- El primer acarreo es la entrada principal
    C_interno(0) <= Cin;

    -- 3. Generación estructural de los 16 sumadores completos
    GEN_SUMADORES: for i in 0 to 15 generate
        SUM_INST: sumador_completo port map (
            A    => A(i),
            B    => B(i),
            Cin  => C_interno(i),      -- Entra el acarreo de la etapa anterior
            S    => S(i),              -- Sale el bit de suma
            Cout => C_interno(i + 1)   -- Sale el acarreo a la siguiente etapa
        );
    end generate GEN_SUMADORES;

    -- El último acarreo se conecta al puerto de salida
    Cout <= C_interno(16);

end Arq_Sumador_16b;