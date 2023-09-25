-------------------------------------------------------------------------------
-- Dr. Kaputa
-- propagation delay test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity prop_delay_tb is
end prop_delay_tb;

architecture beh of prop_delay_tb is

signal a    : std_logic;
signal b    : std_logic;
signal c    : std_logic;

component prop_delay is
  port (
    a     : in std_logic;
    b     : in std_logic;
    c     : out std_logic
  );
end component;

begin
   a <= '0';
   b <= '0', '1' after 2 ns;

uut: prop_delay  
  port map(
    a => a,
    b => b,
    c => c
  );
end beh;