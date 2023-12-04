--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Joshua Massias
--
--       LAB NAME:  Lab 7 calculator
--
--      FILE NAME:  calculator.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--        
--   Claculator that can add, sub, multiply, divide
--
--
-------------------------------------------------------------------------------
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE calculator_pkg IS
  COMPONENT calculator IS    
    PORT (
      B          : IN  std_logic_vector(7 DOWNTO 0); --SW(7:0)
	  mode       : IN  std_logic_vector(1 DOWNTO 0); --SW(9:8)
	  key        : IN  std_logic_vector(2 DOWNTO 0); --key(3:1)            
	  clk        : IN  std_logic;
      reset      : IN  std_logic;   --key(0)  
      -- 
	  bcd2       : OUT  std_logic_vector(6 DOWNTO 0);
      bcd1       : OUT  std_logic_vector(6 DOWNTO 0);
      bcd0       : OUT  std_logic_vector(6 DOWNTO 0)
      );
  END COMPONENT;
END PACKAGE calculator_pkg;



------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.clock_synchronizer_pkg.all;
use work.edge_detect_pkg.all;
use work.Hex2seven_seg_pkg.all;
use work.raminfr_pkg.all;
USE work.common_pkg.ALL;
use work.alu_pkg.all;


ENTITY calculator  IS

  PORT (
      B          : IN  std_logic_vector(7 DOWNTO 0); --SW(7:0)
	  mode       : IN  std_logic_vector(1 DOWNTO 0); --SW(9:8)
	  key        : IN  std_logic_vector(2 DOWNTO 0); --key(3:1)            
	  clk        : IN  std_logic;
      reset      : IN  std_logic;   --key(0)  
      -- 
	  bcd2       : OUT  std_logic_vector(6 DOWNTO 0);
      bcd1       : OUT  std_logic_vector(6 DOWNTO 0);
      bcd0       : OUT  std_logic_vector(6 DOWNTO 0)
    );
END ENTITY calculator ;

ARCHITECTURE behave OF calculator  IS

--signals
SIGNAL data_in_sync     : std_logic_vector(7 DOWNTO 0);
SIGNAL operation_mode   : std_logic_vector(1 DOWNTO 0);
SIGNAL pb_keys_sync     : std_logic_vector(2 DOWNTO 0);
SIGNAL execute_en       : std_logic;
SIGNAL mem_save_en      : std_logic;
SIGNAL mem_restore_en   : std_logic;
SIGNAL memory_data_out  : std_logic_vector(7 DOWNTO 0);
SIGNAL Result_reg       : std_logic_vector(7 DOWNTO 0);
SIGNAL Display_number   : std_logic_vector(11 DOWNTO 0);

--bcd signals
SIGNAL ones             : std_logic_vector(3 DOWNTO 0);
SIGNAL tens             : std_logic_vector(3 DOWNTO 0);
SIGNAL hundreds         : std_logic_vector(3 DOWNTO 0);

--ALU signal
SIGNAL alu_result       : std_logic_vector(7 DOWNTO 0);

--MUX signal
SIGNAL result_reg_input : std_logic_vector(7 DOWNTO 0);

--FSM signals
SIGNAL load_saved_data : std_logic;
SIGNAL result_reg_en   : std_logic;
SIGNAL mem_addr        : std_logic_vector(1 downto 0);
SIGNAL mem_wr_en       : std_logic;
Constant work_reg      : std_logic_vector(1 downto 0) := "00";
Constant save_reg      : std_logic_vector(1 downto 0) := "01";

--signals for state
TYPE TheStates IS (rd_work_reg, rd_save_reg, wr_save_wait, wr_save_reg, wr_work_wait, wr_work_reg); -- 6 states 
SIGNAL present_state : TheStates;
SIGNAL next_state    : TheStates;

  
BEGIN

--Clock sync portmap for B / SW(7:0)
	B_clksync : clock_synchronizer
	Generic map (
	    bit_width => 8
	)
	PORT map (
	    async_in =>  B,
	    clock    => clk,
		reset_n  => reset,
		--
		sync_out => data_in_sync		
    );
-------------------------------------------------

--Clock sync portmap for mode / SW(9:8)
	mode_clksync : clock_synchronizer
	Generic map (
	    bit_width => 2
	)
	PORT map (
	    async_in => mode,
	    clock    => clk,
		reset_n  => reset,
		--
		sync_out => operation_mode		
    );
-------------------------------------------------

--Clock sync portmap for key(3:1) 
	key_clksync : clock_synchronizer
	Generic map (
	    bit_width => 3
	)
	PORT map (
	    async_in => not (key),
	    clock    => clk,
		reset_n  => reset,
		--
		sync_out => pb_keys_sync		
    );
-------------------------------------------------

-- Edge detect portmap for key
	key_edgeDT : edge_detect
	PORT map (
		DataIn      => pb_keys_sync(2),
		clock       => clk,
		reset_n     => reset,
		--
		RisingEdge  => open,
		FallingEdge => execute_en
    );
	
-------------------------------------------------
-- Edge detect portmap for mem_save
	save_edgeDT : edge_detect
	PORT map (
		DataIn      => pb_keys_sync(1),
		clock       => clk,
		reset_n     => reset,
		--
		RisingEdge  => open,
		FallingEdge => mem_save_en
    );
	
-------------------------------------------------
-- Edge detect portmap for mem_restore
	restore_edgeDT : edge_detect
	PORT map (
		DataIn      => pb_keys_sync(0),
		clock       => clk,
		reset_n     => reset,
		--
		RisingEdge  => open,
		FallingEdge => mem_restore_en
    );
	
-------------------------------------------------
--FSM update 
UpdatePresent : PROCESS (clk, reset)
   Begin
		IF (reset = '0') THEN 
			present_state <= rd_work_reg; --first state 
		ELSIF (rising_edge(clk)) THEN
	        present_state <= next_state; 
		END IF;
	END PROCESS UpdatePresent;
	
--FSM process 	
Process(present_state, execute_en, mem_save_en, mem_restore_en)
	Begin 
		CASE (present_state) IS 
			WHEN rd_work_reg => 
			        mem_addr    <= work_reg;
				load_saved_data <= '0';
			    result_reg_en   <= '0';
				mem_wr_en       <= '1';
				IF (execute_en = '1') THEN 
					next_state <= wr_work_wait; 		
				ELSIF (mem_save_en = '1') THEN 
					next_state <= wr_save_reg; 
				ELSIF (mem_restore_en = '1') THEN 
					next_state <= rd_save_reg; 
				ELSE
				    next_state <= rd_work_reg;
				END IF;
		        		
			WHEN rd_save_reg => 
			        mem_addr    <= save_reg;
				load_saved_data <= '1';
			    result_reg_en   <= '0';
				mem_wr_en       <= '1';
			    next_state      <= wr_save_wait;
					
				
     		WHEN wr_save_wait =>
			        mem_addr    <= save_reg;
				load_saved_data <= '1';
			    result_reg_en   <= '1';
				mem_wr_en       <= '1';
                next_state      <= wr_work_reg;
				
				
			WHEN wr_work_wait =>
			        mem_addr    <= work_reg;
				load_saved_data <= '0';
			    result_reg_en   <= '1';
				mem_wr_en       <= '0';
                next_state      <= wr_work_reg;	
				
				
			WHEN wr_work_reg  =>
			        mem_addr    <= work_reg;
				load_saved_data <= '0';
			    result_reg_en   <= '0';	
				mem_wr_en       <= '0';
                next_state      <= rd_work_reg;
				
				
            WHEN wr_save_reg =>
				mem_addr        <= save_reg;
			    load_saved_data <= '0';
			    result_reg_en   <= '0';	
				mem_wr_en       <= '0';
			    next_state      <= rd_work_reg;
			    
				
		END CASE;
END Process;

-------------------------------------------------
--RAM port map 
	Ramin : raminfr
	  GENERIC map (
      addr_width  => 2,
      data_width  => 8
      )
	PORT map (
	
		clock     => clk,
		reset_n   => reset,
		we_n      => mem_wr_en,
        address   => mem_addr,
        din       => Result_reg,
		--
		dout      => memory_data_out 
    );
-------------------------------------------------
--ALU port map 
    ALUport : alu
	PORT map (
		clock     => clk,
		reset_n   => reset,
		op_mode   => operation_mode,
        data_b    => data_in_sync,
        data_a    => memory_data_out,
		--
		result    => alu_result 
    );
-------------------------------------------------
--Mux 
	result_reg_input <= memory_data_out WHEN load_saved_data = '1' ELSE 
						alu_result;	
					
-------------------------------------------------
--Result Register process
Process(clk, reset)
	Begin 
		IF (rising_edge(clk)) THEN
			IF (reset = '0') THEN
					Result_reg <= (others => '0'); 
			ELSIF(result_reg_en = '1') THEN 		
					Result_reg <=  result_reg_input;
			END IF; 
		END IF; 
END Process;
-------------------------------------------------
--Hex2BCD process

Display_number <= x"0" & Result_reg;

hex2bcd: process(Display_number)
  
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  variable bcd  : UNSIGNED (15 downto 0) := (others => '0');

  begin
    bcd := (others => '0');
    temp(11 downto 0) := Display_number;
    
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

      bcd := bcd(14 downto 0) & temp(11);
    
      temp := temp(10 downto 0) & '0';
    
    end loop;
 
   --outputs
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
	
  end process hex2bcd; 

-------------------------------------------------
--Hex2seven_seg portmap
Hex2 : Hex2seven_seg       
  PORT MAP (
	BCD      => hundreds, 
    sevenseg => bcd2 
	  
    );
-------------------------------------------------	
Hex1: Hex2seven_seg       
  PORT MAP (
	BCD      => tens,
    sevenseg => bcd1
	  
    );
-------------------------------------------------	
Hex0 : Hex2seven_seg     
  PORT MAP (
	BCD      => ones,
    sevenseg => bcd0 
	  
    );

END ARCHITECTURE behave;
