library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mi_componente is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           y : out STD_LOGIC);
end mi_componente;

architecture Behavioral of mi_componente is
begin
    y <= a and b;
end Behavioral;
