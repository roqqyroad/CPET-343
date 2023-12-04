--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME: Joshua Massias
--
--       LAB NAME:  Lab 8 proceessor 
--
--      FILE NAME:  processor_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    Testbench for Processor.vhd
--
--
-------------------------------------------------------------------------------
--*****************************************************************************
-------------------------------------------------------------------------------

-- include ieee packages here
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

-- include your packages here
LIBRARY work;
USE work.processor_pkg.ALL;
USE work.clock_synchronizer_pkg.all;
USE work.edge_detect_pkg.all;
USE work.Hex2seven_seg_pkg.all;
use work.delay_register_pkg.all;
use work.Instruction_decoder_pkg.all;

ENTITY processor_tb IS

END ENTITY processor_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF processor_tb IS
  COMPONENT processor IS    
    PORT (
	  pb_exec    : IN  std_logic;   --key(3)
      clk        : IN  std_logic;
      reset      : IN  std_logic;   --key(0)  
      -- 
      bcd2       : OUT  std_logic_vector(6 DOWNTO 0); --HEX2
      bcd1       : OUT  std_logic_vector(6 DOWNTO 0); --HEX1
      bcd0       : OUT  std_logic_vector(6 DOWNTO 0)  --HEX0
      );
 END COMPONENT;
  
  
 CONSTANT PERIOD_c                   : time      := 20 ns;
 --CONSTANT NUM_CLK_CYCLES_PB_ACTIVE_c : time      := 1 ns;
 ---CONSTANT PERIOD_c                      : time      := 1 ns;
 
 
 SIGNAL sim_done     : boolean   := false;
 SIGNAL pb_exec_tb   : std_logic := '0';
 SIGNAL clk_tb       : std_logic := '0';
 SIGNAL reset_tb     : std_logic := '0';
 --
 SIGNAL bcd2_tb      : std_logic_vector(6 DOWNTO 0);
 SIGNAL bcd1_tb      : std_logic_vector(6 DOWNTO 0);
 SIGNAL bcd0_tb      : std_logic_vector(6 DOWNTO 0);

	procedure Cycle_Execute_pb (signal pb : out std_logic) is 
	begin 
	  pb <= '0';
	  wait for 1*PERIOD_c;
	  pb <= '1';
	  wait for 30*PERIOD_c;
	 
	end procedure Cycle_Execute_pb;
	
BEGIN
clk_tb <= NOT clk_tb AFTER PERIOD_C/2 WHEN (NOT sim_done) ELSE '0';	

	UUT : processor 
	PORT MAP (
      pb_exec =>  pb_exec_tb,
	  clk     =>  clk_tb,   
	  reset   =>  reset_tb,  
	  --          --     
	  bcd2    =>  bcd2_tb,  
	  bcd1    =>  bcd1_tb,   
	  bcd0    =>  bcd0_tb   
    );
	
stimulus : PROCESS      	   
BEGIN  -- test	
	
	REPORT "Starting verification of USE CASE"; 
	
	Cycle_Execute_pb(reset_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	Cycle_Execute_pb(pb_exec_tb);
	
	
	REPORT "Simulation Completed Successfully"; 
	WAIT FOR PERIOD_c;
	
	sim_done <= true;
	wait;
	 
 END PROCESS stimulus;

END ARCHITECTURE test;

-------------------------------------------------------------------------------
