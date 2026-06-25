library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
    Port (
        CLK            : in  STD_LOGIC;
        W_UR           : in  STD_LOGIC;
        DC             : in  STD_LOGIC_VECTOR(2 downto 0);
        DA             : in  STD_LOGIC_VECTOR(2 downto 0);
        DB             : in  STD_LOGIC_VECTOR(2 downto 0);
        L_OR           : in  STD_LOGIC;
        S              : in  STD_LOGIC_VECTOR(4 downto 0);
        Ci             : in  STD_LOGIC;
        m1             : in  STD_LOGIC;
        m2             : in  STD_LOGIC;
        Datos_Memoria  : in  STD_LOGIC_VECTOR(7 downto 0);
        Dir_Memoria    : out STD_LOGIC_VECTOR(7 downto 0);
        Datos_Escribir : out STD_LOGIC_VECTOR(7 downto 0);
        C, S_flag, V, Z : out STD_LOGIC
    );
end Datapath;

architecture Arq_Datapath of Datapath is

    component Unit_Reg is
        Port (
            CLK  : in  STD_LOGIC;
            C    : in  STD_LOGIC_VECTOR(7 downto 0);
            DC   : in  STD_LOGIC_VECTOR(2 downto 0);
            DA   : in  STD_LOGIC_VECTOR(2 downto 0);
            DB   : in  STD_LOGIC_VECTOR(2 downto 0);
            L_OR : in  STD_LOGIC;
            A    : out STD_LOGIC_VECTOR(7 downto 0);
            B    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component Unidad_Funcional is
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
    end component;

    signal ur_out_a     : STD_LOGIC_VECTOR(7 downto 0);
    signal ur_out_b     : STD_LOGIC_VECTOR(7 downto 0);
    signal ur_in_c      : STD_LOGIC_VECTOR(7 downto 0);
    
    signal uf_in_a      : STD_LOGIC_VECTOR(7 downto 0);
    signal uf_out_r     : STD_LOGIC_VECTOR(7 downto 0);

    signal m1_n, m2_n   : STD_LOGIC;

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