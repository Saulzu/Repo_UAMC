library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shifterr is
    Port (
        Q  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Entrada de datos (8 bits)
        S  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Selector de desplazamiento (2 bits)
        D  : out STD_LOGIC_VECTOR(7 downto 0);  -- Salida desplazada (8 bits)
        CI : out STD_LOGIC;                     -- Acarreo/Desplazado de entrada (izquierda)
        CD : out STD_LOGIC                      -- Acarreo/Desplazado de salida (derecha)
    );
end Shifterr;

architecture Arq_Shifterr of Shifterr is
    component Mux_2a1 is
        Port (
            I0 : in  STD_LOGIC;
            I1 : in  STD_LOGIC;
            S  : in  STD_LOGIC;
            Y  : out STD_LOGIC
        );
    end component;

    signal out_mux_izq : STD_LOGIC;  -- Salida del multiplexor izquierdo (bit que sale por izquierda)
    signal out_mux_der : STD_LOGIC;  -- Salida del multiplexor derecho (bit que sale por derecha)
begin
    CI <= out_mux_izq;
    CD <= out_mux_der;

    Mux_Aux_Izq : Mux_2a1 port map (I0 => Q(0), I1 => '0', S => S(1), Y => out_mux_izq);

    Mux_D7 : Mux_2a1 port map (I0 => out_mux_izq, I1 => Q(6), S => S(0), Y => D(7));
    Mux_D6 : Mux_2a1 port map (I0 => Q(7),        I1 => Q(5), S => S(0), Y => D(6));
    Mux_D5 : Mux_2a1 port map (I0 => Q(6),        I1 => Q(4), S => S(0), Y => D(5));
    Mux_D4 : Mux_2a1 port map (I0 => Q(5),        I1 => Q(3), S => S(0), Y => D(4));
    Mux_D3 : Mux_2a1 port map (I0 => Q(4),        I1 => Q(2), S => S(0), Y => D(3));
    Mux_D2 : Mux_2a1 port map (I0 => Q(3),        I1 => Q(1), S => S(0), Y => D(2));
    Mux_D1 : Mux_2a1 port map (I0 => Q(2),        I1 => Q(0), S => S(0), Y => D(1));
    Mux_D0 : Mux_2a1 port map (I0 => Q(1),        I1 => out_mux_der, S => S(0), Y => D(0));

    Mux_Aux_Der : Mux_2a1 port map (I0 => '0', I1 => Q(7), S => S(1), Y => out_mux_der);
end Arq_Shifterr;