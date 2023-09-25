-------------------------------------------------------------------------------
-- Dr. Kaputa
-- concurrent demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity concurrent is
  port (
    a     : in std_logic;
    c     : out std_logic
  );
end concurrent;

architecture beh of concurrent is

signal b : std_logic;

begin
  b  <= a;   
  c  <= b;   
end beh;