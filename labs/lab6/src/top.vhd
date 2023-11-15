LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE top_pkg IS
  COMPONENT top IS
    PORT (
      CLOCK_50 : IN  std_logic;
      SW       : IN  std_logic_vector(9 DOWNTO 0);
      KEY      : IN  std_logic_vector(3 DOWNTO 0);
      --
      LEDR     : OUT std_logic_vector(8 DOWNTO 0);
      HEX0     : OUT std_logic_vector(6 DOWNTO 0);
      HEX2     : OUT std_logic_vector(6 DOWNTO 0);
      HEX4     : OUT std_logic_vector(6 DOWNTO 0)
      );
  END COMPONENT top;
END PACKAGE top_pkg;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.rising_edge_synchronizer_pkg.ALL;
USE work.clock_synchronizer_pkg.ALL;
USE work.alu_pkg.ALL;
USE work.three_digit_display_pkg.ALL;
USE work.fsm_pkg.ALL;
USE work.memory_pkg.ALL;

ENTITY top IS
  PORT (
    CLOCK_50 : IN  std_logic;
    SW       : IN  std_logic_vector(9 DOWNTO 0);
    KEY      : IN  std_logic_vector(3 DOWNTO 0);
    --
    LEDR     : OUT std_logic_vector(8 DOWNTO 0);
    HEX0     : OUT std_logic_vector(6 DOWNTO 0);
    HEX2     : OUT std_logic_vector(6 DOWNTO 0);
    HEX4     : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

  -- Clock synchronized inputs
  SIGNAL sw_sync          : std_logic_vector(9 downto 0);
  SIGNAL key_sync         : std_logic_vector(3 downto 0);
  
  -- Push Button edge detect signals
  SIGNAL execute          : std_logic;
  SIGNAL ms               : std_logic;
  SIGNAL mr               : std_logic;
  SIGNAL reset_n          : std_logic;
  SIGNAL reset            : std_logic;
  
  SIGNAL alu_result       : std_logic_vector(7 downto 0);
  SIGNAL mem_addr         : std_logic_vector(1 downto 0);
  SIGNAL mem_write_en     : std_logic;
  SIGNAL mem_data_out     : std_logic_vector(7 downto 0);
  SIGNAL result_reg_inp   : std_logic_vector(7 downto 0);
  SIGNAL en_result_reg    : std_logic;
  SIGNAL load_saved_data  : std_logic;
  SIGNAL result           : std_logic_vector(11 downto 0) := (others => '0');
  
  -- Break down switches into two aliases
  ALIAS input_num         : std_logic_vector(7 downto 0) IS sw_sync(7 downto 0);
  ALIAS desired_op        : std_logic_vector(1 downto 0) IS sw_sync(9 downto 8);

BEGIN
  
  reset_n <= KEY(0);
  reset   <= NOT KEY(0); 
  -----------------------------------
  ----        Clock  Sync        ----
  -----------------------------------
  sw_clk_sync : clock_synchronizer
    GENERIC MAP (
      bit_width => 10
    )
    PORT MAP (
      clk      => CLOCK_50,
      reset_n  => reset_n,
      async_in => SW,
      sync_out => sw_sync
    );
    
  -- key_clk_sync : clock_synchronizer
    -- GENERIC MAP (
      -- bit_width => 4
    -- )
    -- PORT MAP (
      -- clk      => CLOCK_50,
      -- reset_n  => reset_n,
      -- async_in => KEY,
      -- sync_out => key_sync
    -- );
  
  -----------------------------------
  ----  Rising Edge Detect/Sync  ----
  -----------------------------------
  detect_exe : rising_edge_synchronizer
    PORT MAP (
      clk     => CLOCK_50,
      reset_n => reset_n,
      input   => KEY(3),
      edge    => execute
    );
    
  detect_ms : rising_edge_synchronizer
    PORT MAP (
      clk     => CLOCK_50,
      reset_n => reset_n,
      input   => KEY(2),
      edge    => ms
    );
    
  detect_mr : rising_edge_synchronizer
    PORT MAP (
      clk     => CLOCK_50,
      reset_n => reset_n,
      input   => KEY(1),
      edge    => mr
    );
  -----------------------------------
  
  state_machine : fsm
    PORT MAP (
      clock           => CLOCK_50,
      reset_n         => reset_n,
      exe_en          => execute,
      ms_en           => ms,
      mr_en           => mr,
      led_state       => LEDR,
      load_saved_data => load_saved_data,
      en_result_reg   => en_result_reg,
      mem_addr        => mem_addr,
      mem_write_en    => mem_write_en
    );
    
  RAM : memory
    GENERIC MAP (
      addr_width => 2,
      data_width => 8
    )
    PORT MAP (
      clk  => CLOCK_50,
      we   => mem_write_en,
      addr => mem_addr,
      din  => result(7 downto 0),
      dout => mem_data_out
    );
  
  calc_unit : alu
    PORT MAP (
      clk    => CLOCK_50,
      reset  => reset,
      a      => mem_data_out,
      b      => input_num,
      op     => desired_op,
      result => alu_result
    );

  -- Generate mux, get result register input
  result_reg_inp <= mem_data_out WHEN load_saved_data = '1' ELSE alu_result;
  
  -- Result register to get padded value for three digit display component
  result_reg : PROCESS(CLOCK_50) IS
  BEGIN
    IF(rising_edge(CLOCK_50)) THEN
      IF(en_result_reg = '1') THEN
        result <= "0000" & result_reg_inp;
      END IF;
    END IF;
  END PROCESS result_reg;
  
  -- Display the result
  disp : three_digit_display
    PORT MAP (
      reset_n   => reset_n,
      clk       => CLOCK_50,
      input     => result,
      ones      => HEX0,
      tens      => HEX2,
      hundreds  => HEX4
    );
  
END ARCHITECTURE arch;