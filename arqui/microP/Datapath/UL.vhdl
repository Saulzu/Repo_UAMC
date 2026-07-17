library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity Unidad_Logica is 
    Port ( 
        A      : in STD_LOGIC_VECTOR(7 downto 0);  -- Primer operando (8 bits)
        B      : in STD_LOGIC_VECTOR(7 downto 0);  -- Segundo operando (8 bits)
        S      : in STD_LOGIC_VECTOR(2 downto 0);  -- Selector de operación lógica (3 bits): 00->AND, 01->OR, 10->XOR, 11->NOT
        R      : out STD_LOGIC_VECTOR(7 downto 0); -- Resultado de la operación (8 bits)
        S_flag : out STD_LOGIC;                    -- Bandera de signo (bit 7 del resultado)
        Z      : out STD_LOGIC                     -- Bandera de cero (1 si resultado=0)
    );
end Unidad_Logica;

architecture Arq_Unidad_Logica of Unidad_Logica is 
    signal R_internal : STD_LOGIC_VECTOR(7 downto 0); -- Resultado interno de operaciones lógicas
begin 
    R_internal <= 
        (A and B and (7 downto 0 => (not S(1) and not S(0)))) or
        ((A or B) and (7 downto 0 => (not S(1) and S(0)))) or
        ((A xor B) and (7 downto 0 => (S(1) and not S(0)))) or
        ((not A) and (7 downto 0 => (S(1) and S(0))));

    R <= R_internal;

    S_flag <= R_internal(7);
    
    Z <= not (R_internal(7) or R_internal(6) or R_internal(5) or R_internal(4) or 
              R_internal(3) or R_internal(2) or R_internal(1) or R_internal(0));

end Arq_Unidad_Logica;