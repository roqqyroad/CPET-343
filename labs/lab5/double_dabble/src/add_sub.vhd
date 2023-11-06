-------------------------------------------------------------------------------
-- Rachel DuBois
-- adder and subtractor state machine
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;

PACKAGE add_sub_pkg IS
  COMPONENT add_sub IS    -- REPLACE adderSingleBitStructural with the name of this file

    Port ( 	clk_50mhz 	    : in  STD_LOGIC; --Input clock
			a_in			: in  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			--b_in			: in  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			reset			: in  STD_LOGIC;
			pb_in		: in  STD_LOGIC := '0';
			--
			hex2	    : out STD_LOGIC_VECTOR(6 downto 0);  --7-seg display outputs (g to a)
			hex1	    : out STD_LOGIC_VECTOR(6 downto 0);  --for 7seg display
			hex0	    : out STD_LOGIC_VECTOR(6 downto 0);
			ledOut      : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
			);
  END COMPONENT;
END PACKAGE add_sub_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity add_sub_state_machine is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    a_in        : in  STD_LOGIC_VECTOR(7 downto 0) := "00000000"; --inputs
		pb_in       : in  STD_LOGIC := '0'; --push_button to advance state
		--
		hex2        : out STD_LOGIC_VECTOR(6 downto 0);  --7-seg display outputs (g to a)
		hex1        : out STD_LOGIC_VECTOR(6 downto 0);
		hex0        : out STD_LOGIC_VECTOR(6 downto 0);
		ledOut      : out STD_LOGIC_VECTOR(3 downto 0) := "0000" 
  );
end entity add_sub_state_machine;

architecture beh of add_sub_state_machine is

--state definitions
type state_type is (input_a, input_b, disp_sum, disp_diff); --states
signal current_state, next_state : state_type; --defining what holds the states

--signal declarations 

--synchronized/edge detecting signals
signal pb_sync    : std_logic := '0';
--signal pbz_sync   : std_logic := '0';
signal a_sync     : std_logic_vector(7 downto 0) := "00000000";
signal b_sync     : std_logic_vector(7 downto 0) := "00000000";
signal reset_edge : std_logic;
signal add_out    : std_logic_vector(7 downto 0) := "00000001";
signal sub_out    : std_logic_vector(7 downto 0) := "00000001";
signal output     : std_logic_vector(7 downto 0) := "00000000";
signal out_12b    : std_logic_vector(11 downto 0):= "000000000000";
signal coutSigA    : std_logic := '0';
signal coutSigS    : std_logic := '0';
--signal pbhold     : std_logic := '0';

--hex output signals
signal hex1s      : std_logic_vector(3 downto 0) := "0000";
signal hex10s     : std_logic_vector(3 downto 0) := "0000";
signal hex100s    : std_logic_vector(3 downto 0) := "0000";

--register signals
signal a_reg      : std_logic_vector(7 downto 0) := "00000000";
signal b_reg      : std_logic_vector(7 downto 0) := "00000000";
signal add_reg    : std_logic_vector(7 downto 0) := "00000000";
signal sub_reg    : std_logic_vector(7 downto 0) := "00000000";

--end of signals

begin

state_machine: process()
  begin



    

end process;

mux: process(reset,clk)
  begin
    if reset = '1' then
      flag <= '0';
    elsif rising_edge(clk) then
      if (add_en = '1') then   
        flag <= '0';
      elsif (sub_en = '1') then
        flag <= '1';
      end if;
    end if;
end process; 

sync_output: process(reset,clk)
  begin
    if reset = '1' then
      result_sig <= "0000";
    elsif rising_edge(clk) then
      result_sig <= result;
    end if;
end process; 

a_lcd: seven_seg 
  port map (
    bcd             => a_sync_bcd,
    seven_seg_out   => a_bcd
  );  
 
b_lcd: seven_seg 
  port map (
    bcd             => b_sync_bcd,
    seven_seg_out   => b_bcd
  );   
  
result_lcd: seven_seg 
  port map (
    bcd             => result_sig,
    seven_seg_out   => result_bcd
  );  
  
  a_sync_bcd <= '0' & a_sync;
  b_sync_bcd <= '0' & b_sync;
end beh;


