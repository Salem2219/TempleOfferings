library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, wrL, wrR, i_ld, x_ld, sum_ld : in std_logic;
    i_sel : in std_logic_vector(1 downto 0);
    n : in std_logic_vector(3 downto 0);
    templeHeight : in std_logic_vector(7 downto 0);
    x1, x2 : out std_logic;
    addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end dp;

architecture rtl of dp is

component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component complt8 is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic);
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component mux4_1 is
    port (sel : in std_logic_vector(1 downto 0);
    a, b, c, d : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component pm is
    port ( sel : std_logic;
        a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus2 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component comp is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component reg8 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(7 downto 0);
reg_out: out std_logic_vector(7 downto 0));
end component;
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component sumop is
    port (cL, cR, sum : in std_logic_vector(7 downto 0);
    max : out std_logic_vector(7 downto 0));
end component;
component ram is
port(clk, rst, wrR, wrL, x3 : in std_logic;
i, n : in std_logic_vector(3 downto 0);
cL, cR : out std_logic_vector(7 downto 0));
end component;
signal x4, x5, x3 : std_logic;
signal i, i_in, ipm1, nminus2, addr_ipm1 : std_logic_vector(3 downto 0);
signal sum, max, cL, cR, x, sum_in : std_logic_vector(7 downto 0);
begin
    x4 <= not(wrR);
    x5 <= not(i_sel(1));
    x1_comp : complt port map (i, n, x1);
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    i_mux : mux4_1 port map (i_sel, "0001", ipm1, nminus2, "0000", i_in);
    i_pm : pm port map (wrR, i, ipm1);
    n_minus : minus2 port map (n, nminus2);
    x2_comp : comp port map (i, "1111", x2) ;
    addr_mux : mux4 port map (i_ld, i, addr_ipm1, addr);
    addr_pm : pm port map (x4, i, addr_ipm1);
    sum_reg : reg8 port map (clk, rst, sum_ld, sum_in, sum);
    sum_mux : mux8 port map (x5, "00000000", max, sum_in);
    sum_op : sumop port map (cL, cR, sum, max);
    y <= sum;
    chain_ram : ram port map (clk, rst, wrR, wrL, x3, i, n, cL, cR);
    temple_comp : complt8 port map (templeHeight, x, x3);
    x_reg : reg8 port map (clk, rst, x_ld, templeHeight, x);
end rtl;