library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Logica_Saltos is
    Port (
        -- Bits de instrucción (5 bits más significativos del IR)
        S4, S3, S2, S1, S0 : in STD_LOGIC;  -- Bits de control de salto: S4,S3 determinan si es instrucción de salto; S2,S1,S0 tipo de salto
        -- Banderas desde el Datapath
        C_flag  : in STD_LOGIC;  -- Bandera de Carry (acarreo)
        S_flag  : in STD_LOGIC;  -- Bandera de Sign (signo)
        V_flag  : in STD_LOGIC;  -- Bandera de oVerflow (desbordamiento)
        Z_flag  : in STD_LOGIC;  -- Bandera de Zero (cero)
        -- Salida de control
        Jump_Taken : out STD_LOGIC  -- Señal de salto ejecutado (1=salto debe tomarse, 0=salto no se toma)
    );
end Logica_Saltos;

architecture Arq_Logica_Saltos of Logica_Saltos is
    signal J_Condicion : STD_LOGIC;        -- Señal que indica si la condición del salto es verdadera
    signal Es_Instruccion_Salto : STD_LOGIC;  -- Señal que indica si es una instrucción de salto
begin
    J_Condicion <= 
        ((not S2) and (not S1) and (not S0)) or                                    -- 000: JMP Incondicional (1)
        ((not S2) and (not S1) and      S0  and C_flag) or                         -- 001: JC
        ((not S2) and      S1  and (not S0) and (not C_flag)) or                   -- 010: JNC
        ((not S2) and      S1  and      S0  and S_flag) or                         -- 011: JS
        (     S2  and (not S1) and (not S0) and (not S_flag)) or                   -- 100: JNS
        (     S2  and (not S1) and      S0  and V_flag) or                         -- 101: JV
        (     S2  and      S1  and (not S0) and (not V_flag)) or                   -- 110: JNV
        (     S2  and      S1  and      S0  and Z_flag);                           -- 111: JZ

    Es_Instruccion_Salto <= S4 and S3;

    Jump_Taken <= J_Condicion and Es_Instruccion_Salto;

end Arq_Logica_Saltos;