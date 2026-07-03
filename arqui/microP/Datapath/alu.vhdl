library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A (8 bits)
        B      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B (8 bits)
        S      : in  STD_LOGIC_VECTOR(3 downto 0);  -- Selector de operación (4 bits): S(3)=ALU/Logic, S(2:0)=operación
        Ci     : in  STD_LOGIC;                     -- Acarreo de entrada
        R      : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado final (8 bits)
        C      : out STD_LOGIC;                     -- Bandera de acarreo (Carry)
        V      : out STD_LOGIC;                     -- Bandera de overflow
        S_flag : out STD_LOGIC;                     -- Bandera de signo (bit 7)
        Z      : out STD_LOGIC                      -- Bandera de cero
    );
end ALU;

architecture Arq_ALU of ALU is

        component Unidad_Logica is
            Port (
                A      : in  STD_LOGIC_VECTOR(7 downto 0);
                B      : in  STD_LOGIC_VECTOR(7 downto 0);
                S      : in  STD_LOGIC_VECTOR(2 downto 0);
                R      : out STD_LOGIC_VECTOR(7 downto 0);
                S_flag : out STD_LOGIC;
                Z      : out STD_LOGIC
            );
        end component;

        component Unidad_Aritmetica is
            Port (
                A  : in  STD_LOGIC_VECTOR(7 downto 0);
                B  : in  STD_LOGIC_VECTOR(7 downto 0);
                S  : in  STD_LOGIC_VECTOR(2 downto 0);
                Ci : in  STD_LOGIC;
                R  : out STD_LOGIC_VECTOR(7 downto 0);
                Co : out STD_LOGIC;
                Vo : out STD_LOGIC
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

        signal r_ua : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la Unidad Aritmética
        signal r_ul : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la Unidad Lógica
        signal internal_R : STD_LOGIC_VECTOR(7 downto 0); -- Resultado interno (salida del multiplexor)

    begin

        UA_INST : Unidad_Aritmetica
            port map (
                A  => A,
                B  => B,
                S  => S(2 downto 0),
                Ci => Ci,
                R  => r_ua,
                Co => C,
                Vo => V
            );

        UL_INST : Unidad_Logica
            port map (
                A      => A,
                B      => B,
                S      => S(2 downto 0),
                R      => r_ul,
                S_flag => open,
                Z      => open
            );

        MUX_BIT0 : Mux_2a1 port map (I0 => r_ua(0), I1 => r_ul(0), S => S(3), Y => internal_R(0));
        MUX_BIT1 : Mux_2a1 port map (I0 => r_ua(1), I1 => r_ul(1), S => S(3), Y => internal_R(1));
        MUX_BIT2 : Mux_2a1 port map (I0 => r_ua(2), I1 => r_ul(2), S => S(3), Y => internal_R(2));
        MUX_BIT3 : Mux_2a1 port map (I0 => r_ua(3), I1 => r_ul(3), S => S(3), Y => internal_R(3));
        MUX_BIT4 : Mux_2a1 port map (I0 => r_ua(4), I1 => r_ul(4), S => S(3), Y => internal_R(4));
        MUX_BIT5 : Mux_2a1 port map (I0 => r_ua(5), I1 => r_ul(5), S => S(3), Y => internal_R(5));
        MUX_BIT6 : Mux_2a1 port map (I0 => r_ua(6), I1 => r_ul(6), S => S(3), Y => internal_R(6));
        MUX_BIT7 : Mux_2a1 port map (I0 => r_ua(7), I1 => r_ul(7), S => S(3), Y => internal_R(7));

        R <= internal_R;

        S_flag <= internal_R(7);

        Z <= not (internal_R(7) or internal_R(6) or internal_R(5) or internal_R(4) or 
                  internal_R(3) or internal_R(2) or internal_R(1) or internal_R(0));

    end Arq_ALU;