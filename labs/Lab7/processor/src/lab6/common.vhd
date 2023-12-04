--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Bruce Link
--
--      FILE NAME:  common.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This file includes a collection of common definitions used throughout 
--    the design.
--
--    All variables/signals that end with "_n" are low active.
--    All identifiers that end with "_t" are user defined types
--    All identifiers that end with "_c" are user defined constants
--

--
--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE common_pkg IS
  CONSTANT ADD_EN_c : std_logic_vector(1 DOWNTO 0) := "00";
  CONSTANT SUB_EN_c : std_logic_vector(1 DOWNTO 0) := "01";
  CONSTANT MUL_EN_c : std_logic_vector(1 DOWNTO 0) := "10";
  CONSTANT DIV_EN_c : std_logic_vector(1 DOWNTO 0) := "11";

  CONSTANT HIGH_c     : std_logic := '1';
  CONSTANT LOW_c      : std_logic := '0';
  CONSTANT ENABLED_c  : std_logic := '1';
  CONSTANT DISABLED_c : std_logic := '0';

END PACKAGE common_pkg;
