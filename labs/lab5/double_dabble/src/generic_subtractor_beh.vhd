--*****************************************************************************
--*****************************   VHDL Source Code  ***************************
--*****************************************************************************
--
--      FILE NAME: generic_subtractor_beh.vhd
--
------------------------------------------------------------------------------
-- DESCRIPTION 
--     
--    This file will create behavioral generic subtractor
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

PACKAGE generic_subtractor_beh_pkg IS
  COMPONENT generic_subtractor_beh IS
  GENERIC (
    num_bits : integer := 4
    );
  PORT (
    a    : IN  std_logic_vector(num_bits-1 DOWNTO 0);
    b    : IN  std_logic_vector(num_bits-1 DOWNTO 0);
    cin  : IN  std_logic;
    --
    sum  : OUT std_logic_vector(num_bits-1 DOWNTO 0);
    cout : OUT std_logic
    );
  END COMPONENT generic_subtractor_beh;
END PACKAGE generic_subtractor_beh_pkg;

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||
-- |||| COMPONENT DESCRIPTION
-- ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY generic_subtractor_beh IS
  GENERIC (
    num_bits : integer := 4
    );
  PORT (
    a    : IN  std_logic_vector(num_bits-1 DOWNTO 0);
    b    : IN  std_logic_vector(num_bits-1 DOWNTO 0);
    cin  : IN  std_logic;
    --
    sum  : OUT std_logic_vector(num_bits-1 DOWNTO 0);
    cout : OUT std_logic
    );
END ENTITY generic_subtractor_beh;

ARCHITECTURE beh OF generic_subtractor_beh IS

  SIGNAL sum_temp  : std_logic_vector(num_bits DOWNTO 0);
  SIGNAL cin_guard : std_logic_vector(num_bits-1 DOWNTO 0) := (OTHERS => '0');

BEGIN

  sum_temp <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b) - 
                               unsigned(cin_guard & cin));
  sum      <= sum_temp(num_bits-1 DOWNTO 0);
  cout     <= sum_temp(num_bits);           -- Carry is most significant bit
  
END ARCHITECTURE beh;