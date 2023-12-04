--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Bruce Link
--
--      FILE NAME:  raminfr.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This design will implement/infer a synchronous mxn RAM. When the 
--    write enable signal (we_n) is low the SRAM is being written and the RAM 
--    location is designated by the address bus (address). The RAM has two 
--    data ports. The write data comes in on din and the read data goes 
--    out on dout. Since there are two ports, the RAM data is always 
--    presented (read) on the dout bus.
--
--    This design is designed to work with the Altera DE2 development board
--    and is designed to interface to the Avalon bus bridge peripheral.
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

PACKAGE raminfr_pkg IS
  COMPONENT raminfr IS
    GENERIC (
      addr_width : integer := 2;
      data_width : integer := 8
      );
    PORT(
      clock   : IN  std_logic;
      reset_n : IN  std_logic;
      we_n    : IN  std_logic;
      address : IN  std_logic_vector(addr_width-1 DOWNTO 0);
      din     : IN  std_logic_vector(data_width-1 DOWNTO 0);
      --
      dout    : OUT std_logic_vector(data_width-1 DOWNTO 0)
      );
  END COMPONENT;
END raminfr_pkg;



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


ENTITY raminfr IS
  GENERIC (
    addr_width : integer := 2;
    data_width : integer := 8
    );
  PORT(
    clock   : IN  std_logic;
    reset_n : IN  std_logic;
    we_n    : IN  std_logic;
    address : IN  std_logic_vector(addr_width-1 DOWNTO 0);
    din     : IN  std_logic_vector(data_width-1 DOWNTO 0);
    --
    dout    : OUT std_logic_vector(data_width-1 DOWNTO 0)
    );
END ENTITY raminfr;



ARCHITECTURE behav OF raminfr IS

  -----------------------------------------------------------------------------
  -- define components
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- define custom data types, constants, etc
  -----------------------------------------------------------------------------
  TYPE ram_type_t IS ARRAY ((2**addr_width)-1 DOWNTO 0) OF std_logic_vector(data_width-1 DOWNTO 0);

  -----------------------------------------------------------------------------
  -- define internal signals
  -----------------------------------------------------------------------------  
  SIGNAL ram_mem   : ram_type_t;
  SIGNAL read_addr : std_logic_vector(addr_width-1 DOWNTO 0);
  
BEGIN

  --*************************************************************************
  --** NAME: RAM Controller
  --**
  --** DESCRIPTION:
  --**    This process will infer a RAM block.
  --*************************************************************************
  RamBlock : PROCESS(clock)
  BEGIN
    IF (rising_edge(clock)) THEN
      IF (reset_n = '0') THEN
        ram_mem   <= (OTHERS => (OTHERS => '0'));
        read_addr <= (OTHERS => '0');
      ELSIF (we_n = '0') THEN
        ram_mem(to_integer(unsigned(address))) <= din;
      END IF;
      read_addr <= address;
    END IF;
  END PROCESS RamBlock;

  -- connect the RAM data to output port
  dout <= ram_mem(to_integer(unsigned(read_addr)));

END ARCHITECTURE behav;
