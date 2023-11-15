LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE clock_synchronizer_pkg IS
  COMPONENT clock_synchronizer IS
    GENERIC (
      bit_width : integer := 3
      );
    PORT (
      clk      : IN  std_logic;
      reset_n  : IN  std_logic;
      async_in : IN  std_logic_vector(bit_width-1 DOWNTO 0);
      sync_out : OUT std_logic_vector(bit_width-1 DOWNTO 0)
      );
  END COMPONENT clock_synchronizer;
  
END PACKAGE clock_synchronizer_pkg;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY clock_synchronizer IS
  GENERIC (
    bit_width : integer := 3
    );
  PORT (
    clk      : IN  std_logic;
    reset_n  : IN  std_logic;
    async_in : IN  std_logic_vector(bit_width-1 DOWNTO 0);
    sync_out : OUT std_logic_vector(bit_width-1 DOWNTO 0)
    );
END clock_synchronizer;

ARCHITECTURE behav OF clock_synchronizer IS


  SIGNAL prev_data_1 : std_logic_vector(bit_width-1 DOWNTO 0);
  SIGNAL prev_data_2 : std_logic_vector(bit_width-1 DOWNTO 0);

BEGIN

  -----------------------------------------------------------------------------
  -- 
  -----------------------------------------------------------------------------
  double_flop : PROCESS(reset_n, clk)
  BEGIN
    IF (reset_n = '0') THEN
      prev_data_1 <= (OTHERS => '0');
      prev_data_2 <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      prev_data_1 <= async_in;
      prev_data_2 <= prev_data_1;
    END IF;
  END PROCESS;

  sync_out <= prev_data_2;

END behav;