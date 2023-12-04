--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Joshua Massias
--
--       LAB NAME:  lab 6 seven segment display counter 
--
--      FILE NAME:  Hex2seven_seg
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will <insert detailed description of design>. 
--
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 08/23/20 | XXX  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||                                                                   ||||
-- ||||                    COMPONENT PACKAGE                              ||||
-- ||||                                                                   ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE Hex2seven_seg_pkg IS
  COMPONENT Hex2seven_seg IS    -- REPLACE Hex2seven_seg with the name of this file
    PORT (
      -- add any inputs here
      BCD : IN  std_logic_vector(3 DOWNTO 0);
      --
      -- add any outputs here
      sevenseg  : OUT  std_logic_vector(6 DOWNTO 0)
      );
	  
  END COMPONENT;
constant zero  : std_logic_vector(6 downto 0) := "1000000"; 
constant one   : std_logic_vector(6 downto 0) := "1111001";
constant two   : std_logic_vector(6 downto 0) := "0100100";
constant three : std_logic_vector(6 downto 0) := "0110000";
constant four  : std_logic_vector(6 downto 0) := "0011001";
constant five  : std_logic_vector(6 downto 0) := "0010010";
constant six   : std_logic_vector(6 downto 0) := "0000010";
constant seven : std_logic_vector(6 downto 0) := "1111000";
constant eight : std_logic_vector(6 downto 0) := "0000000";
constant nine  : std_logic_vector(6 downto 0) := "0010000";
constant blank : std_logic_vector(6 downto 0) := "1111111";
--add A - F
constant A     : std_logic_vector(6 downto 0) := "0001000";
constant B     : std_logic_vector(6 downto 0) := "0000011";
constant C     : std_logic_vector(6 downto 0) := "1000110";
constant D     : std_logic_vector(6 downto 0) := "0100001";
constant E     : std_logic_vector(6 downto 0) := "0000110";
constant F     : std_logic_vector(6 downto 0) := "0001110";
 
END PACKAGE Hex2seven_seg_pkg;



------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

library work;
use work.Hex2seven_seg_pkg.all;

ENTITY Hex2seven_seg IS
    PORT (
      -- add any inputs here
      BCD : IN  std_logic_vector(3 DOWNTO 0);
      --
      -- add any outputs here
      sevenseg  : OUT  std_logic_vector(6 DOWNTO 0)
      );
	  
END ENTITY Hex2seven_seg;

ARCHITECTURE behave OF Hex2seven_seg  IS

  
BEGIN 
process(BCD)  
begin 
	Case BCD is 
		When "0000" => sevenseg <= zero;
		When "0001" => sevenseg <= one;
		When "0010" => sevenseg <= two;
		When "0011" => sevenseg <= three; 
		When "0100" => sevenseg <= four;
		When "0101" => sevenseg <= five; 
		When "0110" => sevenseg <= six;
		When "0111" => sevenseg <= seven;
		When "1000" => sevenseg <= eight;
		When "1001" => sevenseg <= nine;
		--add 10-15, A-F(HEX)
		When "1010" => sevenseg <= A; 
		When "1011" => sevenseg <= B; 
		When "1100" => sevenseg <= C; 
		When "1101" => sevenseg <= D; 
		When "1110" => sevenseg <= E; 
		When "1111" => sevenseg <= F; 
		When others => sevenseg <= blank;
	END Case;	
END process;
 ---------------------------------------------------------------------------
  -- define your equations/design here
  ---------------------------------------------------------------------------

END ARCHITECTURE behave;
