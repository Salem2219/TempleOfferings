library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity plus1_8 is
    port (a : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end plus1_8;

architecture rtl of plus1_8 is
signal y_uns : unsigned(7 downto 0);
begin
y_uns <= unsigned(a) + 1;
y <= std_logic_vector(y_uns);
end rtl;
