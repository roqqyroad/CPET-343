-------------------------------------------------------------------------------
-- Rachel DuBois
-- seven_seg simulation
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     

entity seven_seg is
  port (
	clk                : in  std_logic;
	reset              : in std_logic;
    bcd                : in  std_logic_vector(3 DownTo 0); 
    seven_seg_out      : out  std_logic_vector(6 DownTo 0)
  );
end seven_seg;

architecture beh of seven_seg  is

begin
	process(reset, bcd)
	begin 
	if(reset = '1') then 
		seven_seg_out <= "1111111"; --blank
	else  
		case bcd is 
			when "0000" => seven_seg_out <= "1000000"; --0
			when "0001" => seven_seg_out <= "1111001"; --1
			when "0010" => seven_seg_out <= "0100100"; --2
			when "0011" => seven_seg_out <= "0110000"; --3
			when "0100" => seven_seg_out <= "0011001"; --4
			when "0101" => seven_seg_out <= "0010010"; --5
			when "0110" => seven_seg_out <= "0000010"; --6
			when "0111" => seven_seg_out <= "1111000"; --7
			when "1000" => seven_seg_out <= "0000000"; --8
			when "1001" => seven_seg_out <= "0011000"; --9
			when others => seven_seg_out <= "0111111"; --used for an error state
		end case;
	end if;
	end process;
end beh;


--process(clk, reset) 
--	begin 
--	if(reset = '1') then 
	
--	elsif(clk'event and clk = '1') then 

	
--	end if;
--end process;