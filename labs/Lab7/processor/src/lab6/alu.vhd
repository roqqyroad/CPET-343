--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Bruce Link
--
--      FILE NAME:  alu.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This file will create data_a basic 8-bit ALU module that is capable of
--    implementing an adder, subtracter, multiplier, and a divider. The width
--    of the data is dynamic and is controlled by the generic data_width.
--    To control which operation the ALU outputs, a control signal (op_mode) 
--    is used to select the require ALU operation for output.
--
--    All variables/signals that end with "_n" are low active.
--    All identifiers that end with "_t" are user defined types
--    All identifiers that end with "_c" are user defined constants
--
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

PACKAGE alu_pkg IS
  COMPONENT alu IS
    GENERIC (
      data_width : integer := 8
      );
    PORT (
      clock   : IN  std_logic;
      reset_n : IN  std_logic;
      op_mode : IN  std_logic_vector(1 DOWNTO 0);
      data_a  : IN  std_logic_vector(data_width-1 DOWNTO 0);
      data_b  : IN  std_logic_vector(data_width-1 DOWNTO 0);
      --
      result  : OUT std_logic_vector(data_width-1 DOWNTO 0)
      );
  END COMPONENT alu;

END PACKAGE alu_pkg;



------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||                                                                   ||||
-- ||||                    COMPONENT DESCRIPTION                          ||||
-- ||||                                                                   ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.common_pkg.ALL;

ENTITY alu IS
  GENERIC (
    data_width : integer := 8
    );
  PORT (
    clock   : IN  std_logic;
    reset_n : IN  std_logic;
    op_mode : IN  std_logic_vector(1 DOWNTO 0);
    data_a  : IN  std_logic_vector(data_width-1 DOWNTO 0);
    data_b  : IN  std_logic_vector(data_width-1 DOWNTO 0);
    --
    result  : OUT std_logic_vector(data_width-1 DOWNTO 0)
    );
END ENTITY alu;

ARCHITECTURE behav OF alu IS


  SIGNAL add_result : std_logic_vector(data_width-1 DOWNTO 0);
  SIGNAL sub_result : std_logic_vector(data_width-1 DOWNTO 0);
  SIGNAL mul_result : std_logic_vector((data_width*2)-1 DOWNTO 0);
  SIGNAL div_result : std_logic_vector((data_width)-1 DOWNTO 0);



BEGIN

  add_result <= std_logic_vector(unsigned(data_a) + unsigned(data_b));
  sub_result <= std_logic_vector(unsigned(data_a) - unsigned(data_b));
  mul_result <= std_logic_vector(unsigned(data_a) * unsigned(data_b));
  div_result <= std_logic_vector(unsigned(data_a) / unsigned(data_b));



  --*************************************************************************
  --** Name: Operation Selector
  --**
  --** Description:
  --**  This process will register and hold the output value based on the   
  --**  add and sub enable signals. If neither is asserted then hold 
  --**  previous value. 
  --*************************************************************************
  op_select : PROCESS(reset_n, clock)
  BEGIN
    IF (reset_n = '0') THEN
      result <= (OTHERS => '0');
    ELSIF rising_edge(clock) THEN
      CASE (op_mode) IS
        WHEN ADD_EN_C =>
          result <= add_result;
        WHEN SUB_EN_C =>
          result <= sub_result;
        WHEN MUL_EN_C =>
          result <= mul_result(data_width-1 DOWNTO 0);
        WHEN DIV_EN_C =>
          result <= div_result(data_width-1 DOWNTO 0);
        WHEN OTHERS =>
          result <= (OTHERS => '0');
      END CASE;
    END IF;
  END PROCESS op_select;


END behav;
