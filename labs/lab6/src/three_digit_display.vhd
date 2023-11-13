LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE three_digit_display_pkg IS
  COMPONENT three_digit_display IS 
    PORT (
      reset_n         : IN  std_logic;
      clk             : IN  std_logic;
      input           : IN  std_logic_vector(11 downto 0);
      --
      ones            : OUT std_logic_vector(6 downto 0);
      tens            : OUT std_logic_vector(6 downto 0);
      hundreds        : OUT std_logic_vector(6 downto 0)
    );
  END COMPONENT;
END PACKAGE three_digit_display_pkg;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.seven_seg_pkg.ALL;

ENTITY three_digit_display IS
  PORT (
    reset_n         : IN  std_logic;
    clk             : IN  std_logic;
    input           : IN  std_logic_vector(11 downto 0);
    --
    ones            : OUT std_logic_vector(6 downto 0);
    tens            : OUT std_logic_vector(6 downto 0);
    hundreds        : OUT std_logic_vector(6 downto 0)
  );
END ENTITY three_digit_display;

ARCHITECTURE behave OF three_digit_display IS
  
  SIGNAL ones_bcd       : std_logic_vector(3 downto 0) := (others => '0');
  SIGNAL tens_bcd       : std_logic_vector(3 downto 0) := (others => '0');
  SIGNAL hundreds_bcd   : std_logic_vector(3 downto 0) := (others => '0');
  
BEGIN

  disp0 : seven_seg
    PORT MAP (
      enable => '1',
      bcd => ones_bcd,
      seven_seg_out => ones
    );
    
  disp2 : seven_seg
    PORT MAP (
      enable => '1',
      bcd => tens_bcd,
      seven_seg_out => tens
    );
    
  disp4 : seven_seg
    PORT MAP (
      enable => '1',
      bcd => hundreds_bcd,
      seven_seg_out => hundreds
    );

  PROCESS(reset_n, clk) IS
  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  
  -- variable to store the output BCD number
  -- organized as follows
  -- thousands = bcd(15 downto 12)
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');
  BEGIN
    IF(reset_n = '0') THEN
      ones_bcd <= (others => '1');
      tens_bcd <= (others => '1');
      hundreds_bcd <= (others => '1');
    ELSIF(rising_edge(clk)) THEN
      -- zero the bcd variable
      bcd := (others => '0');
      
      -- read input into temp variable
      temp(11 downto 0) := input;
      
      -- cycle 12 times as we have 12 input bits
      -- this could be optimized, we dont need to check and add 3 for the 
      -- first 3 iterations as the number can never be >4
      for i in 0 to 11 loop
        if bcd(3 downto 0) > 4 then 
          bcd(3 downto 0) := bcd(3 downto 0) + 3;
        end if;
        
        if bcd(7 downto 4) > 4 then 
          bcd(7 downto 4) := bcd(7 downto 4) + 3;
        end if;
      
        if bcd(11 downto 8) > 4 then  
          bcd(11 downto 8) := bcd(11 downto 8) + 3;
        end if;

        -- thousands can't be >4 for a 12-bit input number
        -- so don't need to do anything to upper 4 bits of bcd
      
        -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
        bcd := bcd(14 downto 0) & std_logic(temp(11));
      
        -- shift temp left by 1 bit
        temp := temp(10 downto 0) & '0';
      
      end loop;
   
      -- set outputs
      ones_bcd <= STD_LOGIC_VECTOR(bcd(3 downto 0));
      tens_bcd <= STD_LOGIC_VECTOR(bcd(7 downto 4));
      hundreds_bcd <= STD_LOGIC_VECTOR(bcd(11 downto 8));
      --thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));
    END IF;
  END PROCESS;

END ARCHITECTURE behave;