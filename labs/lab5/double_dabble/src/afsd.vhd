--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  <enter your name here>
--
--       LAB NAME:  Labx: <name of lab>
--
--      FILE NAME:  add_sub.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This file uses an FSM to add or subtract two 8-bit values 
--    set with the switches on the board.  The state is advanced 
--	  by using the push button on the board.
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE add_sub_pkg IS
  COMPONENT add_sub IS    -- REPLACE adderSingleBitStructural with the name of this file

    Port ( 	clk_50mhz 	    : in  STD_LOGIC; --Input clock
			a_in			: in  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			--b_in			: in  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			reset_n			: in  STD_LOGIC;
			pb_in		: in  STD_LOGIC := '0';
			--
			hex2	    : out STD_LOGIC_VECTOR(6 downto 0);  --7-seg display outputs (g to a)
			hex1	    : out STD_LOGIC_VECTOR(6 downto 0);  --for 7seg display
			hex0	    : out STD_LOGIC_VECTOR(6 downto 0);
			ledOut      : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
			);
  END COMPONENT;
END PACKAGE add_sub_pkg;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
USE work.bcd2seven_seg_pkg.ALL;
USE work.generic_adder_beh_pkg.ALL;
USE work.generic_subtractor_beh_pkg.ALL;
USE work.edge_detect_pkg.ALL;
USE work.clock_synchronizer_pkg.ALL;
USE work.double_dabble_pkg.ALL;

entity add_sub is
	Port ( 	clk_50mhz   : in  STD_LOGIC; --Input clock
			a_in        : in  STD_LOGIC_VECTOR(7 downto 0) := "00000000"; --inputs
			--b_in        : in  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
			reset_n	    : in  STD_LOGIC; --reset
			pb_in       : in  STD_LOGIC := '0'; --push_button to advance state
			--
			hex2        : out STD_LOGIC_VECTOR(6 downto 0);  --7-seg display outputs (g to a)
			hex1        : out STD_LOGIC_VECTOR(6 downto 0);
			hex0        : out STD_LOGIC_VECTOR(6 downto 0);
			ledOut      : out STD_LOGIC_VECTOR(3 downto 0) := "0000" 
			); 
end add_sub;

architecture count of add_sub is --created implementation
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

begin

--define add and subtract units 
gen_add: generic_adder_beh --adder
    generic map(
	  num_bits => 8
    )
	port map(
	  a => a_reg,
	  b => b_reg,
	  cin => '0',
	  --
	  sum => add_out,
	  cout => coutSigA
	);
gen_sub: generic_subtractor_beh --subtractor
    generic map(
	  num_bits => 8
    )
	port map(
	  a => a_reg,
	  b => b_reg,
	  cin => '0',
	  --
	  sum => sub_out,
	  cout => coutSigS
	);
--define double dabble
hexOuts: double_dabble
    port map(
	  result_padded => out_12b,
      --
	  ones => hex1s,
	  tens => hex10s,
	  hundreds => hex100s
	);
--7 segment display components
hexHund: bcd2seven_seg --output 7seg
port map(
  bcd_number => hex100s,
  --
  seven_segment => hex2
);
hexTen: bcd2seven_seg --A Input 7seg
port map(
  bcd_number => hex10s,
  --
  seven_segment => hex1
);
hexOne: bcd2seven_seg --B Input 7seg
port map(
  bcd_number => hex1s,
  --
  seven_segment => hex0
);
--synchronization definitions
pushButton: edge_detect --detects push button falling edge
port map(
  clock => clk_50mhz,
  reset_n => reset_n,
  DataIn  => pb_in,
  --
  RisingEdge => open,
  FallingEdge => pb_sync
);
-- zpushButton: edge_detect --detects reset rising edge
-- port map(
  -- clock => clk_50mhz,
  -- reset_n => reset_n,
  -- DataIn  => pb_sync,
  
  -- RisingEdge => pbz_sync,
  -- FallingEdge => open
-- );
resetEdge: edge_detect --detects reset rising edge
port map(
  clock => clk_50mhz,
  reset_n => '0',
  DataIn  => reset_n,
  --
  RisingEdge => reset_edge,
  FallingEdge => open
);
ASync: clock_synchronizer -- sync A Input
  generic map (
    bit_width => 8
  )
  port map (
    clock => clk_50mhz,
    reset_n  => reset_n,
    async_in => a_in,
    --
    sync_out => a_sync
);
-- sync: process(clk_50mhz, reset_edge)
	-- begin
		-- if(reset_edge = '1') then
			-- current_state <= input_a;
		-- elsif(clk_50mhz'event and clk_50mhz = '1') then
			-- current_state <= next_state;
		-- end if;
-- end process;
sync: process(clk_50mhz, reset_edge)
	begin
		if(reset_edge = '1') then
			current_state <= input_a;
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			current_state <= next_state;
		end if;
end process;
--uses current state to determine outputs of FSM
logic: process(current_state, a_sync, b_sync, reset_edge, pb_sync)
	begin
		case (current_state) is
			--Input A value (8-bit)
			when input_a =>
				ledOut <= "0001";
				if(pb_sync = '1') then 		--if push button pressed
					next_state <= input_b;  --transition to b input
				else 
					next_state <= input_a;  --otherwise stay in current state
				end if;
			--Input B value (8-bit)
			when input_b =>
			    ledOut <= "0010";
				if(pb_sync = '1') then 		--if push button pressed
					next_state <= disp_sum;	--transition to sum display
				else                        
					next_state <= input_b;	--otherwise stay in current state
				end if;
			--DISP_SUM
			when disp_sum =>
			    ledOut <= "0100";
				if(pb_sync = '1') then 		--if push button pressed
					next_state <= disp_diff;--transition to difference display
				else                        
					next_state <= disp_sum;	--otherwise stay in current state
				end if;
			--DISP_DIFF
			when disp_diff =>
			    ledOut <= "1000";
				if(pb_sync = '1') then 		--if push button pressed
					next_state <= input_a;	--transition back to a input
				else                        
					next_state <= disp_diff;--otherwise stay in current state
				end if;
			--OTHERS
			when others =>
				next_state <= input_a;      --if lost go to input a
				
		end case;
end process;
-- gonext: process(current_state, next_state, pb_sync)
     -- begin
	     -- current_state <= next_state;
-- end process;
--process for setting A input
aInput: process(clk_50mhz, reset_edge, current_state, a_sync)
	begin
		if(reset_edge = '1') then
			a_reg <= "00000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					a_reg <= a_sync;   --if input_a, get input from A and store
				--INPUT B
				when input_b =>
					a_reg <= a_reg;    --all other states stay idle
				--DISP_SUM
				when disp_sum =>
					a_reg <= a_reg;   
				--DISP_DIFF
				when disp_diff =>
					a_reg <= a_reg;   
				--OTHERS
				when others =>
					a_reg <= a_reg;   
			end case;
		end if;
end process;
--process for setting B input
bInput: process(clk_50mhz, reset_edge, current_state, b_sync)
	begin
		if(reset_edge = '1') then
			b_reg <= "00000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					b_reg <= b_reg;   --if input_b, get input from A and store
				--INPUT B             
				when input_b =>       
					b_reg <= a_sync;  --all other states stay idle
				--DISP_SUM
				when disp_sum =>
					b_reg <= b_reg;	        
				--DISP_DIFF
				when disp_diff =>
					b_reg <= b_reg;	        
				--OTHERS
				when others =>
					b_reg <= b_reg;	        
			end case;
		end if;
end process;
--process for setting addition input
setAdd: process(clk_50mhz, reset_edge, current_state, add_out)
	begin
		if(reset_edge = '1') then
			add_reg <= "00000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					add_reg <= add_reg;  --if disp_sum, get input from adder and store
				--INPUT B                
				when input_b =>          
					add_reg <= add_reg;  --all other states stay idle
				--DISP_SUM
				when disp_sum =>
					add_reg <= add_out;
				--DISP_DIFF
				when disp_diff =>
					add_reg <= add_reg;
				--OTHERS
				when others =>
					add_reg <= add_reg;
			end case;
		end if;
end process;
--process for setting subtraction input
setSub: process(clk_50mhz, reset_edge, current_state, sub_out)
	begin
		if(reset_edge = '1') then
			sub_reg <= "00000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					sub_reg <= sub_reg;  --if disp_diff, get input from sub and store
				--INPUT B                
				when input_b =>          
					sub_reg <= sub_reg;  --all other states stay idle
				--DISP_SUM
				when disp_sum =>
					sub_reg <= sub_reg;
				--DISP_DIFF
				when disp_diff =>
					sub_reg <= sub_out;
				--OTHERS
				when others =>
					sub_reg <= sub_reg;
			end case;
		end if;
end process;
--sets output signal based on state
setOut: process(clk_50mhz, reset_edge, current_state, output)
	begin
		if(reset_edge = '1') then
			output <= "00000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					output <= a_reg;  --change output based on which state FSM is in
				--INPUT B                
				when input_b =>          
					output <= b_reg;  --will always change on state change
				--DISP_SUM
				when disp_sum =>
					output <= add_reg;
				--DISP_DIFF
				when disp_diff =>
					output <= sub_reg;
				--OTHERS
				when others =>
					output <= output;
			end case;
		end if;
end process;
--================================================
--set output signal to be 12 bits
setOut12b: process(clk_50mhz, reset_edge, current_state, output)
	begin
		if(reset_edge = '1') then
			out_12b <= "000000000000";
		elsif(clk_50mhz'event and clk_50mhz = '1') then
			case(current_state) is
				--INPUT A
				when input_a =>
					out_12b <= "0000" & output;
				--INPUT B                
				when input_b =>          
					out_12b <= "0000" & output;
				--DISP_SUM
				when disp_sum =>
					out_12b <= "000" & coutSigA & output;
				--DISP_DIFF
				when disp_diff =>
					out_12b <= "000" & coutSigS & output;
				--OTHERS
				when others =>
					out_12b <= out_12b;
			end case;
		end if;
end process;

end count;