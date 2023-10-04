-------------------------------------------------------------------------------
-- Rachel DuBois
-- seven segment counter 
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity seven_seg_counter is
	Port ( 	clk 	        : in  STD_LOGIC; --Input clock
			reset			: in  STD_LOGIC;
			seven_seg_outp  : out STD_LOGIC_VECTOR(6 downto 0)  --7-seg display outputs (g to a) for 7seg display
			); 
end seven_seg_counter;

architecture beh of seven_seg_counter is

signal sum 		: std_logic_vector(3 downto 0) := "0000";
signal sum_sig 	: std_logic_vector(3 downto 0) := "0000";
signal enable 	: std_logic;


component seven_seg is
	port (
		clk                : in  std_logic;
		reset              : in std_logic;
	  	bcd                : in  std_logic_vector(3 downto 0);
	  	seven_seg_out      : out std_logic_vector(6 downto 0)
	);  
  end component; 


  component generic_counter is
	generic(
		max_count : integer := 3
	);
	port (
	  clk             : in  std_logic; 
	  reset           : in  std_logic;
	  output          : out std_logic
	);  
  end component; 


  component generic_adder_beh is
	port (
	  a             : in  std_logic_vector(3 downto 0); 
	  b             : in  std_logic_vector(3 downto 0);
	  cin           : in std_logic;
	  sum           : out std_logic_vector(3 downto 0);
	  cout          : out std_logic
	);  
  end component; 

begin


gen_add: generic_adder_beh
	port map(
	  a => sum_sig,
	  b => "0001",
	  cin => '0',
	  sum => sum,
	  cout => open
	);
counter: generic_counter
	generic map(
		max_count => 50000000
	)
	port map(
	  clk => clk,
	  reset => reset,
	  output => enable
	);
bdc_convert: seven_seg
port map(	 
	clk => clk,
	reset => reset,
 	bcd => sum_sig,
  	seven_seg_out => seven_seg_outp
  
);
convert : process(clk, reset)
begin
	if (reset = '1') then
	 	sum_sig <="1111";
	elsif (clk'event and clk = '1') then
		if (enable = '1') then
			sum_sig <= sum;
		end if;
	end if;
END PROCESS convert;

end beh;