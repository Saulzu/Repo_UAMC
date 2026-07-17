library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shifterr is
    Port (
        Q  : in  STD_LOGIC_VECTOR(7 downto 0);  -- Entrada de datos a desplazar (8 bits)
        S  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Selector: 00->sin desplazamiento, 01->derecha, 10->izquierda, 11->sin desplazamiento
        D  : out STD_LOGIC_VECTOR(7 downto 0);  -- Salida desplazada (8 bits)
        CI : out STD_LOGIC;                     -- Carry de entrada/bit desplazado hacia la izquierda
        CD : out STD_LOGIC                      -- Carry de salida/bit desplazado hacia la derecha
    );
end Shifterr;

architecture Arq_Shifterr of Shifterr is
    component Mux_2a1 is
        Port (
            I : in  STD_LOGIC_VECTOR(1 downto 0); -- Dos entradas (bit a seleccionar)
            S : in  STD_LOGIC;                    -- Señal de selección
            Y : out STD_LOGIC                     -- Salida seleccionada
        );
    end component;

    signal out_mux_izq : STD_LOGIC;  -- Bit que sale del multiplexor izquierdo (desplazamiento a derecha)
    signal out_mux_der : STD_LOGIC;  -- Bit que sale del multiplexor derecho (desplazamiento a izquierda)
    signal sel_mux_izq  : STD_LOGIC_VECTOR(1 downto 0);  -- Selección para multiplexor izquierdo
    signal sel_mux_d7   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(7)
    signal sel_mux_d6   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(6)
    signal sel_mux_d5   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(5)
    signal sel_mux_d4   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(4)
    signal sel_mux_d3   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(3)
    signal sel_mux_d2   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(2)
    signal sel_mux_d1   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(1)
    signal sel_mux_d0   : STD_LOGIC_VECTOR(1 downto 0);  -- Entrada para bit de salida D(0)
    signal sel_mux_der  : STD_LOGIC_VECTOR(1 downto 0);  -- Selección para multiplexor derecho
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