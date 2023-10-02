onerror {resume}
radix define States {
    "7'b1111111" "BLANK" -color "red",
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0010000" "9" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /seven_seg_counter_tb/sim_done
add wave -noupdate /seven_seg_counter_tb/offset_tb
add wave -noupdate /seven_seg_counter_tb/hex0
add wave -noupdate /seven_seg_counter_tb/clk_tb
add wave -noupdate /seven_seg_counter_tb/reset_n_tb
add wave -noupdate -radix States /seven_seg_counter_tb/seven_seg_values
add wave -noupdate -divider UUT
add wave -noupdate /seven_seg_counter_tb/UUT/clk_50mhz
add wave -noupdate /seven_seg_counter_tb/UUT/offset
add wave -noupdate /seven_seg_counter_tb/UUT/reset_n
add wave -noupdate -radix States /seven_seg_counter_tb/UUT/seven_seg
add wave -noupdate /seven_seg_counter_tb/UUT/sum
add wave -noupdate /seven_seg_counter_tb/UUT/sum_reg
add wave -noupdate /seven_seg_counter_tb/UUT/enable
add wave -noupdate -divider Counter
add wave -noupdate /seven_seg_counter_tb/UUT/cnt/clock
add wave -noupdate /seven_seg_counter_tb/UUT/cnt/reset_n
add wave -noupdate /seven_seg_counter_tb/UUT/cnt/output
add wave -noupdate /seven_seg_counter_tb/UUT/cnt/count_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {441 ns}