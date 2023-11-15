LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.top_pkg.ALL;


ENTITY top_tb IS

END ENTITY top_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF top_tb IS

    SIGNAL sw_combined_tb : std_logic_vector(9 downto 0) := (others => '0');
    
    SIGNAL clk_tb        : std_logic := '0';
    SIGNAL desired_op_tb : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL sw_tb         : std_logic_vector(7 downto 0) := (others => '0');
    SIGNAL key_tb        : std_logic_vector(3 downto 0) := (others => '1');
    --
    SIGNAL led_tb        : std_logic_vector(8 downto 0);
    SIGNAL hex0_tb       : std_logic_vector(6 downto 0);
    SIGNAL hex1_tb       : std_logic_vector(6 downto 0);
    SIGNAL hex2_tb       : std_logic_vector(6 downto 0);
    --
    SIGNAL PERIOD_c : time    := 20 ns;
    SIGNAL sim_done : boolean := false;

    procedure pb_event(signal pb : out std_logic) is
    begin
      pb <= '0';
      WAIT FOR PERIOD_c;
      pb <= '1';
      WAIT FOR PERIOD_c * 2;
    end procedure pb_event;
    
    ALIAS execute_tb     : std_logic is key_tb(3); 
    ALIAS ms_tb          : std_logic is key_tb(2); 
    ALIAS mr_tb          : std_logic is key_tb(1); 
    ALIAS reset_tb       : std_logic is key_tb(0); 
    
BEGIN  -- test
    ---------------------------------------------------------------------------
    -- instantiate the unit under test (UUT)
    ---------------------------------------------------------------------------
    UUT : top
    PORT MAP (
      CLOCK_50 => clk_tb,
      SW       => sw_combined_tb,
      KEY      => key_tb,
      --
      LEDR     => led_tb,
      HEX0     => hex0_tb,
      HEX2     => hex1_tb,
      HEX4     => hex2_tb
    );

    clk_tb <= NOT clk_tb AFTER (PERIOD_c / 2) WHEN (NOT sim_done) ELSE '0';
    -- sw_combined_tb <= desired_op_tb & sw_tb;
    
    ---------------------------------------------------------------------------
    -- the process will apply the test vectors to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
      VARIABLE sw_v : std_logic_vector(7 downto 0) := (others => '0');
      VARIABLE op_v : std_logic_vector(1 downto 0) := (others => '0');
    BEGIN  -- PROCESS stimulus
    
      pb_event(reset_tb);
      WAIT FOR PERIOD_c*4;
    
      sw_v := (others => '0');
      op_v := "00";
      sw_combined_tb <= op_v & sw_v;
      key_tb <= (others => '1');
      WAIT FOR PERIOD_c*2;
      
      sw_v := std_logic_vector(to_unsigned(4, 8));
      sw_combined_tb <= op_v & sw_v;
      WAIT FOR PERIOD_c;
      pb_event(execute_tb); -- ADD
      
      sw_v := std_logic_vector(to_unsigned(8, 8));
      op_v := "10";
      sw_combined_tb <= op_v & sw_v;
      WAIT FOR PERIOD_c;
      pb_event(execute_tb); -- Multiply
      pb_event(ms_tb);
      op_v := "01";
      sw_combined_tb <= op_v & sw_v;
      WAIT FOR PERIOD_c;
      pb_event(execute_tb); -- Subtract
      
      WAIT FOR PERIOD_c;
      sw_v := std_logic_vector(to_unsigned(2, 8));
      op_v := "11";
      sw_combined_tb <= op_v & sw_v;
      WAIT FOR PERIOD_c;
      pb_event(execute_tb); -- Divide
      WAIT FOR PERIOD_c;
      pb_event(mr_tb);
      WAIT FOR PERIOD_c*5;
      pb_event(execute_tb); -- Divide
      WAIT FOR PERIOD_c*6;

      sim_done <= true;
      WAIT FOR PERIOD_c;
      -----------------------------------------------------------------------
      -- stop simulation, wait here forever
      -----------------------------------------------------------------------
      wait;
    END PROCESS stimulus;

END ARCHITECTURE test;

-------------------------------------------------------------------------------