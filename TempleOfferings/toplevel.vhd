library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity toplevel is
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(3 downto 0);
    templeHeight : in std_logic_vector(7 downto 0);
    addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
    port (clk, rst, wrL, wrR, i_ld, x_ld, sum_ld : in std_logic;
    i_sel : in std_logic_vector(1 downto 0);
    n : in std_logic_vector(3 downto 0);
    templeHeight : in std_logic_vector(7 downto 0);
    x1, x2 : out std_logic;
    addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component ctrl is
  port(clk,rst, start, x1, x2: in std_logic;
       wrL, wrR, i_ld, x_ld, sum_ld: out std_logic;
       i_sel : out std_logic_vector(1 downto 0));
end component;
signal wrL, wrR, i_ld, x_ld, sum_ld, x1, x2 : std_logic;
signal i_sel : std_logic_vector (1 downto 0);
begin
    datapath : dp port map (clk, rst, wrL, wrR, i_ld, x_ld, sum_ld, i_sel, n, templeHeight, x1, x2, addr, y);
    control : ctrl port map (clk, rst, start, x1, x2, wrL, wrR, i_ld, x_ld, sum_ld, i_sel);
end rtl;