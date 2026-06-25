library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comp is
end comp;

architecture Behavioral of comp is
  signal t_a : std_logic := '0';
  signal t_b : std_logic := '0';
  signal t_y : std_logic;
begin
  uut : entity work.mi_componente
    port map
    (
      a => t_a,
      b => t_b,
      y => t_y
    );

  stim_proc : process
  begin
    t_a <= '0';
    t_b <= '0';
    wait for 10 ns;
    t_a <= '0';
    t_b <= '1';
    wait for 10 ns;
    t_a <= '1';
    t_b <= '0';
    wait for 10 ns;
    t_a <= '1';
    t_b <= '1';
    wait for 10 ns;

    wait;
  end process;
end Behavioral;
