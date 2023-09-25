-------------------------------------------------------------------------------
-- Dr. Kaputa
-- sequential demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity sequential is
  port (
    a     : in std_logic;
    c     : out std_logic
  );
end sequential;

architecture beh of sequential is

signal b : std_logic;

begin
process(a)
  begin
    b  <= a;   
    c  <= b;   
  end process;
end beh;

