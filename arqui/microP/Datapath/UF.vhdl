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
            A      : in  STD_LOGIC_VECTOR(7 downto 0);
            B      : in  STD_LOGIC_VECTOR(7 downto 0);
            S      : in  STD_LOGIC_VECTOR(3 downto 0);
            Ci     : in  STD_LOGIC;
            R      : out STD_LOGIC_VECTOR(7 downto 0);
            C      : out STD_LOGIC;
            V      : out STD_LOGIC;
            S_flag : out STD_LOGIC;
            Z      : out STD_LOGIC
        );
    end component;

    component Shifterr is
        Port (
            Q  : in  STD_LOGIC_VECTOR(7 downto 0);
            S  : in  STD_LOGIC_VECTOR(1 downto 0);
            D  : out STD_LOGIC_VECTOR(7 downto 0);
            CI : out STD_LOGIC;
            CD : out STD_LOGIC
        );
    end component;

    component Mux_2a1 is
        Port (
            I0 : in  STD_LOGIC;
            I1 : in  STD_LOGIC;
            S  : in  STD_LOGIC;
            Y  : out STD_LOGIC
        );
    end component;

    component mux_4a1 is
        Port (
            I : in  STD_LOGIC_VECTOR (3 downto 0);
            S : in  STD_LOGIC_VECTOR (1 downto 0);
            Y : out STD_LOGIC
        );
    end component;

    signal r_alu      : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la ALU
    signal r_shifter  : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado del Shifter
    signal alu_c      : STD_LOGIC;                      -- Bandera de acarreo de la ALU
    signal alu_v      : STD_LOGIC;                      -- Bandera de overflow de la ALU
    signal shift_ci   : STD_LOGIC;                      -- Acarreo de entrada del shifter
    signal shift_cd   : STD_LOGIC;                      -- Acarreo de salida del shifter
    signal internal_R : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado interno antes de salida final
    signal mux_c_inputs : STD_LOGIC_VECTOR(3 downto 0); -- Inputs para multiplexor de bandera C
    signal selector_c   : STD_LOGIC_VECTOR(1 downto 0); -- Selector para multiplexor de bandera C

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

    MUX_R0 : Mux_2a1 port map (I0 => r_alu(0), I1 => r_shifter(0), S => S(4), Y => internal_R(0));
    MUX_R1 : Mux_2a1 port map (I0 => r_alu(1), I1 => r_shifter(1), S => S(4), Y => internal_R(1));
    MUX_R2 : Mux_2a1 port map (I0 => r_alu(2), I1 => r_shifter(2), S => S(4), Y => internal_R(2));
    MUX_R3 : Mux_2a1 port map (I0 => r_alu(3), I1 => r_shifter(3), S => S(4), Y => internal_R(3));
    MUX_R4 : Mux_2a1 port map (I0 => r_alu(4), I1 => r_shifter(4), S => S(4), Y => internal_R(4));
    MUX_R5 : Mux_2a1 port map (I0 => r_alu(5), I1 => r_shifter(5), S => S(4), Y => internal_R(5));
    MUX_R6 : Mux_2a1 port map (I0 => r_alu(6), I1 => r_shifter(6), S => S(4), Y => internal_R(6));
    MUX_R7 : Mux_2a1 port map (I0 => r_alu(7), I1 => r_shifter(7), S => S(4), Y => internal_R(7));

    R <= internal_R;

    MUX_V_FLAG : Mux_2a1 
        port map (
            I0 => alu_v,
            I1 => '0',
            S  => S(4),
            Y  => V
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