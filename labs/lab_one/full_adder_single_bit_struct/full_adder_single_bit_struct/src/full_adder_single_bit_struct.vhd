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
      c : out std_logic
    );
  end component;

  --OR COMPONENT
  component alu_or
    port(
      a : in std_logic;
      b : in std_logic;
      c : out std_logic
    );
  end component;

  --XOR COMPONENT
  component alu_xor
    port(
      a : in std_logic;
      b : in std_logic;
      c : out std_logic
    );
  end component;

  --END COMPONENTS--

  --SIGNALS--

  signal temp1 : std_logic; --Used with and1_instance output and or1_instance input
  signal temp2 : std_logic; --Used with and2_instance output and or1_instance input
  signal temp3 : std_logic; --Used with and3_instance output and or2_instance input
  signal temp4 : std_logic; --Used with or1_instance output and or2_instance input
  signal temp5 : std_logic; --Used with xor1_instance output and xor2_instance input

  --END SIGNALS--

begin 

  --Top half of logic circuit design...
  and1_instance : alu_and
    port map (

      a => a,
      b => b,
      c => temp1

    );

  and2_instance : alu_and
    port map (

      a => b,
      b => cin,
      c => temp2

    );

  and3_instance : alu_and
    port map (

    a => a,
    b => cin,
    c => temp3

    );

  or1_instance : alu_or
    port map (

      a => temp1,
      b => temp2,
      c => temp4
    );
  
  or2_instance : alu_or
    port map (

      a => temp3,
      b => temp4,
      c => cout

    );

  --Bottom half of circuit design...
  xor1_instance : alu_xor
    port map (

      a => a,
      b => b,
      c => temp5

    );
  
  xor2_instance : alu_xor
    port map (

      a => temp5,
      b => cin,
      c => sum

    );

end structural; 