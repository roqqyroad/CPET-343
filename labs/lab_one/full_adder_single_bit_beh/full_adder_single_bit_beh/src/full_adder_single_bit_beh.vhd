-------------------------------------------------------------------------------
-- Rachel DuBois 
-- EDITED single bit full adder [behavioral]
-- Initial code for single bit full adder behavioral from Dr. K.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity full_adder_single_bit_beh is 
  port (

    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;

    sum     : out std_logic;
    cout    : out std_logic

  );
end full_adder_single_bit_beh;

architecture beh of full_adder_single_bit_beh is

  --SIGNALS--

  signal a_vector : std_logic_vector(1 downto 0);
  signal b_vector : std_logic_vector(1 downto 0);
  signal cin_vector : std_logic_vector(1 downto 0);
  
  signal cout_vector : std_logic_vector(1 downto 0);
  signal outputs_vector : std_logic_vector(1 downto 0);

  --END SIGNALS--

begin 
  
  a_vector <= '0' & a; 
  b_vector <= '0' & b; 
  cin_vector <= '0' & cin;

  --Add the vectors of a, b, and cin to one outputs vector.
  outputs_vector <= std_logic_vector(unsigned(a_vector) + unsigned(b_vector) + unsigned(cin_vector));

  sum  <= outputs_vector(0); --The variable sum gets the first bit of the output vector.
  cout <= outputs_vector(1); --The variable cout gets the second bit of the output vector.

end beh; 