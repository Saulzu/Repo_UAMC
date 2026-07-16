library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity sumador_completo is 
    Port ( 
        A : in STD_LOGIC; 
        B : in STD_LOGIC; 
        Cin : in STD_LOGIC; 
        S : out STD_LOGIC; 
        Cout : out STD_LOGIC 
    );
end sumador_completo; 

architecture Arq_sumador_completo of sumador_completo is 
begin 
    -- Ecuación booleana para la suma
    S <= (A xor B) xor Cin;
    
    -- Ecuación booleana para el acarreo de salida
    Cout <= (A and B) or (Cin and (A xor B));
end Arq_sumador_completo;