LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE seven_seg_pkg IS
  COMPONENT seven_seg IS   
    PORT (
      enable          : IN STD_LOGIC;
      bcd             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      seven_seg_out   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
  END COMPONENT seven_seg;
  
  CONSTANT ZERO_c   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000";
  CONSTANT ONE_c    : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
  CONSTANT TWO_c    : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";
  CONSTANT THREE_c  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
  CONSTANT FOUR_c   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011001";
  CONSTANT FIVE_c   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
  CONSTANT SIX_c    : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000010";
  CONSTANT SEVEN_c  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111000";
  CONSTANT EIGHT_c  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
  CONSTANT NINE_c   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011000";
  CONSTANT A_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001000";
  CONSTANT B_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000011";
  CONSTANT C_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000110";
  CONSTANT D_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100001";
  CONSTANT E_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110";
  CONSTANT F_c      : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001110";
  CONSTANT EMPTY_c  : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
END PACKAGE seven_seg_pkg;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
use work.seven_seg_pkg.ALL;

ENTITY seven_seg IS
  PORT (
    enable          : IN STD_LOGIC;
    bcd             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    seven_seg_out   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END ENTITY seven_seg;

ARCHITECTURE behave OF seven_seg IS

BEGIN

  PROCESS(bcd, enable)
  BEGIN
    IF(enable = '1') THEN
      CASE bcd IS
        WHEN x"0" => seven_seg_out <= ZERO_c;
        WHEN x"1" => seven_seg_out <= ONE_c;
        WHEN x"2" => seven_seg_out <= TWO_c;
        WHEN x"3" => seven_seg_out <= THREE_c;
        WHEN x"4" => seven_seg_out <= FOUR_c;
        WHEN x"5" => seven_seg_out <= FIVE_c;
        WHEN x"6" => seven_seg_out <= SIX_c;
        WHEN x"7" => seven_seg_out <= SEVEN_c;
        WHEN x"8" => seven_seg_out <= EIGHT_c;
        WHEN x"9" => seven_seg_out <= NINE_c;
        WHEN x"A" => seven_seg_out <= A_c;
        WHEN x"B" => seven_seg_out <= B_c;
        WHEN x"C" => seven_seg_out <= C_c;
        WHEN x"D" => seven_seg_out <= D_c;
        WHEN x"E" => seven_seg_out <= E_c;
        WHEN x"F" => seven_seg_out <= F_c;
        WHEN OTHERS => seven_seg_out <= EMPTY_c;
      END CASE;
    ELSE
      seven_seg_out <= EMPTY_c;
    END IF;
  END PROCESS;
  
END ARCHITECTURE behave;