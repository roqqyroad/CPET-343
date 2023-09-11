-------------------------------------------------------------------------------
-- Rachel DuBois 
-- EDITED single bit full adder [structural]
-- Initial code for single bit full adder behavioral from Dr. K.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     

entity full_adder_single_bit_struct is 
  port (

    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;

    sum     : out std_logic;
    cout    : out std_logic

  );
end full_adder_single_bit_struct;

architecture structural of full_adder_single_bit_struct is

  --COMPONENTS--

  --AND COMPONENT
  component alu_and
    port(
      a : in std_logic;
      b : in std_logic;
      c : out std_logic;
    );
  end component;

  --OR COMPONENT
  component alu_or
    port(
      a : in std_logic;
      b : in std_logic;
      c : out std_logic;
    );
  end component;

  --XOR COMPONENT
  component alu_xor
    port(
      a : in std_logic;
      b : in std_logic;
      c : out std_logic;
    );
  end component;

  --END COMPONENTS--

  --SIGNALS--

  signal temp1 : std_logic;
  signal temp2 : std_logic;
  signal temp3 : std_logic;
  signal temp4 : std_logic;
  signal temp5 : std_logic;

  --END SIGNALS--

begin 

  and1_inst : alu_and
    port map (

    );

end structural; 