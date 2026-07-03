library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg8b is
    Port (
        CLK : in  STD_LOGIC;                      -- Señal de reloj (flanco de subida)
        W : in  STD_LOGIC;                        -- Habilitación de escritura
        D : in  STD_LOGIC_VECTOR(7 downto 0);    -- Datos de entrada (8 bits)
        Q : out STD_LOGIC_VECTOR(7 downto 0)     -- Datos de salida (8 bits)
    );
end Reg8b;

architecture Arq_Reg8b of Reg8b is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if W = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Arq_Reg8b;
