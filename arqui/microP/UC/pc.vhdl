library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port (
        CLK : in  STD_LOGIC;                       -- Señal de reloj
        W   : in  STD_LOGIC;                       -- Control de carga: '0'=incrementar, '1'=cargar desde C
        C   : in  STD_LOGIC_VECTOR(15 downto 0);  -- Entrada de carga paralela (dirección de salto)
        Q   : out STD_LOGIC_VECTOR(15 downto 0)   -- Salida del contador de programa actual
    );
end PC;

architecture Arq_PC of PC is

    
    component Mux_2a1 is
        Port (
            I : in  STD_LOGIC_VECTOR(1 downto 0); -- Entradas I(0)=I0, I(1)=I1
            S : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component FlipFlopD is
        Port (
            CLK : in  STD_LOGIC;
            D   : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    
    signal q_reg : STD_LOGIC_VECTOR(15 downto 0);  -- Dirección actual del programa (salida de los flip-flops del PC)
    signal d_reg : STD_LOGIC_VECTOR(15 downto 0);  -- Entrada a los flip-flops (selección entre incremento o carga paralela)
    signal inc   : STD_LOGIC_VECTOR(15 downto 0);  -- Valor incrementado (PC + 1)
    signal carry : STD_LOGIC_VECTOR(15 downto 0);  -- Cadena de acarreos del incrementador de 16 bits
    signal sel_mux_pc0  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 0 del PC
    signal sel_mux_pc1  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 1 del PC
    signal sel_mux_pc2  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 2 del PC
    signal sel_mux_pc3  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 3 del PC
    signal sel_mux_pc4  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 4 del PC
    signal sel_mux_pc5  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 5 del PC
    signal sel_mux_pc6  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 6 del PC
    signal sel_mux_pc7  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 7 del PC
    signal sel_mux_pc8  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 8 del PC
    signal sel_mux_pc9  : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 9 del PC
    signal sel_mux_pc10 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 10 del PC
    signal sel_mux_pc11 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 11 del PC
    signal sel_mux_pc12 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 12 del PC
    signal sel_mux_pc13 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 13 del PC
    signal sel_mux_pc14 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 14 del PC
    signal sel_mux_pc15 : STD_LOGIC_VECTOR(1 downto 0);  -- Entradas para multiplexor del bit 15 del PC

begin

    Q <= q_reg;

    inc(0)   <= q_reg(0) xor '1';
    carry(0) <= q_reg(0);

    inc(1)   <= q_reg(1) xor carry(0);
    carry(1) <= carry(0) and q_reg(1);

    inc(2)   <= q_reg(2) xor carry(1);
    carry(2) <= carry(1) and q_reg(2);

    inc(3)   <= q_reg(3) xor carry(2);
    carry(3) <= carry(2) and q_reg(3);

    inc(4)   <= q_reg(4) xor carry(3);
    carry(4) <= carry(3) and q_reg(4);

    inc(5)   <= q_reg(5) xor carry(4);
    carry(5) <= carry(4) and q_reg(5);

    inc(6)   <= q_reg(6) xor carry(5);
    carry(6) <= carry(5) and q_reg(6);

    inc(7)   <= q_reg(7) xor carry(6);
    carry(7) <= carry(6) and q_reg(7);

    inc(8)   <= q_reg(8) xor carry(7);
    carry(8) <= carry(7) and q_reg(8);

    inc(9)   <= q_reg(9) xor carry(8);
    carry(9) <= carry(8) and q_reg(9);

    inc(10)  <= q_reg(10) xor carry(9);
    carry(10)<= carry(9) and q_reg(10);

    inc(11)  <= q_reg(11) xor carry(10);
    carry(11)<= carry(10) and q_reg(11);

    inc(12)  <= q_reg(12) xor carry(11);
    carry(12)<= carry(11) and q_reg(12);

    inc(13)  <= q_reg(13) xor carry(12);
    carry(13)<= carry(12) and q_reg(13);

    inc(14)  <= q_reg(14) xor carry(13);
    carry(14)<= carry(13) and q_reg(14);

    inc(15)  <= q_reg(15) xor carry(14);
    
    sel_mux_pc0  <= C(0) & inc(0);
    sel_mux_pc1  <= C(1) & inc(1);
    sel_mux_pc2  <= C(2) & inc(2);
    sel_mux_pc3  <= C(3) & inc(3);
    sel_mux_pc4  <= C(4) & inc(4);
    sel_mux_pc5  <= C(5) & inc(5);
    sel_mux_pc6  <= C(6) & inc(6);
    sel_mux_pc7  <= C(7) & inc(7);
    sel_mux_pc8  <= C(8) & inc(8);
    sel_mux_pc9  <= C(9) & inc(9);
    sel_mux_pc10 <= C(10) & inc(10);
    sel_mux_pc11 <= C(11) & inc(11);
    sel_mux_pc12 <= C(12) & inc(12);
    sel_mux_pc13 <= C(13) & inc(13);
    sel_mux_pc14 <= C(14) & inc(14);
    sel_mux_pc15 <= C(15) & inc(15);

    MUX0 : Mux_2a1 port map (I => sel_mux_pc0,  S => W, Y => d_reg(0));
    FF0  : FlipFlopD port map (CLK => CLK, D => d_reg(0),  Q => q_reg(0));

    MUX1 : Mux_2a1 port map (I => sel_mux_pc1,  S => W, Y => d_reg(1));
    FF1  : FlipFlopD port map (CLK => CLK, D => d_reg(1),  Q => q_reg(1));

    MUX2 : Mux_2a1 port map (I => sel_mux_pc2,  S => W, Y => d_reg(2));
    FF2  : FlipFlopD port map (CLK => CLK, D => d_reg(2),  Q => q_reg(2));

    MUX3 : Mux_2a1 port map (I => sel_mux_pc3,  S => W, Y => d_reg(3));
    FF3  : FlipFlopD port map (CLK => CLK, D => d_reg(3),  Q => q_reg(3));

    MUX4 : Mux_2a1 port map (I => sel_mux_pc4,  S => W, Y => d_reg(4));
    FF4  : FlipFlopD port map (CLK => CLK, D => d_reg(4),  Q => q_reg(4));

    MUX5 : Mux_2a1 port map (I => sel_mux_pc5,  S => W, Y => d_reg(5));
    FF5  : FlipFlopD port map (CLK => CLK, D => d_reg(5),  Q => q_reg(5));

    MUX6 : Mux_2a1 port map (I => sel_mux_pc6,  S => W, Y => d_reg(6));
    FF6  : FlipFlopD port map (CLK => CLK, D => d_reg(6),  Q => q_reg(6));

    MUX7 : Mux_2a1 port map (I => sel_mux_pc7,  S => W, Y => d_reg(7));
    FF7  : FlipFlopD port map (CLK => CLK, D => d_reg(7),  Q => q_reg(7));

    MUX8 : Mux_2a1 port map (I => sel_mux_pc8,  S => W, Y => d_reg(8));
    FF8  : FlipFlopD port map (CLK => CLK, D => d_reg(8),  Q => q_reg(8));

    MUX9 : Mux_2a1 port map (I => sel_mux_pc9,  S => W, Y => d_reg(9));
    FF9  : FlipFlopD port map (CLK => CLK, D => d_reg(9),  Q => q_reg(9));

    MUX10: Mux_2a1 port map (I => sel_mux_pc10, S => W, Y => d_reg(10));
    FF10 : FlipFlopD port map (CLK => CLK, D => d_reg(10), Q => q_reg(10));

    MUX11: Mux_2a1 port map (I => sel_mux_pc11, S => W, Y => d_reg(11));
    FF11 : FlipFlopD port map (CLK => CLK, D => d_reg(11), Q => q_reg(11));

    MUX12: Mux_2a1 port map (I => sel_mux_pc12, S => W, Y => d_reg(12));
    FF12 : FlipFlopD port map (CLK => CLK, D => d_reg(12), Q => q_reg(12));

    MUX13: Mux_2a1 port map (I => sel_mux_pc13, S => W, Y => d_reg(13));
    FF13 : FlipFlopD port map (CLK => CLK, D => d_reg(13), Q => q_reg(13));

    MUX14: Mux_2a1 port map (I => sel_mux_pc14, S => W, Y => d_reg(14));
    FF14 : FlipFlopD port map (CLK => CLK, D => d_reg(14), Q => q_reg(14));

    MUX15: Mux_2a1 port map (I => sel_mux_pc15, S => W, Y => d_reg(15));
    FF15 : FlipFlopD port map (CLK => CLK, D => d_reg(15), Q => q_reg(15));

end Arq_PC;