--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Joshua Massias
--
--       LAB NAME:  Lab8 top
--
--      FILE NAME:  top.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This file is a used for compiling file in Quartus so the ENTITY 
--    signals names match the DE1-SOC board pins file names. 
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 08/01/20 | xxx  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.processor_pkg.ALL;

ENTITY top IS
  PORT (
    CLOCK_50 : IN  std_logic;
    SW       : IN  std_logic_vector(9 DOWNTO 0);
    KEY      : IN  std_logic_vector(3 DOWNTO 0);
    --
    LEDR     : OUT std_logic_vector(9 DOWNTO 0);
    HEX0     : OUT std_logic_vector(6 DOWNTO 0);
    HEX1     : OUT std_logic_vector(6 DOWNTO 0);
    HEX2     : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

BEGIN

  top_inst : processor
    PORT MAP (
      clk          => CLOCK_50,
      reset        => KEY(0),
      pb_exec      => KEY(3),
      --
      bcd0         => HEX0,
      bcd1         => HEX1,
      bcd2         => HEX2,
	  Led		   => LEDR
      );


END ARCHITECTURE arch;
