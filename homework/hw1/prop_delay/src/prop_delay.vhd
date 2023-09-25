-------------------------------------------------------------------------------
-- Dr. Kaputa
-- propagation delay demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity prop_delay is
  port (
    a     : in std_logic;
    b     : in std_logic;
    c     : out std_logic
  );
end prop_delay;

architecture beh of prop_delay is

signal sig1 : std_logic;

begin
  sig1  <= a or b;   
  c     <= not sig1;   
end beh;