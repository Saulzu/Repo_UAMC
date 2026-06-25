library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unidad_Funcional is
    Port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0); -- Bus A
        B      : in  STD_LOGIC_VECTOR(7 downto 0); -- Bus B
        S      : in  STD_LOGIC_VECTOR(4 downto 0); -- Bus S(4:0) global
        Ci     : in  STD_LOGIC;                    -- Acarreo de entrada
        R      : out STD_LOGIC_VECTOR(7 downto 0); -- Resultado final
        C      : out STD_LOGIC;                    -- Bandera C
        V      : out STD_LOGIC;                    -- Bandera V
        S_flag : out STD_LOGIC;                    -- Bandera S
        Z      : out STD_LOGIC                     -- Bandera Z
    );
end Unidad_Funcional;

architecture Arq_Unidad_Funcional of Unidad_Funcional is

    -- ========================================================
    -- DECLARACIÓN DE COMPONENTES
    -- ========================================================
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
            library IEEE;
            use IEEE.STD_LOGIC_1164.ALL;

            entity Unidad_Funcional is
                Port (
                    A      : in  STD_LOGIC_VECTOR(7 downto 0);
                    B      : in  STD_LOGIC_VECTOR(7 downto 0);
                    S      : in  STD_LOGIC_VECTOR(4 downto 0);
                    Ci     : in  STD_LOGIC;
                    R      : out STD_LOGIC_VECTOR(7 downto 0);
                    C      : out STD_LOGIC;
                    V      : out STD_LOGIC;
                    S_flag : out STD_LOGIC;
                    Z      : out STD_LOGIC
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

                signal r_alu      : STD_LOGIC_VECTOR(7 downto 0);
                signal r_shifter  : STD_LOGIC_VECTOR(7 downto 0);
    
                signal alu_c      : STD_LOGIC;
                signal alu_v      : STD_LOGIC;
    
                signal shift_ci   : STD_LOGIC;
                signal shift_cd   : STD_LOGIC;
    
                signal internal_R : STD_LOGIC_VECTOR(7 downto 0);
    
                signal mux_c_inputs : STD_LOGIC_VECTOR(3 downto 0);
                signal selector_c   : STD_LOGIC_VECTOR(1 downto 0);

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
            Y => C
        );

    -- 6. Banderas globales calculadas del bus de salida general R
    
    -- S (Signo): Es igual al bit Rn-1 (bit 7 de nuestro resultado)
    S_flag <= internal_R(7);

    -- Z (Cero): Reducción NOR estructural sobre las líneas del bus
    Z <= not (internal_R(7) or internal_R(6) or internal_R(5) or internal_R(4) or 
              internal_R(3) or internal_R(2) or internal_R(1) or internal_R(0));

end Arq_Unidad_Funcional;