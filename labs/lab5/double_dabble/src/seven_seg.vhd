-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity seven_seg is
  port (
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end seven_seg;  

architecture beh of seven_seg  is

begin

  CONSTANT ZERO_c : std_logic_vector(6 downto 0)  := "1000000";
  CONSTANT ONE_c : std_logic_vector(6 downto 0)   := "1111001";
  CONSTANT TWO_c : std_logic_vector(6 downto 0)   := "0100100";
  CONSTANT THREE_c : std_logic_vector(6 downto 0) := "0110000";
  CONSTANT FOUR_c : std_logic_vector(6 downto 0)  := "0011001";
  CONSTANT FIVE_c : std_logic_vector(6 downto 0)  := "0010010";
  CONSTANT SIX_c : std_logic_vector(6 downto 0)   := "0000010";
  CONSTANT SEVEN_c : std_logic_vector(6 downto 0) := "1111000";
  CONSTANT EIGHT_c : std_logic_vector(6 downto 0) := "0000000";
  CONSTANT NINE_c : std_logic_vector(6 downto 0)  := "0010000";
  CONSTANT A_c : std_logic_vector(6 downto 0)     := "0001000";
  CONSTANT B_c : std_logic_vector(6 downto 0)     := "0000011";
  CONSTANT C_c : std_logic_vector(6 downto 0)     := "1000110";
  CONSTANT D_c : std_logic_vector(6 downto 0)     := "0100001";
  CONSTANT E_c : std_logic_vector(6 downto 0)     := "0000110";
  CONSTANT F_c : std_logic_vector(6 downto 0)     := "0001110";
  CONSTANT BLANK_c : std_logic_vector(6 downto 0) := "1111111";
  
process(bcd)
  begin
    case  bcd is
      when "0000" => seven_segment <= ZERO_c;--0
			when "0001" => seven_segment <= ONE_c;--1
			when "0010" => seven_segment <= TWO_c;--2
			when "0011" => seven_segment <= THREE_c;--3
			when "0100" => seven_segment <= FOUR_c;--4
			when "0101" => seven_segment <= FIVE_c;--5
			when "0110" => seven_segment <= SIX_c;--6
			when "0111" => seven_segment <= SEVEN_c;--7
			when "1000" => seven_segment <= EIGHT_c;--8
			when "1001" => seven_segment <= NINE_c;--9
			when "1010" => seven_segment <= A_c;--A
			when "1011" => seven_segment <= B_c;--b
			when "1100" => seven_segment <= C_c;--C
			when "1101" => seven_segment <= D_c;--d
			when "1110" => seven_segment <= E_c;--E
			when "1111" => seven_segment <= F_c;--F
			--otherwise it is blank
			when others => seven_segment <= BLANK_c;
    end case; 
  end process;
end beh;