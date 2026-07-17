library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2a1_16b is
    Port (
        I0 : in  STD_LOGIC_VECTOR(15 downto 0); -- Entrada 0
        I1 : in  STD_LOGIC_VECTOR(15 downto 0); -- Entrada 1 (Salto)
        S  : in  STD_LOGIC;                     -- Selector de 1 bit
        Y  : out STD_LOGIC_VECTOR(15 downto 0)  -- Salida de 16 bits
    );
end Mux_2a1_16b;

architecture Arq_Mux_2a1_16b of Mux_2a1_16b is
    signal S_vector     : STD_LOGIC_VECTOR(15 downto 0);  -- Replicación del selector en 16 bits
    signal not_S_vector : STD_LOGIC_VECTOR(15 downto 0);  -- Inverso del selector replicado en 16 bits
begin
    S_vector     <= (others => S);
    not_S_vector <= (others => not S);

    Y <= (I0 and not_S_vector) or (I1 and S_vector);

end Arq_Mux_2a1_16b;