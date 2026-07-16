library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlopD is
    Port (
        CLK : in  STD_LOGIC;  -- Señal de reloj (flanco de subida)
        D   : in  STD_LOGIC;  -- Entrada de datos
        Q   : out STD_LOGIC   -- Salida del flip-flop (retiene el valor de D en cada flanco de reloj)
    );
end FlipFlopD;

architecture Arq_flipFlopD of flipFlopD is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;
        end if;
    end process;

end Arq_flipFlopD;