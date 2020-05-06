library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ctrl is
  port(clk,rst, start, x1, x2: in std_logic;
       wrL, wrR, i_ld, x_ld, sum_ld: out std_logic;
       i_sel : out std_logic_vector(1 downto 0));
end ctrl;

architecture rtl of ctrl is
  type state_type is (s0,s1,s2,s3, s4, s5, s6, s7, s8, s9);
  signal current_state, next_state: state_type;
begin 
  process(x1, x2, start, current_state)
  begin
    case current_state is
	when s0 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '0';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "00";
	  next_state <= s1;
	when s1 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "00";
      if (start = '1') then
	  next_state <= s2;
      else
      next_state <= s1;
      end if;
	when s2 => 
       wrL <= '0';
       wrR <= '0';
       i_ld <= '0';
       x_ld <= '1';
       sum_ld <= '0';
       i_sel <= "00";
      if(x1 = '1') then
      next_state <= s3;
      else
      next_state <= s4;
      end if;
	when s3 =>  
       wrL <= '1';
       wrR <= '0';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "01";
	  next_state <= s2;
      when s4 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "10";
      next_state <= s5;
      when s5 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '0';
       x_ld <= '1';
       sum_ld <= '0';
       i_sel <= "00";
       if(x2 = '0') then
	  next_state <= s6;
    else
    next_state <= s7;
    end if;
    when s6 =>  
       wrL <= '0';
       wrR <= '1';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "01";
	  next_state <= s5;
    when s7 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '1';
       i_sel <= "11";
	  next_state <= s8;
    when s8 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '0';
       x_ld <= '0';
       sum_ld <= '0';
       i_sel <= "00";
       if (x1 = '1') then
	  next_state <= s9;
    else
    next_state <= s1;
    end if;
    when s9 =>  
       wrL <= '0';
       wrR <= '0';
       i_ld <= '1';
       x_ld <= '0';
       sum_ld <= '1';
       i_sel <= "01";
	  next_state <= s8;
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;