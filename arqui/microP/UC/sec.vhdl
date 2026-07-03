library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sec is
    Port (
        CLK : in  STD_LOGIC;  -- Señal de reloj
        InA : in  STD_LOGIC;  -- Entrada de control A (entrada del secuenciador)
        InB : in  STD_LOGIC;  -- Entrada de control B (entrada del secuenciador)
        e0  : out STD_LOGIC;  -- Salida del descodificador (estado 0)
        e1  : out STD_LOGIC;  -- Salida del descodificador (estado 1)
        e2  : out STD_LOGIC;  -- Salida del descodificador (estado 2)
        e3  : out STD_LOGIC   -- Salida del descodificador (estado 3)
    );
end Sec;

architecture Arq_sec of Sec is

    component FlipFlopD is
        Port (
            CLK : in  STD_LOGIC;
            D   : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    component Deco2a4 is
        Port (
            S : in  STD_LOGIC_VECTOR(1 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal q0, q1 : STD_LOGIC;                    -- Salidas de los flip-flops (estado actual del secuenciador)
    signal d0, d1 : STD_LOGIC;                    -- Entradas a los flip-flops (estado futuro)
    signal q0_n, q1_n   : STD_LOGIC;              -- Inversas de las salidas de flip-flops
    signal InA_n, InB_n : STD_LOGIC;              -- Inversas de las entradas
    signal and_top, and_mid, and_bot : STD_LOGIC;-- Salidas intermedias de compuertas AND
    signal deco_in  : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada del descodificador (concatenación de q1 y q0)
    signal deco_out : STD_LOGIC_VECTOR(3 downto 0);  -- Salida del descodificador

begin

    q0_n  <= not q0;
    q1_n  <= not q1;
    InA_n <= not InA;
    InB_n <= not InB;

    and_top <= InA_n and InB_n and q1;
    and_mid <= InA_n and InB and q1;
    
    d0      <= and_top or and_mid;
    d1      <= q1_n and InA;

    FF0 : FlipFlopD 
        port map (
            CLK => CLK, 
            D   => d0, 
            Q   => q0
        );

    FF1 : FlipFlopD 
        port map (
            CLK => CLK, 
            D   => d1, 
            Q   => q1
        );

    deco_in <= q1 & q0;

    DECO_SALIDA : Deco2a4
        port map (
            S => deco_in,
            Y => deco_out
        );

    e0 <= deco_out(0);
    e1 <= deco_out(1);
    e2 <= deco_out(2);
    e3 <= deco_out(3);

end Arq_sec;