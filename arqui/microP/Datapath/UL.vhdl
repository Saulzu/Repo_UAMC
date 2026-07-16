library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity Unidad_Logica is 
    Port ( 
        A : in STD_LOGIC_VECTOR(7 downto 0); 
        B : in STD_LOGIC_VECTOR(7 downto 0); 
        S : in STD_LOGIC_VECTOR(2 downto 0); 
        R : out STD_LOGIC_VECTOR(7 downto 0); 
        S_flag : out STD_LOGIC; 
        Z : out STD_LOGIC 
    );
end Unidad_Logica;

architecture Arq_Unidad_Logica of Unidad_Logica is 
    signal R_internal : STD_LOGIC_VECTOR(7 downto 0);
begin 
    -- Lógica booleana pura evaluando el selector S(1) y S(0)
    R_internal <= 
        (A and B and (7 downto 0 => (not S(1) and not S(0)))) or
        ((A or B) and (7 downto 0 => (not S(1) and S(0)))) or
        ((A xor B) and (7 downto 0 => (S(1) and not S(0)))) or
        ((not A) and (7 downto 0 => (S(1) and S(0))));

    -- Asignación a la salida
    R <= R_internal;

    -- Banderas generadas por compuertas lógicas
    S_flag <= R_internal(7);
    
    -- La bandera Z es una compuerta NOR de todos los bits del resultado
    Z <= not (R_internal(7) or R_internal(6) or R_internal(5) or R_internal(4) or 
              R_internal(3) or R_internal(2) or R_internal(1) or R_internal(0));

end Arq_Unidad_Logica;