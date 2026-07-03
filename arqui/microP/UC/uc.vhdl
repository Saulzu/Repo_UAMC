library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port (
        CLK           : in  STD_LOGIC;                       -- Señal de reloj del sistema
        InA           : in  STD_LOGIC;                       -- Entrada de control A del secuenciador
        InB           : in  STD_LOGIC;                       -- Entrada de control B del secuenciador
        w_prime       : in  STD_LOGIC;                       -- Señal de habilitación para escritura en IR
        mw_param      : in  STD_LOGIC;                       -- Parámetro de control de escritura en memoria
        D_Memoria_16  : in  STD_LOGIC_VECTOR(15 downto 0);  -- Datos desde memoria para cargar en PC
        D_Memoria_26  : in  STD_LOGIC_VECTOR(25 downto 0);  -- Datos desde memoria para cargar en IR
        PC_Out        : out STD_LOGIC_VECTOR(15 downto 0);  -- Salida del contador de programa
        IR_Out        : out STD_LOGIC_VECTOR(25 downto 0);  -- Salida del registro de instrucción
        MW_Output     : out STD_LOGIC                       -- Señal de habilitación de escritura en memoria
    );
end UC;

architecture Arq_Uc of UC is

    component Sec is
        Port (
            CLK : in  STD_LOGIC;
            InA : in  STD_LOGIC;
            InB : in  STD_LOGIC;
            e0  : out STD_LOGIC;
            e1  : out STD_LOGIC;
            e2  : out STD_LOGIC;
            e3  : out STD_LOGIC
        );
    end component;

    component PC is
        Port (
            CLK : in  STD_LOGIC;
            W   : in  STD_LOGIC;
            C   : in  STD_LOGIC_VECTOR(15 downto 0);
            Q   : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component Ir is
        Port (
            CLK : in  STD_LOGIC;
            W   : in  STD_LOGIC;
            D   : in  STD_LOGIC_VECTOR(25 downto 0);
            Q   : out STD_LOGIC_VECTOR(25 downto 0)
        );
    end component;

    signal e0, e1, e2, e3 : STD_LOGIC;  -- Estados del secuenciador (salidas del descodificador)
    signal w_ir : STD_LOGIC;            -- Señal de habilitación de escritura en IR (AND de e1 y w_prime)

begin

    SECUENCIADOR_INST : Sec
        port map (
            CLK => CLK,
            InA => InA,
            InB => InB,
            e0  => e0,
            e1  => e1,
            e2  => e2,
            e3  => e3
        );

    PC_BLOCK : PC
        port map (
            CLK => CLK,
            W   => e0,
            C   => D_Memoria_16,
            Q   => PC_Out
        );

    w_ir <= e1 and w_prime;

    MW_Output <= e1 and mw_param;

    IR_BLOCK : Ir
        port map (
            CLK => CLK,
            W   => w_ir,
            D   => D_Memoria_26,
            Q   => IR_Out
        );

end Arq_Uc;