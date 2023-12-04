--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Joshua Massias
--
--       LAB NAME:  Lab 8 processor 
--
--      FILE NAME: Instruction_decoder.vhd  
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    Makes conversion from Opcode format to Lab 7 input 
--
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||                                                                   ||||
-- ||||                    COMPONENT PACKAGE                              ||||
-- ||||                                                                   ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

PACKAGE Instruction_decoder_pkg IS
  COMPONENT Instruction_decoder IS    
    PORT (
     
      instruction_reg   : IN  std_logic_vector(15 DOWNTO 0);
      decode_instr_en   : IN  std_logic;
      -- 
      pseudo_exe_pb_n   : OUT std_logic;
	  pseudo_ms_pb_n    : OUT std_logic;
	  pseudo_mr_pb_n    : OUT std_logic;
	  pseudo_operand    : OUT std_logic_vector(7 downto 0);
	  pseudo_mode       : OUT std_logic_vector(1 downto 0)  
      );
	  
  END COMPONENT;
END PACKAGE Instruction_decoder_pkg;



------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.common_pkg.all;

ENTITY Instruction_decoder  IS
  PORT (
     
      instruction_reg   : IN  std_logic_vector(15 DOWNTO 0);
      decode_instr_en   : IN  std_logic;
      -- 
      pseudo_exe_pb_n   : OUT std_logic;
	  pseudo_ms_pb_n    : OUT std_logic;
	  pseudo_mr_pb_n    : OUT std_logic;
	  pseudo_operand    : OUT std_logic_vector(7 downto 0);
	  pseudo_mode       : OUT std_logic_vector(1 downto 0)    
    );
	
END ENTITY Instruction_decoder ;

ARCHITECTURE behave OF Instruction_decoder  IS

ALIAS funct  : std_logic_vector(3 DOWNTO 0) IS instruction_reg(13 DOWNTO 10);
ALIAS mr_pb  : std_logic IS instruction_reg(9);
ALIAS ms_pb  : std_logic IS instruction_reg(8);
ALIAS data   : std_logic_vector(7 DOWNTO 0) IS instruction_reg(7 DOWNTO 0);
  
BEGIN
 
	pseudo_exe_pb_n <= not decode_instr_en WHEN ((mr_pb = '0') and (ms_pb = '0')) ELSE  '1';
    
	pseudo_ms_pb_n  <= not decode_instr_en WHEN (ms_pb = '1') ELSE '1';
	
	pseudo_mr_pb_n  <= not decode_instr_en WHEN (mr_pb = '1') ELSE '1';
	
	pseudo_operand  <= data;	

	pseudo_mode <= ADD_EN_c WHEN (funct = "1000") ELSE  --from the common
				   SUB_EN_c WHEN (funct = "0100") ELSE
				   DIV_EN_c WHEN (funct = "0010") ELSE
				   MUL_EN_c WHEN (funct = "0001") ELSE
				   ADD_EN_c;
			
	
END ARCHITECTURE behave;
