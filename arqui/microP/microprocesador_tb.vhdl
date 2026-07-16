library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microprocesador_tb is
end entity microprocesador_tb;

architecture Behavioral of microprocesador_tb is
    signal CLK : STD_LOGIC := '0';
    signal RST : STD_LOGIC := '1';
begin

    DUT : entity work.Microprocesador
        port map (
            CLK => CLK,
            RST => RST
        );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for 10 ns;
            CLK <= '1';
            wait for 10 ns;
        end loop;
    end process clk_process;

    reset_process : process
    begin
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 200 ns;
        wait;
    end process reset_process;

end architecture Behavioral;
