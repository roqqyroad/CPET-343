
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.add_sub_pkg.ALL;

ENTITY top IS
  PORT (
    CLOCK_50 : IN  std_logic;
    SW       : IN  std_logic_vector(9 DOWNTO 0);
	KEY      : IN  std_logic_vector(0 DOWNTO 0);
    --
    HEX0     : OUT std_logic_vector(6 DOWNTO 0);
	HEX1     : OUT std_logic_vector(6 DOWNTO 0);
	HEX2     : OUT std_logic_vector(6 DOWNTO 0);
	LEDR     : OUT std_logic_vector(3 downto 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

BEGIN

  top_inst : add_sub
    PORT MAP (
      clk      => clk,
      
      a_in   => SW(7 downto 0),
	  reset => SW(9),
	  pb_in => KEY(0),
      --
      hex2        => HEX2,
	  hex1        => HEX1,
	  hex0        => HEX0,
	  ledOut      => LEDR(3 downto 0)
      );


END ARCHITECTURE arch;