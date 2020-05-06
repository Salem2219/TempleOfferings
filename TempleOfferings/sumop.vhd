library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity sumop is
    port (cL, cR, sum : in std_logic_vector(7 downto 0);
    max : out std_logic_vector(7 downto 0));
end sumop;

architecture rtl of sumop is
signal y : std_logic_vector(7 downto 0);
signal y_uns : unsigned(7 downto 0);
begin
    y <= cL when unsigned(cL) > unsigned(cR) else cR;
    y_uns <= unsigned(y) + unsigned(sum);
    max <= std_logic_vector(y_uns);
end rtl;



