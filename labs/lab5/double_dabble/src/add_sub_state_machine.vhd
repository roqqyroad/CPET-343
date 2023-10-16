-------------------------------------------------------------------------------
-- Rachel DuBois
-- adder and subtractor state machine
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity add_sub_state_machine is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    switch        : in  std_logic_vector(7 downto 0);
    btn           : in  std_logic; --keep track of the button presses to progress the state machine 
    led      : out std_logic_vector(3 downto 0);
    bcd_0    : out std_logic_vector(6 downto 0);
    bcd_1    : out std_logic_vector(6 downto 0);
    bcd_2    : out std_logic_vector(6 downto 0);
    bcd_3    : out std_logic_vector(6 downto 0);
    bcd_4    : out std_logic_vector(6 downto 0);
    bcd_5    : out std_logic_vector(6 downto 0)
  );
end entity add_sub_state_machine;

architecture beh of add_sub_state_machine is


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