LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE seven_seg_counter_pkg IS
  COMPONENT seven_seg_counter IS    -- REPLACE adderSingleBitStructural with the name of this file

    Port ( 	clk_50mhz 	    : in  STD_LOGIC; --Input clock
			offset			: in  STD_LOGIC_VECTOR(3 downto 0) := "0001";
			reset_n			: in  STD_LOGIC;
			--
			seven_seg	    : out STD_LOGIC_VECTOR(6 downto 0)  --7-seg display outputs (g to a) for 7seg display
			);
  END COMPONENT;
END PACKAGE seven_seg_counter_pkg;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
USE work.bcd2seven_seg_pkg.ALL;
USE work.generic_adder_beh_pkg.ALL;
USE work.generic_counter_pkg.ALL;

entity seven_seg_counter is
	Port ( 	clk_50mhz 	    : in  STD_LOGIC; --Input clock
			offset			: in  STD_LOGIC_VECTOR(3 downto 0) := "0001";
			reset_n			: in  STD_LOGIC;
			--
			seven_seg	    : out STD_LOGIC_VECTOR(6 downto 0)  --7-seg display outputs (g to a) for 7seg display
			); 
end seven_seg_counter;

architecture count of seven_seg_counter is --created implementation

signal sum 		: std_logic_vector(3 downto 0) := "0000";
signal sum_reg 	: std_logic_vector(3 downto 0) := "0000";
signal enable 	: std_logic;

begin


gen_add: generic_adder_beh
	port map(
	  a => offset,
	  b => sum_reg,
	  cin => '0',
	  --
	  sum => sum,
	  cout => open
	);
cnt: generic_counter
    generic map(
	  max_count => 50000000
	  )
	port map(
	  clock => clk_50mhz,
	  reset_n => reset_n,
	  --
	  output => enable
	);
bdc_convert: bcd2seven_seg
port map(
  bcd_number => sum_reg,
  --
  seven_segment => seven_seg
  
);
convert : PROCESS(clk_50mhz, reset_n) IS
  BEGIN
    --IF (reset_n = '0') THEN
      --enable    <= '0';
	
    IF rising_edge(clk_50mhz) THEN
      IF (enable = '1') THEN
	    IF(sum = "1010") THEN
		   sum_reg <= "0000";
		Else
		   sum_reg <= sum;
		END IF;
      END IF;
    END IF;
  END PROCESS convert;

end count;