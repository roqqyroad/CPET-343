-------------------------------------------------------------------------------
-- Dr. Kaputa
-- delta time test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sensitivity_tb is
end sensitivity_tb;

architecture beh of sensitivity_tb is

signal a    : std_logic;
signal b    : std_logic;
signal s    : std_logic;
signal c    : std_logic;

component sensitivity is
  port (
    a     : in std_logic;
    b     : in std_logic;
    s     : in std_logic;
    c     : out std_logic
  );
end component;

begin
   a <= '0';
   b <= '0', '1' after 2ns;
   s <= '0';

uut: sensitivity  
  port map(
    a => a,
    b => b,
    s => s,
    c => c
  );
end beh;