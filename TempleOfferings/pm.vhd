library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pm is
    port ( sel : std_logic;
        a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end pm;

architecture rtl of pm is
signal y_uns : unsigned(3 downto 0);
begin
y_uns <= unsigned(a) - 1 when sel = '1' else unsigned(a) +1;
y <= std_logic_vector(y_uns);
end rtl;
