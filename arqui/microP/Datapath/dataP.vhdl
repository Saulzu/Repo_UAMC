library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
    Port (
        CLK            : in  STD_LOGIC;                       -- Señal de reloj
        W_UR           : in  STD_LOGIC;                       -- Habilitación de escritura en la unidad de registros
        DC             : in  STD_LOGIC_VECTOR(2 downto 0);    -- Dirección del registro de destino (escritura)
        DA             : in  STD_LOGIC_VECTOR(2 downto 0);    -- Dirección de lectura del puerto A
        DB             : in  STD_LOGIC_VECTOR(2 downto 0);    -- Dirección de lectura del puerto B
        L_OR           : in  STD_LOGIC;                       -- Señal de habilitación combinada (OR con W_UR) para escritura de registros
        S              : in  STD_LOGIC_VECTOR(4 downto 0);    -- Selector de operación de la unidad funcional (ALU/Shifter)
        Ci             : in  STD_LOGIC;                       -- Acarreo de entrada
        m1             : in  STD_LOGIC;                       -- Multiplexor 1: selecciona entrada A de unidad funcional (0=UR, 1=Memoria)
        m2             : in  STD_LOGIC;                       -- Multiplexor 2: selecciona entrada de registros (0=UF, 1=Memoria)
        Datos_Memoria  : in  STD_LOGIC_VECTOR(7 downto 0);    -- Bus de datos de entrada desde memoria
        Dir_Memoria    : out STD_LOGIC_VECTOR(7 downto 0);    -- Bus de dirección hacia memoria
        Datos_Escribir : out STD_LOGIC_VECTOR(7 downto 0);    -- Bus de datos a escribir en memoria
        C, S_flag, V, Z : out STD_LOGIC                       -- Banderas: Carry, Sign, oVerflow, Zero
    );
end Datapath;

architecture Arq_Datapath of Datapath is

    component Unit_Reg is
        Port (
            CLK  : in  STD_LOGIC;                       -- Señal de reloj
            C    : in  STD_LOGIC_VECTOR(7 downto 0);   -- Datos a escribir en el registro
            DC   : in  STD_LOGIC_VECTOR(2 downto 0);   -- Dirección del registro de destino
            DA   : in  STD_LOGIC_VECTOR(2 downto 0);   -- Dirección de lectura puerto A
            DB   : in  STD_LOGIC_VECTOR(2 downto 0);   -- Dirección de lectura puerto B
            L_OR : in  STD_LOGIC;                       -- Habilitación OR para escritura de registros
            A    : out STD_LOGIC_VECTOR(7 downto 0);   -- Datos de salida puerto A
            B    : out STD_LOGIC_VECTOR(7 downto 0)    -- Datos de salida puerto B
        );
    end component;

    component Unidad_Funcional is
        Port (
            A      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando A
            B      : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operando B
            S      : in  STD_LOGIC_VECTOR(4 downto 0);  -- Selector de operación
            Ci     : in  STD_LOGIC;                     -- Acarreo de entrada
            R      : out STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la operación
            C      : out STD_LOGIC;                     -- Bandera de Carry
            V      : out STD_LOGIC;                     -- Bandera de oVerflow
            S_flag : out STD_LOGIC;                     -- Bandera de Sign (signo)
            Z      : out STD_LOGIC                      -- Bandera de Zero (cero)
        );
    end component;

    signal ur_out_a     : STD_LOGIC_VECTOR(7 downto 0);  -- Salida A de la unidad de registros (datos de registro lectura A)
    signal ur_out_b     : STD_LOGIC_VECTOR(7 downto 0);  -- Salida B de la unidad de registros (datos de registro lectura B)
    signal ur_in_c      : STD_LOGIC_VECTOR(7 downto 0);  -- Entrada de carga de la unidad de registros (datos a escribir)
    signal uf_in_a      : STD_LOGIC_VECTOR(7 downto 0);  -- Entrada A de la unidad funcional (seleccionada por m1: UR o Memoria)
    signal uf_out_r     : STD_LOGIC_VECTOR(7 downto 0);  -- Resultado de la unidad funcional (ALU/Shifter)
    signal m1_n, m2_n   : STD_LOGIC;                     -- Inversas de los selectores de multiplexor

begin

    m1_n <= not m1;
    m2_n <= not m2;

    UR_BLOCK : Unit_Reg
        port map (
            CLK  => CLK,
            C    => ur_in_c,
            DC   => DC,
            DA   => DA,
            DB   => DB,
            L_OR => L_OR,
            A    => ur_out_a,
            B    => ur_out_b
        );

    uf_in_a <= (ur_out_a and (7 downto 0 => m1_n)) or 
               (Datos_Memoria and (7 downto 0 => m1));

    Dir_Memoria    <= uf_in_a;
    Datos_Escribir <= ur_out_b;

    UF_BLOCK : Unidad_Funcional
        port map (
            A      => uf_in_a,
            B      => ur_out_b,
            S      => S,
            Ci     => Ci,
            R      => uf_out_r,
            C      => C,
            V      => V,
            S_flag => S_flag,
            Z      => Z
        );

    ur_in_c <= (uf_out_r and (7 downto 0 => m2_n)) or 
               (Datos_Memoria and (7 downto 0 => m2));

end Arq_Datapath;