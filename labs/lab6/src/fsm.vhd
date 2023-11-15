LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE fsm_pkg IS
  COMPONENT fsm IS   
    PORT (
      clock           : IN  std_logic;
      reset_n         : IN  std_logic;
      exe_en          : IN  std_logic;
      ms_en           : IN  std_logic;
      mr_en           : IN  std_logic;
      --
      led_state       : OUT std_logic_vector(8 downto 0);
      load_saved_data : OUT std_logic;
      en_result_reg   : OUT std_logic;
      mem_addr        : OUT std_logic_vector(1 downto 0);
      mem_write_en    : OUT std_logic
    );
  END COMPONENT;
END PACKAGE fsm_pkg;



------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm IS
  PORT (
    clock           : IN  std_logic;
    reset_n         : IN  std_logic;
    exe_en          : IN  std_logic;
    ms_en           : IN  std_logic;
    mr_en           : IN  std_logic;
    --
    led_state       : OUT std_logic_vector(8 downto 0);
    load_saved_data : OUT std_logic;
    en_result_reg   : OUT std_logic;
    mem_addr        : OUT std_logic_vector(1 downto 0);
    mem_write_en    : OUT std_logic
  );
END ENTITY fsm;

ARCHITECTURE behave OF fsm IS

  TYPE states_t IS (EXECUTE, WR_WORKING_MEM, RE_WORKING_MEM, WR_SAVE_MEM, RE_SAVE_MEM, WR_WORK_SAVE);
  
  SIGNAL curr_state : states_t;
  SIGNAL next_state : states_t;
  
  function get_LED_state(state_num : integer) return std_logic_vector is
    variable state : std_logic_vector(8 downto 0);
  begin
    state := (others => '0');
    state(state_num) := '1';
    return state;
  end get_LED_state;
  
BEGIN
  
  ----------------------------------------
  --          State Transition          --
  ----------------------------------------
  state_change : PROCESS(reset_n, clock) IS
  BEGIN
    IF(reset_n = '0') THEN
      curr_state <= RE_WORKING_MEM;
    ELSIF(rising_edge(clock)) THEN
      curr_state <= next_state;
    END IF;
  END PROCESS state_change;
  ----------------------------------------
  --        END State Transition        --
  ----------------------------------------
  
  
  ----------------------------------------
  -- State Transition Logic and Outputs --
  ----------------------------------------
  state_logic : PROCESS(exe_en, ms_en, mr_en, curr_state) IS
  BEGIN
    CASE(curr_state) IS
      WHEN RE_WORKING_MEM =>
        led_state <= get_LED_state(0);
        mem_write_en <= '0';
        load_saved_data <= '0';
        en_result_reg <= '0';
        mem_addr <= "00";
        
        -- State Transition Logic
        IF(ms_en = '1') THEN
          next_state <= WR_SAVE_MEM;
        ELSIF(mr_en ='1') THEN
          next_state <= RE_SAVE_MEM;
        ELSIF(exe_en = '1') THEN
          next_state <= EXECUTE;
        ELSE
          next_state <= RE_WORKING_MEM;
        END IF;
        
      WHEN WR_WORKING_MEM =>
        led_state <= get_LED_state(1);
        mem_write_en <= '1';
        load_saved_data <= '0';
        en_result_reg <= '0';
        mem_addr <= "00";
        
        -- State Transition Logic
        next_state <= RE_WORKING_MEM;
        
      WHEN WR_WORK_SAVE =>
        led_state <= get_LED_state(6);
        mem_write_en <= '0';
        load_saved_data <= '1';
        en_result_reg <= '1';
        mem_addr <= "01";
        
        next_state <= WR_WORKING_MEM;
        
      WHEN RE_SAVE_MEM =>
        led_state <= get_LED_state(2);
        mem_write_en <= '0';
        load_saved_data <= '1';
        en_result_reg <= '0';
        mem_addr <= "01";
        
        -- State Transition Logic
        next_state <= WR_WORK_SAVE;
      
      WHEN WR_SAVE_MEM =>
        led_state <= get_LED_state(3);
        mem_write_en <= '1';
        load_saved_data <= '0';
        en_result_reg <= '0';
        mem_addr <= "01";
        
        -- State Transition Logic
        next_state <= RE_WORKING_MEM;
          
      WHEN EXECUTE =>
        led_state <= get_LED_state(4);
        mem_write_en <= '1';
        load_saved_data <= '0';
        en_result_reg <= '1';
        mem_addr <= "00";
        
        -- State Transition Logic
        next_state <= WR_WORKING_MEM;
        
    END CASE;
  END PROCESS state_logic;
  ----------------------------------------
  --  END Transition Logic and Outputs  --
  ----------------------------------------

END ARCHITECTURE behave;