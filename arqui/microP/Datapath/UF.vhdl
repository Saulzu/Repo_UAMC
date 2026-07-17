library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unidad_Funcional is
    Port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A (entrada 8 bits)
        B      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B (entrada 8 bits)
        S      : in  STD_LOGIC_VECTOR(4 downto 0);  -- Selector de operación (5 bits): S(4)=ALU/Shifter, S(3:0)=operación
        Ci     : in  STD_LOGIC;                     -- Acarreo de entrada
        R      : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado final (8 bits)
        C      : out STD_LOGIC;                     -- Bandera de acarreo (Carry)
        V      : out STD_LOGIC;                     -- Bandera de overflow
        S_flag : out STD_LOGIC;                     -- Bandera de signo (bit más significativo)
        Z      : out STD_LOGIC                      -- Bandera de cero
    );
end Unidad_Funcional;

architecture Arq_Unidad_Funcional of Unidad_Funcional is

    component ALU is
        Port (
            A      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A
            B      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B
            S      : in  STD_LOGIC_VECTOR(3 downto 0);  -- Selector de operación ALU
            Ci     : in  STD_LOGIC;                     -- Acarreo de entrada
            R      : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado ALU
            C      : out STD_LOGIC;                     -- Carry out
            V      : out STD_LOGIC;                     -- Overflow
            S_flag : out STD_LOGIC;                     -- Sign flag
            Z      : out STD_LOGIC                      -- Zero flag
        );
    end component;

    component Shifterr is
        Port (
            Q  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Entrada a desplazar
            S  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Selector de desplazamiento
            D  : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado desplazado
            CI : out STD_LOGIC;                     -- Carry izquierdo
            CD : out STD_LOGIC                      -- Carry derecho
        );
    end component;

    component Mux_2a1 is
        Port (
            I : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dos entradas
            S : in  STD_LOGIC;                     -- Señal de selección
            Y : out STD_LOGIC                      -- Salida seleccionada
        );
    end component;

    component mux_4a1 is
        Port (
            I : in  STD_LOGIC_VECTOR (3 downto 0);  -- Cuatro entradas
            S : in  STD_LOGIC_VECTOR (1 downto 0);  -- Selector de 2 bits
            Y : out STD_LOGIC                       -- Salida
        );
    end component;

    signal r_alu      : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la ALU (operación aritmética o lógica)
    signal r_shifter  : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado del Shifter (desplazamiento de bits)
    signal alu_c      : STD_LOGIC;                      -- Bandera de acarreo (Carry) proveniente de la ALU
    signal alu_v      : STD_LOGIC;                      -- Bandera de overflow proveniente de la ALU
    signal shift_ci   : STD_LOGIC;                      -- Bit desplazado desde la izquierda del Shifter (Carry In)
    signal shift_cd   : STD_LOGIC;                      -- Bit desplazado desde la derecha del Shifter (Carry Out)
    signal internal_R : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado seleccionado entre ALU y Shifter (antes de salida)
    signal mux_c_inputs : STD_LOGIC_VECTOR(3 downto 0); -- Entradas del multiplexor de bandera C (2 del ALU, 2 del Shifter)
    signal selector_c   : STD_LOGIC_VECTOR(1 downto 0); -- Señal de selección para el multiplexor de C (S(4) y S(0))
    signal sel_mux_r0, sel_mux_r1, sel_mux_r2, sel_mux_r3 : STD_LOGIC_VECTOR(1 downto 0); -- Entradas de multiplexores para bits 0-3
    signal sel_mux_r4, sel_mux_r5, sel_mux_r6, sel_mux_r7 : STD_LOGIC_VECTOR(1 downto 0); -- Entradas de multiplexores para bits 4-7
    signal sel_mux_v_flag : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada del multiplexor para la bandera V (0 o alu_v)

begin

    ALU_BLOCK : ALU
        port map (
            A      => A,
            B      => B,
            S      => S(3 downto 0),
            Ci     => Ci,
            R      => r_alu,
            C      => alu_c,
            V      => alu_v,
            S_flag => open,
            Z      => open
        );

    SHIFT_BLOCK : Shifterr
        port map (
            Q  => A,
            S  => S(2 downto 1),
            D  => r_shifter,
            CI => shift_ci,
            CD => shift_cd
        );

    sel_mux_r0 <= r_shifter(0) & r_alu(0);
    sel_mux_r1 <= r_shifter(1) & r_alu(1);
    sel_mux_r2 <= r_shifter(2) & r_alu(2);
    sel_mux_r3 <= r_shifter(3) & r_alu(3);
    sel_mux_r4 <= r_shifter(4) & r_alu(4);
    sel_mux_r5 <= r_shifter(5) & r_alu(5);
    sel_mux_r6 <= r_shifter(6) & r_alu(6);
    sel_mux_r7 <= r_shifter(7) & r_alu(7);

    MUX_R0 : Mux_2a1 port map (I => sel_mux_r0, S => S(4), Y => internal_R(0));
    MUX_R1 : Mux_2a1 port map (I => sel_mux_r1, S => S(4), Y => internal_R(1));
    MUX_R2 : Mux_2a1 port map (I => sel_mux_r2, S => S(4), Y => internal_R(2));
    MUX_R3 : Mux_2a1 port map (I => sel_mux_r3, S => S(4), Y => internal_R(3));
    MUX_R4 : Mux_2a1 port map (I => sel_mux_r4, S => S(4), Y => internal_R(4));
    MUX_R5 : Mux_2a1 port map (I => sel_mux_r5, S => S(4), Y => internal_R(5));
    MUX_R6 : Mux_2a1 port map (I => sel_mux_r6, S => S(4), Y => internal_R(6));
    MUX_R7 : Mux_2a1 port map (I => sel_mux_r7, S => S(4), Y => internal_R(7));

    R <= internal_R;

    sel_mux_v_flag <= '0' & alu_v;

    MUX_V_FLAG : Mux_2a1 
        port map (
            I => sel_mux_v_flag,
            S => S(4),
            Y => V
        );

    mux_c_inputs(0) <= alu_c;
    mux_c_inputs(1) <= alu_c;
    mux_c_inputs(2) <= shift_ci;
    mux_c_inputs(3) <= shift_cd;

    selector_c <= S(4) & S(0);

    MUX_C_FLAG : mux_4a1
        port map (
            I => mux_c_inputs,
            S => selector_c,
            Y => C
        );

    S_flag <= internal_R(7);

    Z <= not (internal_R(7) or internal_R(6) or internal_R(5) or internal_R(4) or 
              internal_R(3) or internal_R(2) or internal_R(1) or internal_R(0));

end Arq_Unidad_Funcional;