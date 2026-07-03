library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unidad_Logica is
    Port (
        A : in  STD_LOGIC_VECTOR(7 downto 0);      -- Operando A (8 bits)
        B : in  STD_LOGIC_VECTOR(7 downto 0);      -- Operando B (8 bits)
        S : in  STD_LOGIC_VECTOR(2 downto 0);      -- Selector de operación (3 bits)
        R : out STD_LOGIC_VECTOR(7 downto 0);      -- Resultado de la operación lógica (8 bits)
        S_flag : out STD_LOGIC;                    -- Bandera de signo (bit 7 del resultado)
        Z : out STD_LOGIC                          -- Bandera de cero
    );
end Unidad_Logica;

architecture Arq_Unidad_Logica of Unidad_Logica is

    component Mux8a1 is
        Port(
            I0,I1,I2,I3,I4,I5,I6,I7 : in STD_LOGIC_VECTOR(7 downto 0);
            S : in STD_LOGIC_VECTOR(2 downto 0);
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal res_and  : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de A AND B
    signal res_or   : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de A OR B
    signal res_xor  : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de A XOR B
    signal res_nor  : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de A NOR B
    signal res_nand : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de A NAND B
    signal res_notA : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de NOT A
    signal res_notB : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de NOT B
    signal internal_R : STD_LOGIC_VECTOR(7 downto 0); -- Resultado interno (salida del multiplexor)

begin

    res_and  <= A and B;
    res_or   <= A or B;
    res_xor  <= A xor B;
    res_nor  <= A nor B;
    res_nand <= A nand B;
    res_notA <= not A;
    res_notB <= not B;

    MUX_UL : Mux8a1 
        port map (
            I0 => res_and,
            I1 => res_or,
            I2 => res_xor,
            I3 => res_nor,
            I4 => res_nand,
            I5 => res_notA,
            I6 => res_notB,
            I7 => B,
            S  => S,
            Y  => internal_R
        );

    R <= internal_R;

    S_flag <= internal_R(7);

    Z <= not (internal_R(7) or internal_R(6) or internal_R(5) or internal_R(4) or 
              internal_R(3) or internal_R(2) or internal_R(1) or internal_R(0));

end Arq_Unidad_Logica;