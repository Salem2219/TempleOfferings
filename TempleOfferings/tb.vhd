library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start: std_logic;
  signal n, addr : std_logic_vector(3 downto 0);
  signal y, templeHeight : std_logic_vector (7 downto 0);
  component toplevel
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(3 downto 0);
    templeHeight : in std_logic_vector(7 downto 0);
    addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
  end component ;
  component rom is
port(addr: in std_logic_vector (3 downto 0);
data: out std_logic_vector (7 downto 0));
end component;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    n <= "0110";
    templeHeight_rom : rom port map (addr, templeHeight);
    dut: toplevel port map(clk,rst,start, n, templeHeight, addr, y);
  end behav;