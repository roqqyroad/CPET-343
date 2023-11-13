--*****************************************************************************
--*****************************   VHDL Source Code  ***************************
--*****************************************************************************
--
--      FILE NAME: generic_counter.vhd
--
------------------------------------------------------------------------------
-- DESCRIPTION 
--     
--    This file will create generic counter whose size can be adjusted by 
--    changing the generic max_count. When the counter reaches it maximum 
--    count value, the output port signal will be pulsed high for 1 clock.
--
--*****************************************************************************
--*****************************************************************************

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||
-- |||| PACKAGE DESCRIPTION
-- ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE generic_counter_pkg IS
  COMPONENT generic_counter IS
    GENERIC (
      max_count : integer := 3
      );
    PORT (
      clock   : IN  std_logic;
      reset_n : IN  std_logic;
      --
      output  : OUT std_logic
      );
  END COMPONENT generic_counter;
END PACKAGE generic_counter_pkg;


------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||
-- |||| COMPONENT DESCRIPTION
-- ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY generic_counter IS
  GENERIC (
    max_count : integer := 5
    );
  PORT (
    clock   : IN  std_logic;
    reset_n : IN  std_logic;
    --
    output  : OUT std_logic
    );  
END ENTITY generic_counter;

ARCHITECTURE beh OF generic_counter IS

  SIGNAL count_sig : integer RANGE 0 TO max_count := 0;

BEGIN

  --------------------------------------------------------------
  -- This process creates a counter that increments on every 
  -- rising edge of the clock. When the counter value reaches 
  -- it maximum count value, the counter is reset_n back to 0 and 
  -- the output is pulsed.
  --------------------------------------------------------------
  regs : PROCESS(clock, reset_n) IS
  BEGIN
    IF (reset_n = '0') THEN
      count_sig <= 0;
      output    <= '0';
    ELSIF rising_edge(clock) THEN
      IF (count_sig = max_count) THEN
        count_sig <= 0;
        output    <= '1';
      ELSE
        count_sig <= count_sig + 1;
        output    <= '0';
      END IF;
    END IF;
  END PROCESS regs;
  
END ARCHITECTURE beh;