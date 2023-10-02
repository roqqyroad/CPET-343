LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity seven_seg_counter is
	Port ( 	clk 	    : in  STD_LOGIC; --Input clock
			offset			: in  STD_LOGIC_VECTOR(3 downto 0) := "0001";
			reset			: in  STD_LOGIC;
			--
			seven_seg_outp	    : out STD_LOGIC_VECTOR(6 downto 0)  --7-seg display outputs (g to a) for 7seg display
			); 
end seven_seg_counter;

architecture count of seven_seg_counter is --created implementation

signal sum 		: std_logic_vector(3 downto 0) := "0000";
signal sum_sig 	: std_logic_vector(3 downto 0) := "0000";
signal enable 	: std_logic;


component seven_seg is
	port (
		clk                : in  std_logic;
		reset              : in std_logic;
	  bcd           : in  std_logic_vector(3 downto 0);
	  seven_seg_out          : out std_logic_vector(6 downto 0)
	);  
  end component; 


  component generic_counter is
	port (
	  clk             : in  std_logic; 
	  reset           : in  std_logic;
	  output          : out std_logic
	);  
  end component; 


  component generic_adder_beh is
	port (
	  a             : in  std_logic_vector(3 downto 0); 
	  b           : in  std_logic_vector(3 downto 0);
	  cin : in std_logic;

	  sum : out std_logic_vector(3 downto 0);
	  cout          : out std_logic

	);  
  end component; 

begin


gen_add: generic_adder_beh
	port map(
	  a => offset,
	  b => sum_sig,
	  cin => '0',
	  --
	  sum => sum,
	  cout => open
	);
counter: generic_counter
    generic map(
	  max_count => 5000
	  )
	port map(
	  clk => clk,
	  reset => reset,
	  --
	  output => enable
	);
bdc_convert: seven_seg
port map(	 
	clk => clk,
	reset => reset,
 	bcd => offset,
  	--
  	seven_seg_out => seven_seg_outp
  
);
convert : PROCESS(clk, reset) IS
  BEGIN
    IF (reset = '0') THEN
      enable    <= '0';
	
    IF rising_edge(clk) THEN
      IF (enable = '1') THEN
	    IF(sum = "1010") THEN
		   sum_sig <= "0000";
		   sum <= "0000";
		Else
		   sum_sig <= sum;
		END IF;
      END IF;
    END IF;
	end if;
  END PROCESS convert;

end count;