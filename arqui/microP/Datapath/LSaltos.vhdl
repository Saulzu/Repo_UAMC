library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Logica_Saltos is
    Port (
        -- Bits de instrucción
        S4, S3, S2, S1, S0 : in STD_LOGIC;
        -- Banderas desde el Datapath
        C_flag, S_flag, V_flag, Z_flag : in STD_LOGIC;
        -- Salida de control
        Jump_Taken : out STD_LOGIC
    );
end Logica_Saltos;

architecture Arq_Logica_Saltos of Logica_Saltos is
    signal J_Condicion : STD_LOGIC;
    signal Es_Instruccion_Salto : STD_LOGIC;
begin
    -- Decodificación booleana de la condición basada en S(2:0)
    -- Asignación típica para las banderas:
    -- 000 = Incondicional (1)
    -- 001 = C, 010 = not C
    -- 011 = S, 100 = not S
    -- 101 = V, 110 = not V
    -- 111 = Z
    J_Condicion <= 
        ((not S2) and (not S1) and (not S0)) or                                    -- 000: JMP Incondicional (1)
        ((not S2) and (not S1) and      S0  and C_flag) or                         -- 001: JC
        ((not S2) and      S1  and (not S0) and (not C_flag)) or                   -- 010: JNC
        ((not S2) and      S1  and      S0  and S_flag) or                         -- 011: JS
        (     S2  and (not S1) and (not S0) and (not S_flag)) or                   -- 100: JNS
        (     S2  and (not S1) and      S0  and V_flag) or                         -- 101: JV
        (     S2  and      S1  and (not S0) and (not V_flag)) or                   -- 110: JNV
        (     S2  and      S1  and      S0  and Z_flag);                           -- 111: JZ

    -- Un salto solo es válido si S4 = 1 y S3 = 1 (11xxx)
    Es_Instruccion_Salto <= S4 and S3;

    -- Compuerta AND final para activar la carga en el PC
    Jump_Taken <= J_Condicion and Es_Instruccion_Salto;

end Arq_Logica_Saltos;