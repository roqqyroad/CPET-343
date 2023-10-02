LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.seven_seg_counter_pkg.ALL;

ENTITY top IS
  PORT (
    CLOCK_50 : IN  std_logic;
    SW       : IN  std_logic_vector(0 DOWNTO 0);
	
    --
    HEX0     : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

BEGIN

  top_inst : seven_seg_counter
    PORT MAP (
      clk_50mhz      => CLOCK_50,
      
      --exe_pb_n   => KEY(3),
	  offset => "0001",
	  reset_n => SW(0),
      --
      seven_seg        => HEX0
      );


END ARCHITECTURE arch;