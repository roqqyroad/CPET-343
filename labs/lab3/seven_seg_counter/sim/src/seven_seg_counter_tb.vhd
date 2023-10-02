------------------------------------------------------------------------------
-- Rachel DuBois
------------------------------------------------------------------------------
    

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.bcd2seven_seg_pkg.ALL;
USE work.seven_seg_counter_pkg.ALL;

ENTITY seven_seg_counter_tb IS
END seven_seg_counter_tb;

ARCHITECTURE arch OF seven_seg_counter_tb IS
  SIGNAL sim_done : boolean   := false;
  -- Constants for test bench design
  CONSTANT PERIOD_c    : time    := 20 ns;
  CONSTANT MAX_COUNT_c : integer := 10;

  -- signals for test bench design
  SIGNAL offset_tb : std_logic_vector(3 DOWNTO 0) := "0001";
  SIGNAL hex0          : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL clk_tb		   : std_logic := '0';
  signal reset_n_tb	   : std_logic;

  -- create a new type, an array seven-segment values (ie: 2D array)
  TYPE seven_seg_t IS ARRAY (0 TO MAX_COUNT_c) OF std_logic_vector (6 DOWNTO 0);
  SIGNAL seven_seg_values : seven_seg_t := (
                          ZERO_c, ONE_c, TWO_c, THREE_c, FOUR_c, FIVE_c,
                          SIX_c, SEVEN_c, EIGHT_c, NINE_c, BLANK_c);

  
BEGIN
clk_tb <= NOT clk_tb AFTER PERIOD_c/2 WHEN (NOT sim_done) ELSE '0';
  -- instantiate the Unit Under Test
  UUT : seven_seg_counter PORT MAP(
    clk_50mhz	  => clk_tb,
    offset    => offset_tb,
	reset_n   => reset_n_tb,
    
    seven_seg => hex0
  );

  -----------------------------------------------------------------------------
  -- PROCESS: Stimulus will generate a counter that counts from 0 to max count
  -- and then stop. For each input, out will be verified.
  -----------------------------------------------------------------------------
  stimulus : PROCESS
  BEGIN
    REPORT "Simulation Running...";
	reset_n_tb <= '0';
    -- now lets sync the stimulus to the clock
    -- and move data off clock edge
    WAIT UNTIL (clk_tb'event and clk_tb = '1');
    WAIT FOR 2 ns;

    reset_n_tb <= '1';

    WAIT FOR 75 * PERIOD_c;
  

    -- we are done to wait two more clocks & set flag sim_done to true
    WAIT FOR 2 * PERIOD_c;
    WAIT UNTIL clk_tb = '0';
    sim_done <= true;

    -- Added a simple message to say we are done
    REPORT "Simulation Completed Successfully.";

    WAIT;                               -- wait here forever
END PROCESS;

END ARCHITECTURE arch;