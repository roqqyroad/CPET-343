onerror {resume}
radix define States {
    "7'b1111111" "EMPTY" -color "red",
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b0001000" "A" -color "red",
    "7'b0000011" "B" -color "red",
    "7'b1000110" "C" -color "red",
    "7'b0100001" "D" -color "red",
    "7'b0000110" "E" -color "red",
    "7'b0001110" "F" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate /top_tb/sw_combined_tb
add wave -noupdate /top_tb/clk_tb
add wave -noupdate /top_tb/desired_op_tb
add wave -noupdate -radix unsigned /top_tb/sw_tb
add wave -noupdate /top_tb/key_tb
add wave -noupdate /top_tb/led_tb
add wave -noupdate -radix States /top_tb/hex2_tb
add wave -noupdate -radix States /top_tb/hex1_tb
add wave -noupdate -radix States /top_tb/hex0_tb
add wave -noupdate /top_tb/sim_done
add wave -noupdate /top_tb/reset_tb
add wave -noupdate /top_tb/mr_tb
add wave -noupdate /top_tb/ms_tb
add wave -noupdate /top_tb/execute_tb
add wave -noupdate -divider UUT
add wave -noupdate /top_tb/UUT/CLOCK_50
add wave -noupdate /top_tb/UUT/SW
add wave -noupdate /top_tb/UUT/KEY
add wave -noupdate /top_tb/UUT/LEDR
add wave -noupdate -radix States /top_tb/UUT/HEX2
add wave -noupdate -radix States /top_tb/UUT/HEX1
add wave -noupdate -radix States /top_tb/UUT/HEX0
add wave -noupdate /top_tb/UUT/sw_sync
add wave -noupdate /top_tb/UUT/key_sync
add wave -noupdate /top_tb/UUT/execute
add wave -noupdate /top_tb/UUT/ms
add wave -noupdate /top_tb/UUT/mr
add wave -noupdate /top_tb/UUT/reset_n
add wave -noupdate /top_tb/UUT/reset
add wave -noupdate /top_tb/UUT/mem_addr
add wave -noupdate /top_tb/UUT/mem_write_en
add wave -noupdate /top_tb/UUT/en_result_reg
add wave -noupdate -radix unsigned /top_tb/UUT/result
add wave -noupdate /top_tb/UUT/desired_op
add wave -noupdate -radix unsigned /top_tb/UUT/input_num
add wave -noupdate -divider {SW Clk Sync}
add wave -noupdate /top_tb/UUT/sw_clk_sync/clk
add wave -noupdate /top_tb/UUT/sw_clk_sync/reset_n
add wave -noupdate /top_tb/UUT/sw_clk_sync/async_in
add wave -noupdate /top_tb/UUT/sw_clk_sync/sync_out
add wave -noupdate /top_tb/UUT/sw_clk_sync/prev_data_1
add wave -noupdate /top_tb/UUT/sw_clk_sync/prev_data_2
add wave -noupdate -divider FSM
add wave -noupdate /top_tb/UUT/state_machine/clock
add wave -noupdate /top_tb/UUT/state_machine/reset_n
add wave -noupdate /top_tb/UUT/state_machine/exe_en
add wave -noupdate /top_tb/UUT/state_machine/ms_en
add wave -noupdate /top_tb/UUT/state_machine/mr_en
add wave -noupdate /top_tb/UUT/state_machine/led_state
add wave -noupdate /top_tb/UUT/state_machine/load_saved_data
add wave -noupdate /top_tb/UUT/state_machine/en_result_reg
add wave -noupdate /top_tb/UUT/state_machine/mem_addr
add wave -noupdate /top_tb/UUT/state_machine/mem_write_en
add wave -noupdate /top_tb/UUT/state_machine/curr_state
add wave -noupdate /top_tb/UUT/state_machine/next_state
add wave -noupdate -divider RAM
add wave -noupdate /top_tb/UUT/RAM/clk
add wave -noupdate /top_tb/UUT/RAM/we
add wave -noupdate /top_tb/UUT/RAM/addr
add wave -noupdate -radix unsigned /top_tb/UUT/RAM/din
add wave -noupdate -radix unsigned /top_tb/UUT/RAM/dout
add wave -noupdate -radix unsigned /top_tb/UUT/RAM/RAM
add wave -noupdate -divider MUX
add wave -noupdate /top_tb/UUT/load_saved_data
add wave -noupdate -radix unsigned /top_tb/UUT/mem_data_out
add wave -noupdate -radix unsigned /top_tb/UUT/result_reg_inp
add wave -noupdate -radix unsigned /top_tb/UUT/alu_result
add wave -noupdate -divider {Calc Unit}
add wave -noupdate /top_tb/UUT/calc_unit/clk
add wave -noupdate /top_tb/UUT/calc_unit/reset
add wave -noupdate -radix unsigned /top_tb/UUT/calc_unit/a
add wave -noupdate -radix unsigned /top_tb/UUT/calc_unit/b
add wave -noupdate /top_tb/UUT/calc_unit/op
add wave -noupdate -radix unsigned /top_tb/UUT/calc_unit/result
add wave -noupdate -radix unsigned -radixshowbase 1 /top_tb/UUT/calc_unit/result_temp
add wave -noupdate -divider {Three Digit Disp}
add wave -noupdate /top_tb/UUT/disp/reset_n
add wave -noupdate /top_tb/UUT/disp/clk
add wave -noupdate /top_tb/UUT/disp/input
add wave -noupdate -radix States /top_tb/UUT/disp/hundreds
add wave -noupdate -radix States /top_tb/UUT/disp/tens
add wave -noupdate -radix States /top_tb/UUT/disp/ones
add wave -noupdate /top_tb/UUT/disp/hundreds_bcd
add wave -noupdate /top_tb/UUT/disp/tens_bcd
add wave -noupdate /top_tb/UUT/disp/ones_bcd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {600941 ps} 0} {{Cursor 2} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 178
configure wave -valuecolwidth 94
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {808652 ps}