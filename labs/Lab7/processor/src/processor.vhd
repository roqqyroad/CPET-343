--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Joshua Massias
--
--       LAB NAME:  lab 8 Building a simple processor 
--
--      FILE NAME:  processor.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    8-bit microprocessor with add, sub, multiply & divideoperations  
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

PACKAGE  processor_pkg IS
  COMPONENT  processor IS    
    PORT (
	  pb_exec    : IN  std_logic;   --key(3)
      clk        : IN  std_logic;
      reset      : IN  std_logic;   --key(0)  
      -- 
      bcd2       : OUT  std_logic_vector(6 DOWNTO 0); --HEX2
      bcd1       : OUT  std_logic_vector(6 DOWNTO 0); --HEX1
      bcd0       : OUT  std_logic_vector(6 DOWNTO 0);  --HEX0
      Led        : out  std_logic_vector(9 downto 0)
	  );
  END COMPONENT;
END PACKAGE  processor_pkg;



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

library work;
use work.clock_synchronizer_pkg.all;
use work.edge_detect_pkg.all;
use work.Hex2seven_seg_pkg.all;
use work.delay_register_pkg.all;
use work.Instruction_decoder_pkg.all;
use work.calculator_pkg.all;

ENTITY  processor  IS
  PORT (
      pb_exec    : IN  std_logic;   --key(3)
      clk        : IN  std_logic;
      reset      : IN  std_logic;   --key(0) 
      -- 
      bcd2       : OUT  std_logic_vector(6 DOWNTO 0); --HEX2
      bcd1       : OUT  std_logic_vector(6 DOWNTO 0); --HEX1
      bcd0       : OUT  std_logic_vector(6 DOWNTO 0);  --HEX0
	  Led        : OUT  std_logic_vector(9 downto 0)
    );
END ENTITY  processor ;

ARCHITECTURE behave OF  processor  IS

---------------------------------------------------------------------------
 --Taken from ROM.cmp
 component ROM
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		--
		q		    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
  end component;
---------------------------------------------------------------------------
  --Signals
  SIGNAL  pb_exec_sync      : std_logic;
  SIGNAL  execute_instr_en  : std_logic;
  
  --Address Generator signal 
  SIGNAL  address_bus       : std_logic_vector(4 downto 0);
  
  --ROM signal
  SIGNAL  instruction_bus   : std_logic_vector(15 downto 0);
  SIGNAL  instruction_reg   : std_logic_vector(15 downto 0);
  
  --Delay register signal
  SIGNAL  decode_instr_en   : std_logic;
  
  --Instruction decoder SIGNALS
  SIGNAL pseudo_exe_pb_n  : std_logic;
  SIGNAL pseudo_ms_pb_n   : std_logic;
  SIGNAL pseudo_mr_pb_n   : std_logic;
  SIGNAL pseudo_operand   : std_logic_vector(7 DOWNTO 0);
  SIGNAL pseudo_mode      : std_logic_vector(1 DOWNTO 0);
  
  --HEX SIGNALS
  SIGNAL HEX2  : std_logic_vector(6 DOWNTO 0);
  SIGNAL HEX1  : std_logic_vector(6 DOWNTO 0);
  SIGNAL HEX0  : std_logic_vector(6 DOWNTO 0);
---------------------------------------------------------------------------
  
BEGIN

--Clock sync portmap for pb_exec/key(3)
	PBexec_clksync : clock_synchronizer
	Generic map (
	    bit_width => 1
	)
	PORT map (
	    async_in(0) => pb_exec,
	    clock       => clk,
		reset_n     => reset,
		--
		sync_out(0) => pb_exec_sync		
    );
 -------------------------------------------------
 
 -- Edge detect portmap for pb_exec/key(3)
	key_edgeDT : edge_detect
	PORT map (
		DataIn      => pb_exec_sync,
		clock       => clk,
		reset_n     => reset,
		--
		RisingEdge  => open,
		FallingEdge => execute_instr_en
    );
	
-------------------------------------------------
 --Address Generator Process
    AddressGen : PROCESS (reset, clk) IS
    BEGIN
        IF(reset = '0') THEN
            address_bus <= (OTHERS => '0');
        ELSIF ( rising_edge(clk) ) THEN
            IF (execute_instr_en = '1') THEN
                address_bus <= address_bus + 1;  --if it doesnt run make 1 a bit 
            END IF;
        END IF;
    END PROCESS  AddressGen;
 -------------------------------------------------
 --ROM
 ROM_inst : ROM PORT MAP (
		address	 =>  address_bus,
		clock	 =>  clk,
		q	     =>  instruction_bus
	);
	
 -------------------------------------------------
 --Register Enable Process
   RegEnProcess : PROCESS (reset, clk) IS
    BEGIN
        IF(reset = '0') THEN
            instruction_reg <= (OTHERS => '0');
        ELSIF ( rising_edge(clk) ) THEN
            IF (execute_instr_en = '1') THEN
                instruction_reg <= instruction_bus; 
            END IF;
        END IF;
    END PROCESS RegEnProcess;

 -------------------------------------------------
 --Delay Register portmap 
	DelayReg: delay_register
	GENERIC MAP (
      delay_size => 2,  
      bus_width  => 1
    )
	PORT MAP (
      clock       => clk,
      reset_n     => reset,
      data_in(0)  => execute_instr_en,
      --
      data_out(0) => decode_instr_en 
      );
 
 -------------------------------------------------
 --Instruction Decoder portmap 
	InstrucD: instruction_decoder
	PORT MAP (
	instruction_reg   => instruction_reg,
	decode_instr_en   => decode_instr_en,                  
     --
	pseudo_exe_pb_n   => pseudo_exe_pb_n,
	pseudo_ms_pb_n    => pseudo_ms_pb_n,
	pseudo_mr_pb_n    => pseudo_mr_pb_n,
	pseudo_operand    => pseudo_operand,
	pseudo_mode       => pseudo_mode
	 );
	  
--From Lab 7
    top_inst : calculator
    PORT MAP (
      B          => pseudo_operand,
	  mode       => pseudo_mode,
      clk        => clk,
      reset      => reset,
      key        => pseudo_exe_pb_n & pseudo_ms_pb_n & pseudo_mr_pb_n,
      --
      bcd2       => bcd2,
      bcd1       => bcd1,
      bcd0       => bcd0
      );
	  
	Led <= pseudo_mode & pseudo_operand;
	
	
END ARCHITECTURE behave;
