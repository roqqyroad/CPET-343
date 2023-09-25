-------------------------------------------------------------------------------
-- Dr. Kaputa
-- concurrency test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity concurrency_tb is
end concurrency_tb;

architecture beh of concurrency_tb is

signal a              : std_logic;
signal c_concurrent   : std_logic;
signal c_sequential   : std_logic;

component concurrent is
  port (
    a     : in std_logic;
    c     : out std_logic
  );
end component;

component sequential is
  port (
    a     : in std_logic;
    c     : out std_logic
  );
end component;


begin
   a <= '0', '1' after 2 ns;

uut_concurrent: concurrent  
  port map(
    a => a,
    c => c_concurrent
  );
  
uut_sequential: sequential  
  port map(
    a => a,
    c => c_sequential
  ); 
end beh;