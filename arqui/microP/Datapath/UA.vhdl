library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unidad_Aritmetica is
    Port (
        A  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A (8 bits)
        B  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B (8 bits)
        S  : in  STD_LOGIC_VECTOR(2 downto 0);  -- Selector de operación (3 bits)
        Ci : in  STD_LOGIC;                     -- Acarreo de entrada
        R  : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la operación aritmética (8 bits)
        Co : out STD_LOGIC;                     -- Acarreo de salida (Carry out)
        Vo : out STD_LOGIC                      -- Overflow
    );
end Unidad_Aritmetica;

architecture Arq_Unidad_Aritmetica of Unidad_Aritmetica is

    component Mux8a1 is
        Port(
            I0,I1,I2,I3,I4,I5,I6,I7 : in STD_LOGIC_VECTOR(7 downto 0);
            S : in STD_LOGIC_VECTOR(2 downto 0);
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component sumador_completo is
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal opA : STD_LOGIC_VECTOR(7 downto 0);      -- Operando A seleccionado (salida del MUX_OP_A)
    signal opB : STD_LOGIC_VECTOR(7 downto 0);      -- Operando B seleccionado (salida del MUX_OP_B)
    signal cero        : STD_LOGIC_VECTOR(7 downto 0) := "00000000";  -- Constante cero para operaciones
    signal uno         : STD_LOGIC_VECTOR(7 downto 0) := "00000001";  -- Constante uno para operaciones
    signal menos_uno   : STD_LOGIC_VECTOR(7 downto 0) := "11111111";  -- Constante -1 (complemento a 2)
    signal B_invertida : STD_LOGIC_VECTOR(7 downto 0);  -- Inverso lógico de B (para restas)

    signal c_int : STD_LOGIC_VECTOR(8 downto 0);  -- Cadena interna de acarreos (9 bits para 8 sumadores + Cin)

begin

    B_invertida <= not B;

    c_int(0) <= Ci;

    MUX_OP_A : Mux8a1
        port map (
            I0 => A, I1 => A, I2 => A, I3 => cero,
            I4 => A, I5 => cero, I6 => A, I7 => cero,
            S  => S, Y  => opA
        );

    MUX_OP_B : Mux8a1
        port map (
            I0 => B, I1 => B_invertida, I2 => cero, I3 => B,
            I4 => uno, I5 => B, I6 => menos_uno, I7 => B,
            S  => S, Y  => opB
        );

    SUM0 : sumador_completo port map (A => opA(0), B => opB(0), Cin => c_int(0), S => R(0), Cout => c_int(1));
    SUM1 : sumador_completo port map (A => opA(1), B => opB(1), Cin => c_int(1), S => R(1), Cout => c_int(2));
    SUM2 : sumador_completo port map (A => opA(2), B => opB(2), Cin => c_int(2), S => R(2), Cout => c_int(3));
    SUM3 : sumador_completo port map (A => opA(3), B => opB(3), Cin => c_int(3), S => R(3), Cout => c_int(4));
    SUM4 : sumador_completo port map (A => opA(4), B => opB(4), Cin => c_int(4), S => R(4), Cout => c_int(5));
    SUM5 : sumador_completo port map (A => opA(5), B => opB(5), Cin => c_int(5), S => R(5), Cout => c_int(6));
    SUM6 : sumador_completo port map (A => opA(6), B => opB(6), Cin => c_int(6), S => R(6), Cout => c_int(7));
    SUM7 : sumador_completo port map (A => opA(7), B => opB(7), Cin => c_int(7), S => R(7), Cout => c_int(8));

    Co <= c_int(8);

    Vo <= c_int(7) xor c_int(8);

end Arq_Unidad_Aritmetica;