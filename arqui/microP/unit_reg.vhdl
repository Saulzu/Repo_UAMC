library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unit_Reg is
    Port (
        CLK      : in  STD_LOGIC;
        C        : in  STD_LOGIC_VECTOR(7 downto 0);
        DC       : in  STD_LOGIC_VECTOR(2 downto 0);
        DA       : in  STD_LOGIC_VECTOR(2 downto 0);
        DB       : in  STD_LOGIC_VECTOR(2 downto 0);
        L_OR     : in  STD_LOGIC;
        A        : out STD_LOGIC_VECTOR(7 downto 0);
        B        : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Unit_Reg;

architecture Arq_Unit_Reg of Unit_Reg is
    component Deco3a8 is
        Port ( S: in STD_LOGIC_VECTOR(2 downto 0); Y : out STD_LOGIC_VECTOR(7 downto 0) );
    end component;
    
    component Reg8b is
        Port ( CLK : in STD_LOGIC; W : in STD_LOGIC; D : in STD_LOGIC_VECTOR(7 downto 0); Q : out STD_LOGIC_VECTOR(7 downto 0) );
    end component;

    component Mux8a1 is
        Port ( I0, I1, I2, I3, I4, I5, I6, I7 : in STD_LOGIC_VECTOR(7 downto 0); S : in STD_LOGIC_VECTOR(2 downto 0); Y : out STD_LOGIC_VECTOR(7 downto 0) );
    end component;

    signal deco_out : STD_LOGIC_VECTOR(7 downto 0);
    signal w        : STD_LOGIC_VECTOR(7 downto 0);

    signal r0, r1, r2, r3, r4, r5, r6, r7 : STD_LOGIC_VECTOR(7 downto 0);
begin
    DECO_INST : Deco3a8 port map (S => DC, Y => deco_out);

    w <= deco_out or (7 downto 0 => L_OR);

    REG_R0 : Reg8b port map (CLK => CLK, W => w(0), D => C, Q => r0);
    REG_R1 : Reg8b port map (CLK => CLK, W => w(1), D => C, Q => r1);
    REG_R2 : Reg8b port map (CLK => CLK, W => w(2), D => C, Q => r2);
    REG_R3 : Reg8b port map (CLK => CLK, W => w(3), D => C, Q => r3);
    REG_R4 : Reg8b port map (CLK => CLK, W => w(4), D => C, Q => r4);
    REG_R5 : Reg8b port map (CLK => CLK, W => w(5), D => C, Q => r5);
    REG_R6 : Reg8b port map (CLK => CLK, W => w(6), D => C, Q => r6);
    REG_R7 : Reg8b port map (CLK => CLK, W => w(7), D => C, Q => r7);

    MUX_A_INST : Mux8a1 port map (
        I0 => r0, I1 => r1, I2 => r2, I3 => r3,
        I4 => r4, I5 => r5, I6 => r6, I7 => r7,
        S => DA, Y => A
    );

    MUX_B_INST : Mux8a1 port map (
        I0 => r0, I1 => r1, I2 => r2, I3 => r3,
        I4 => r4, I5 => r5, I6 => r6, I7 => r7,
        S => DB, Y => B
    );

end Arq_Unit_Reg;