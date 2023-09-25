  -------------------------------------------------------------------------------
-- Dr. Kaputa
-- sensitivity demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity sensitivity is
  port (
    a     : in std_logic;
    b     : in std_logic;
    s     : in std_logic;
    c     : out std_logic
  );
end sensitivity;

architecture beh of sensitivity is

begin
process(s,a)
  begin
    if (s = '1') then 
      c <= a;
    else
      c <= b;
    end if; 
  end process;
end beh;