library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( 
        CLK          : in  STD_LOGIC;                       -- Señal de reloj principal de la Unidad de Control
        InA, InB     : in  STD_LOGIC;                       -- Entradas de control del secuenciador
        w_prime      : in  STD_LOGIC;                       -- Habilitador de escritura del IR durante el ciclo de fetch
        mw_param     : in  STD_LOGIC;                       -- Parámetro de control para salida de memoria/escritura
        D_Memoria_16 : in  STD_LOGIC_VECTOR(15 downto 0);    -- Bus de 16 bits para direccionamiento o datos de memoria
        D_Memoria_26 : in  STD_LOGIC_VECTOR(25 downto 0);    -- Bus de 26 bits con instrucción completa desde memoria
        
        -- Banderas del Datapath necesarias para la lógica de salto
        C_flag       : in  STD_LOGIC;                       -- Bandera de acarreo
        S_flag       : in  STD_LOGIC;                       -- Bandera de signo
        V_flag       : in  STD_LOGIC;                       -- Bandera de overflow
        Z_flag       : in  STD_LOGIC;                       -- Bandera de cero
        
        PC_Out       : out STD_LOGIC_VECTOR(15 downto 0);   -- Salida de la dirección actual del PC
        IR_Out       : out STD_LOGIC_VECTOR(25 downto 0);   -- Salida de la instrucción actual almacenada en IR
        MW_Output    : out STD_LOGIC                        -- Señal de control para escritura en memoria o memoria de datos
    );
end UC;

architecture Arq_Uc of UC is

    -- 1. Declaración de Componentes
    component PC is 
        Port ( 
            CLK : in STD_LOGIC;                       -- Señal de reloj
            W   : in STD_LOGIC;                       -- Habilitación de carga del PC
            C   : in STD_LOGIC_VECTOR(15 downto 0);   -- Dirección a cargar
            Q   : out STD_LOGIC_VECTOR(15 downto 0)   -- Dirección actual
        ); 
    end component;
    
    component Ir is 
        Port ( 
            CLK : in STD_LOGIC;                       -- Señal de reloj
            W   : in STD_LOGIC;                       -- Habilitación de carga del IR
            D   : in STD_LOGIC_VECTOR(25 downto 0);   -- Instrucción a cargar
            Q   : out STD_LOGIC_VECTOR(25 downto 0)   -- Instrucción almacenada
        ); 
    end component;
    
    component Sec is 
        Port ( 
            CLK  : in STD_LOGIC;  -- Señal de reloj
            InA  : in STD_LOGIC;  -- Entrada de control A
            InB  : in STD_LOGIC;  -- Entrada de control B
            e0   : out STD_LOGIC; -- Salida estado 0
            e1   : out STD_LOGIC; -- Salida estado 1
            e2   : out STD_LOGIC; -- Salida estado 2
            e3   : out STD_LOGIC  -- Salida estado 3
        ); 
    end component;

    -- Componentes estructurales añadidos del diagrama
    component Sumador_16b is
        Port ( 
            A    : in STD_LOGIC_VECTOR(15 downto 0);  -- Primer operando
            B    : in STD_LOGIC_VECTOR(15 downto 0);  -- Segundo operando
            Cin  : in STD_LOGIC;                      -- Acarreo de entrada
            S    : out STD_LOGIC_VECTOR(15 downto 0); -- Suma resultado
            Cout : out STD_LOGIC                      -- Acarreo de salida
        ); 
    end component;

    component Mux_2a1_16b is
        Port ( 
            I0 : in STD_LOGIC_VECTOR(15 downto 0);  -- Entrada 0 (dirección secuencial)
            I1 : in STD_LOGIC_VECTOR(15 downto 0);  -- Entrada 1 (dirección de salto)
            S  : in STD_LOGIC;                      -- Señal de selección
            Y  : out STD_LOGIC_VECTOR(15 downto 0)  -- Salida seleccionada
        ); 
    end component;

    -- 2. Señales Internas
    signal e0, e1, e2, e3 : STD_LOGIC;                    -- Salidas del secuenciador (4 estados diferentes de la máquina de estados)
    signal pc_w_signal    : STD_LOGIC;                    -- Habilitador de carga del PC (cuando es '1', el PC carga el nuevo valor)
    signal w_ir_internal  : STD_LOGIC;                    -- Habilitador interno de escritura del IR (carga la nueva instrucción)
    
    -- Señales para rutear las salidas de los registros
    signal q_pc_internal  : STD_LOGIC_VECTOR(15 downto 0); -- Dirección actual del programa (salida del registro PC)
    signal q_ir_internal  : STD_LOGIC_VECTOR(25 downto 0); -- Instrucción actual almacenada en el registro IR
    
    -- Señales de los componentes combinacionales
    signal out_sumador    : STD_LOGIC_VECTOR(15 downto 0); -- Resultado de PC + offset (para saltos relativos)
    signal out_mux2a1_pc  : STD_LOGIC_VECTOR(15 downto 0); -- Selección entre PC+1 (secuencial) o dirección de salto
    
    -- Señales para la lógica de saltos (evaluador de condiciones de bandera)
    signal selector_mux2  : STD_LOGIC;                    -- Señal que selecciona si se toma un salto condicional
    signal m0, m1, m2, m3, m4, m5, m6, m7 : STD_LOGIC;     -- Minterminos para decodificar el tipo de salto y evaluar su condición
    signal jump_condition : STD_LOGIC;                    -- Señal combinada: 1 si la condición del salto es verdadera

begin
    -- 3. Instancia del Secuenciador
    SECUENCIADOR_INST : Sec port map (
        CLK => CLK, InA => InA, InB => InB, 
        e0 => e0, e1 => e1, e2 => e2, e3 => e3
    );

    -- 4. Instancia del Registro de Instrucción (IR)
    IR_BLOCK : Ir port map (
        CLK => CLK, 
        W   => w_ir_internal, 
        D   => D_Memoria_26, 
        Q   => q_ir_internal
    );

    -- Lógica Booleana Pura (Palabra de Control)
    pc_w_signal   <= e0; 
    w_ir_internal <= e1 and w_prime;
    MW_Output     <= e1 and mw_param;

    -- 5. Lógica del MUX 8a1 a nivel de compuertas (Evaluador de banderas)
    -- Usa los bits S(2:0) del IR para seleccionar la bandera correspondiente.
    m0 <= not q_ir_internal(2) and not q_ir_internal(1) and not q_ir_internal(0) and C_flag;
    m1 <= not q_ir_internal(2) and not q_ir_internal(1) and     q_ir_internal(0) and S_flag;
    m2 <= not q_ir_internal(2) and     q_ir_internal(1) and not q_ir_internal(0) and V_flag;
    m3 <= not q_ir_internal(2) and     q_ir_internal(1) and     q_ir_internal(0) and Z_flag;
    m4 <=     q_ir_internal(2) and not q_ir_internal(1) and not q_ir_internal(0) and not C_flag;
    m5 <=     q_ir_internal(2) and not q_ir_internal(1) and     q_ir_internal(0) and not S_flag;
    m6 <=     q_ir_internal(2) and     q_ir_internal(1) and not q_ir_internal(0) and not V_flag;
    m7 <=     q_ir_internal(2) and     q_ir_internal(1) and     q_ir_internal(0) and not Z_flag;

    -- Compuerta OR principal del diagrama
    jump_condition <= m0 or m1 or m2 or m3 or m4 or m5 or m6 or m7;

    -- Compuerta AND del diagrama (Condición de salto combinada con un estado/habilitador)
    -- Asumimos que el salto ocurre durante e2
    selector_mux2 <= jump_condition and e2;

    -- 6. Instancia del Sumador (Suma el PC actual + Offset del IR)
    SUMADOR_PC : Sumador_16b port map (
        A    => q_pc_internal,
        B    => q_ir_internal(15 downto 0), -- Asumiendo que el offset viene en los 16 LSB del IR
        Cin  => '0',
        S    => out_sumador,
        Cout => open
    );

    -- 7. Instancia del Mux 2a1 (Conecta la Memoria o el Salto al PC)
    MUX_PC_INST : Mux_2a1_16b port map (
        I0 => D_Memoria_16,   -- Dirección secuencial
        I1 => out_sumador,    -- Dirección de salto
        S  => selector_mux2,  -- Lógica generada arriba
        Y  => out_mux2a1_pc
    );

    -- 8. Instancia del Contador de Programa (PC)
    PC_BLOCK : PC port map (
        CLK => CLK, 
        W   => pc_w_signal, 
        C   => out_mux2a1_pc, -- Ahora se alimenta del Mux, como dicta el diagrama
        Q   => q_pc_internal
    );

    -- Ruteo a los puertos de salida de la entidad
    PC_Out <= q_pc_internal;
    IR_Out <= q_ir_internal;

end Arq_Uc;