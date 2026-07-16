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
                I : in  STD_LOGIC_VECTOR(1 downto 0); -- Entradas I(0)=I0, I(1)=I1
                S : in  STD_LOGIC;
                Y : out STD_LOGIC
            );
        end component;

        signal r_ua : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la Unidad Aritmética
        signal r_ul : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la Unidad Lógica
        signal internal_R : STD_LOGIC_VECTOR(7 downto 0); -- Resultado interno (salida del multiplexor)
        signal sel_mux_r0 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r1 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r2 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r3 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r4 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r5 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r6 : STD_LOGIC_VECTOR(1 downto 0);
        signal sel_mux_r7 : STD_LOGIC_VECTOR(1 downto 0);

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

        sel_mux_r0 <= r_ul(0) & r_ua(0);
        sel_mux_r1 <= r_ul(1) & r_ua(1);
        sel_mux_r2 <= r_ul(2) & r_ua(2);
        sel_mux_r3 <= r_ul(3) & r_ua(3);
        sel_mux_r4 <= r_ul(4) & r_ua(4);
        sel_mux_r5 <= r_ul(5) & r_ua(5);
        sel_mux_r6 <= r_ul(6) & r_ua(6);
        sel_mux_r7 <= r_ul(7) & r_ua(7);

        MUX_BIT0 : Mux_2a1 port map (I => sel_mux_r0, S => S(3), Y => internal_R(0));
        MUX_BIT1 : Mux_2a1 port map (I => sel_mux_r1, S => S(3), Y => internal_R(1));
        MUX_BIT2 : Mux_2a1 port map (I => sel_mux_r2, S => S(3), Y => internal_R(2));
        MUX_BIT3 : Mux_2a1 port map (I => sel_mux_r3, S => S(3), Y => internal_R(3));
        MUX_BIT4 : Mux_2a1 port map (I => sel_mux_r4, S => S(3), Y => internal_R(4));
        MUX_BIT5 : Mux_2a1 port map (I => sel_mux_r5, S => S(3), Y => internal_R(5));
        MUX_BIT6 : Mux_2a1 port map (I => sel_mux_r6, S => S(3), Y => internal_R(6));
        MUX_BIT7 : Mux_2a1 port map (I => sel_mux_r7, S => S(3), Y => internal_R(7));

        R <= internal_R;

        S_flag <= internal_R(7);

        Z <= not (internal_R(7) or internal_R(6) or internal_R(5) or internal_R(4) or 
                  internal_R(3) or internal_R(2) or internal_R(1) or internal_R(0));

    end Arq_ALU;