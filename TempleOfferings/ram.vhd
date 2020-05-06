library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, rst, wrR, wrL, x3 : in std_logic;
i, n : in std_logic_vector(3 downto 0);
cL, cR : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component plus1_8 is
    port (a : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;

type temple is record
R, L : std_logic_vector(7 downto 0);
end record;
type ram_type is array (0 to 15) of temple;
signal chainSize : ram_type := (others =>(others =>(others=>'1')));
signal CS1, CSi, CS2, CSiR, x, y : std_logic_vector(7 downto 0);
begin
x <= chainSize(conv_integer(unsigned(i) - 1)).L;
y <= chainSize(conv_integer(unsigned(i) + 1)).R;
u2 : plus1_8 port map (x, CS1);
u1 : mux8 port map (x3, "00000001", CS1, CSi);
u3 : plus1_8 port map (y, CS2);
u4 : mux8 port map (x3, "00000001", CS2, CSiR);
process(clk)
begin
if(rst = '1') then
chainSize(0).L <= "00000001";
chainSize(conv_integer(unsigned(n) - 1)).R <= "00000001";
else
if (rising_edge(clk)) then
if (wrL = '1') then
chainSize(conv_integer(unsigned(i))).L <= CSi;
elsif (wrR = '1') then
chainSize(conv_integer(unsigned(i))).R <= CSiR;
end if;
end if;
end if;
end process;
cL <= chainSize(conv_integer(unsigned(i))).L;
cR <= chainSize(conv_integer(unsigned(i))).R;
end rtl;