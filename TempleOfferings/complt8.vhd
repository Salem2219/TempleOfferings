library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity complt8 is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic);
end complt8;

architecture rtl of complt8 is
begin
    y <= '1' when unsigned(a) < unsigned(b) else '0';
end rtl;
