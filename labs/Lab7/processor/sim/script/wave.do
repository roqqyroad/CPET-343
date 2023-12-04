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
    "7'b0001000" "A" -color "red",
    "7'b0000011" "B" -color "red",
    "7'b1000110" "C" -color "red",
    "7'b0100001" "D" -color "red",
    "7'b0000110" "E" -color "red",
    "7'b0001110" "F" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /processor_tb/sim_done
add wave -noupdate -expand -group TB /processor_tb/pb_exec_tb
add wave -noupdate -expand -group TB /processor_tb/clk_tb
add wave -noupdate -expand -group TB /processor_tb/reset_tb
add wave -noupdate -expand -group TB -radix States /processor_tb/bcd2_tb
add wave -noupdate -expand -group TB -radix States /processor_tb/bcd1_tb
add wave -noupdate -expand -group TB -radix States /processor_tb/bcd0_tb
add wave -noupdate -divider UUT
add wave -noupdate /processor_tb/UUT/pb_exec
add wave -noupdate /processor_tb/UUT/clk
add wave -noupdate /processor_tb/UUT/reset
add wave -noupdate /processor_tb/UUT/bcd2
add wave -noupdate /processor_tb/UUT/bcd1
add wave -noupdate /processor_tb/UUT/bcd0
add wave -noupdate /processor_tb/UUT/Led
add wave -noupdate /processor_tb/UUT/pb_exec_sync
add wave -noupdate /processor_tb/UUT/execute_instr_en
add wave -noupdate /processor_tb/UUT/address_bus
add wave -noupdate /processor_tb/UUT/decode_instr_en
add wave -noupdate /processor_tb/UUT/pseudo_exe_pb_n
add wave -noupdate /processor_tb/UUT/pseudo_ms_pb_n
add wave -noupdate /processor_tb/UUT/pseudo_mr_pb_n
add wave -noupdate /processor_tb/UUT/pseudo_operand
add wave -noupdate /processor_tb/UUT/pseudo_mode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {883 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 77
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
WaveRestoreZoom {0 ns} {6714 ns}
