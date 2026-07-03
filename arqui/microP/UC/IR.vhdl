library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ir is
    Port (
        CLK : in  STD_LOGIC;                       -- Señal de reloj (flanco de subida)
        W   : in  STD_LOGIC;                       -- Habilitación de escritura (carga nueva instrucción si W='1')
        D   : in  STD_LOGIC_VECTOR(25 downto 0);  -- Bus de entrada (datos de memoria)
        Q   : out STD_LOGIC_VECTOR(25 downto 0)   -- Bus de salida (instrucción almacenada)
    );
end Ir;

architecture Arq_Ir of Ir is
    
    
    component FlipFlopD is
        Port (
            CLK : in  STD_LOGIC;
            D   : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal q_reg : STD_LOGIC_VECTOR(25 downto 0);  -- Estado actual del registro (salida de los flip-flops)
    signal d_reg : STD_LOGIC_VECTOR(25 downto 0);  -- Entrada a los flip-flops (resultado del multiplexor)
    signal W_n   : STD_LOGIC;                       -- Inversa de W para la realimentación

begin

    W_n <= not W;
    Q   <= q_reg;

    d_reg <= (D and (25 downto 0 => W)) or (q_reg and (25 downto 0 => W_n));

    FF_IR0  : FlipFlopD port map (CLK => CLK, D => d_reg(0),  Q => q_reg(0));
    FF_IR1  : FlipFlopD port map (CLK => CLK, D => d_reg(1),  Q => q_reg(1));
    FF_IR2  : FlipFlopD port map (CLK => CLK, D => d_reg(2),  Q => q_reg(2));
    FF_IR3  : FlipFlopD port map (CLK => CLK, D => d_reg(3),  Q => q_reg(3));
    FF_IR4  : FlipFlopD port map (CLK => CLK, D => d_reg(4),  Q => q_reg(4));
    FF_IR5  : FlipFlopD port map (CLK => CLK, D => d_reg(5),  Q => q_reg(5));
    FF_IR6  : FlipFlopD port map (CLK => CLK, D => d_reg(6),  Q => q_reg(6));
    FF_IR7  : FlipFlopD port map (CLK => CLK, D => d_reg(7),  Q => q_reg(7));
    FF_IR8  : FlipFlopD port map (CLK => CLK, D => d_reg(8),  Q => q_reg(8));
    FF_IR9  : FlipFlopD port map (CLK => CLK, D => d_reg(9),  Q => q_reg(9));
    FF_IR10 : FlipFlopD port map (CLK => CLK, D => d_reg(10), Q => q_reg(10));
    FF_IR11 : FlipFlopD port map (CLK => CLK, D => d_reg(11), Q => q_reg(11));
    FF_IR12 : FlipFlopD port map (CLK => CLK, D => d_reg(12), Q => q_reg(12));
    FF_IR13 : FlipFlopD port map (CLK => CLK, D => d_reg(13), Q => q_reg(13));
    FF_IR14 : FlipFlopD port map (CLK => CLK, D => d_reg(14), Q => q_reg(14));
    FF_IR15 : FlipFlopD port map (CLK => CLK, D => d_reg(15), Q => q_reg(15));
    FF_IR16 : FlipFlopD port map (CLK => CLK, D => d_reg(16), Q => q_reg(16));
    FF_IR17 : FlipFlopD port map (CLK => CLK, D => d_reg(17), Q => q_reg(17));
    FF_IR18 : FlipFlopD port map (CLK => CLK, D => d_reg(18), Q => q_reg(18));
    FF_IR19 : FlipFlopD port map (CLK => CLK, D => d_reg(19), Q => q_reg(19));
    FF_IR20 : FlipFlopD port map (CLK => CLK, D => d_reg(20), Q => q_reg(20));
    FF_IR21 : FlipFlopD port map (CLK => CLK, D => d_reg(21), Q => q_reg(21));
    FF_IR22 : FlipFlopD port map (CLK => CLK, D => d_reg(22), Q => q_reg(22));
    FF_IR23 : FlipFlopD port map (CLK => CLK, D => d_reg(23), Q => q_reg(23));
    FF_IR24 : FlipFlopD port map (CLK => CLK, D => d_reg(24), Q => q_reg(24));
    FF_IR25 : FlipFlopD port map (CLK => CLK, D => d_reg(25), Q => q_reg(25));

end Arq_Ir;