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
            I : in  STD_LOGIC_VECTOR(1 downto 0); -- Entradas I(0)=I0, I(1)=I1
            S : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal out_mux_izq : STD_LOGIC;  -- Salida del multiplexor izquierdo (bit que sale por izquierda)
    signal out_mux_der : STD_LOGIC;  -- Salida del multiplexor derecho (bit que sale por derecha)
    signal sel_mux_izq  : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d7   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d6   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d5   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d4   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d3   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d2   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d1   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_d0   : STD_LOGIC_VECTOR(1 downto 0);
    signal sel_mux_der  : STD_LOGIC_VECTOR(1 downto 0);
begin
    CI <= out_mux_izq;
    CD <= out_mux_der;

    sel_mux_izq <= '0' & Q(0);
    sel_mux_d7  <= Q(6) & out_mux_izq;
    sel_mux_d6  <= Q(5) & Q(7);
    sel_mux_d5  <= Q(4) & Q(6);
    sel_mux_d4  <= Q(3) & Q(5);
    sel_mux_d3  <= Q(2) & Q(4);
    sel_mux_d2  <= Q(1) & Q(3);
    sel_mux_d1  <= Q(0) & Q(2);
    sel_mux_d0  <= out_mux_der & Q(1);
    sel_mux_der <= Q(7) & '0';

    Mux_Aux_Izq : Mux_2a1 port map (I => sel_mux_izq, S => S(1), Y => out_mux_izq);

    Mux_D7 : Mux_2a1 port map (I => sel_mux_d7, S => S(0), Y => D(7));
    Mux_D6 : Mux_2a1 port map (I => sel_mux_d6, S => S(0), Y => D(6));
    Mux_D5 : Mux_2a1 port map (I => sel_mux_d5, S => S(0), Y => D(5));
    Mux_D4 : Mux_2a1 port map (I => sel_mux_d4, S => S(0), Y => D(4));
    Mux_D3 : Mux_2a1 port map (I => sel_mux_d3, S => S(0), Y => D(3));
    Mux_D2 : Mux_2a1 port map (I => sel_mux_d2, S => S(0), Y => D(2));
    Mux_D1 : Mux_2a1 port map (I => sel_mux_d1, S => S(0), Y => D(1));
    Mux_D0 : Mux_2a1 port map (I => sel_mux_d0, S => S(0), Y => D(0));

    Mux_Aux_Der : Mux_2a1 port map (I => sel_mux_der, S => S(1), Y => out_mux_der);
end Arq_Shifterr;