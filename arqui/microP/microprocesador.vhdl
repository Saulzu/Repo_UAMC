library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Microprocesador is
    Port (
        CLK : in STD_LOGIC;
        -- Puertos adicionales externos si se requieren pines de I/O
        RST : in STD_LOGIC 
    );
end Microprocesador;

architecture Estructural of Microprocesador is

    -- Declaración de Componentes
    component Datapath is
        Port ( 
            CLK : in STD_LOGIC;
            W_UR, L_OR, Ci, m1, m2 : in STD_LOGIC;
            DC, DA, DB : in STD_LOGIC_VECTOR(2 downto 0);
            S : in STD_LOGIC_VECTOR(4 downto 0);
            Datos_Memoria : in STD_LOGIC_VECTOR(7 downto 0);
            Dir_Memoria, Datos_Escribir : out STD_LOGIC_VECTOR(7 downto 0);
            C, S_flag, V, Z : out STD_LOGIC
        );
    end component;

    component UC is
        Port ( 
            CLK, InA, InB, w_prime, mw_param : in STD_LOGIC;
            D_Memoria_16 : in STD_LOGIC_VECTOR(15 downto 0);
            D_Memoria_26 : in STD_LOGIC_VECTOR(25 downto 0);
            C_flag, S_flag, V_flag, Z_flag : in STD_LOGIC;
            PC_Out : out STD_LOGIC_VECTOR(15 downto 0);
            IR_Out : out STD_LOGIC_VECTOR(25 downto 0);
            MW_Output : out STD_LOGIC
        );
    end component;

    component Logica_Saltos is
        Port (
            S4, S3, S2, S1, S0 : in STD_LOGIC;
            C_flag, S_flag, V_flag, Z_flag : in STD_LOGIC;
            Jump_Taken : out STD_LOGIC
        );
    end component;

    -- Señales internas de interconexión
    signal C_out, S_out, V_out, Z_out : STD_LOGIC;
    signal Instruction_Bus : STD_LOGIC_VECTOR(25 downto 0);
    signal PC_Bus : STD_LOGIC_VECTOR(15 downto 0);
    signal Jump_Signal : STD_LOGIC;

begin

    -- Instanciación de la Unidad de Control
    UC_Inst : UC port map (
        CLK => CLK,
        InA => '0',       -- A conectar según la lógica de tu secuenciador
        InB => '0',       -- A conectar según la lógica de tu secuenciador
        w_prime => '1',   -- Señal de fetch
        mw_param => '0',  
        D_Memoria_16 => (others => '0'), -- Conectar a Memoria de Instrucciones
        D_Memoria_26 => (others => '0'), -- Conectar a Memoria de Instrucciones
        C_flag => C_out,
        S_flag => S_out,
        V_flag => V_out,
        Z_flag => Z_out,
        PC_Out => PC_Bus,
        IR_Out => Instruction_Bus,
        MW_Output => open
    );

    -- Instanciación del Datapath
    Datapath_Inst : Datapath port map (
        CLK => CLK,
        W_UR => Instruction_Bus(25), -- Ejemplo de mapeo desde IR
        L_OR => Instruction_Bus(24),
        Ci   => Instruction_Bus(23),
        m1   => Instruction_Bus(22),
        m2   => Instruction_Bus(21),
        DC   => Instruction_Bus(20 downto 18),
        DA   => Instruction_Bus(17 downto 15),
        DB   => Instruction_Bus(14 downto 12),
        S    => Instruction_Bus(4 downto 0), -- Selector de ALU / Saltos (S4..S0)
        Datos_Memoria => (others => '0'),    -- Conectar a RAM de Datos
        Dir_Memoria => open,
        Datos_Escribir => open,
        C => C_out,
        S_flag => S_out,
        V => V_out,
        Z => Z_out
    );

    -- Instanciación de Lógica de Saltos
    Jump_Logic_Inst : Logica_Saltos port map (
        S4 => Instruction_Bus(4),
        S3 => Instruction_Bus(3),
        S2 => Instruction_Bus(2),
        S1 => Instruction_Bus(1),
        S0 => Instruction_Bus(0),
        C_flag => C_out,
        S_flag => S_out,
        V_flag => V_out,
        Z_flag => Z_out,
        Jump_Taken => Jump_Signal
    );

    -- Jump_Signal deberá conectarse a la habilitación de carga de tu PC en la UC

end Estructural;