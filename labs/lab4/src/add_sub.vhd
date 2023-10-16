-------------------------------------------------------------------------------
-- Rachel DuBois
-- Add and subtract 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeroc_std.all;

entity add_sub is
    port(
        clk : in std_logic;
        reset : in std_logic;
        a : in std_logic_vector(2 downto 0);
        b : in std_logic_vector(2 downto 0);
        add_btn : in std_logic; 
        sub_btn : in std_logic; 
        a_bcd : out std_logic_vector(6 downto 0);
        b_bcd : out std_logic_vector(6 downto 0);
        result_bcd : out std_logic_vector(6 downto 0)
    );
end entity add_sub;

