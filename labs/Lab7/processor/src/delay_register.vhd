--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Josh Massias
--
--       LAB NAME:  Lab 8 delay register 
--
--      FILE NAME:  delay_register
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    Delay register 
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

PACKAGE delay_register_pkg IS
  COMPONENT delay_register IS    
    GENERIC (
      delay_size : integer  :=2;
	  bus_width  : integer  :=1
      );

    PORT (
      clock    : IN  std_logic;
	  reset_n  : IN  std_logic;
	  data_in  : IN  std_logic_vector(bus_width-1 DOWNTO 0);
      --
      data_out : OUT std_logic_vector(bus_width-1 DOWNTO 0)
      );
  END COMPONENT;
END PACKAGE delay_register_pkg;

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY delay_register  IS
 GENERIC (
      delay_size : integer  :=2;
	  bus_width  : integer  :=1
      );

    PORT (
      clock    : IN  std_logic;
	  reset_n  : IN  std_logic;
	  data_in  : IN  std_logic_vector(bus_width-1 DOWNTO 0);
      --
      data_out : OUT std_logic_vector(bus_width-1 DOWNTO 0)
    );
END ENTITY delay_register ;

ARCHITECTURE behave OF delay_register  IS

	TYPE memory_t IS ARRAY (delay_size-1 DOWNTO 0) OF std_logic_vector(bus_width-1 DOWNTO 0);
	SIGNAL delay_register : memory_t;
 
  
BEGIN

	Delays : PROCESS (reset_n, clock)
	BEGIN
		IF (reset_n = '0') THEN 
			delay_register <= (OTHERS => (OTHERS => '0'));
		ELSIF (rising_edge (clock)) THEN 
			delay_register(0) <= data_in;
		
			IF (delay_size > 1) THEN 
				delay_register(delay_size-1 DOWNTO 1) <=
					delay_register(delay_size-2 DOWNTO 0);
			END IF;
		END IF;
	END PROCESS Delays;
  
	data_out <= delay_register(delay_size-1);
		  	  
END ARCHITECTURE behave;
