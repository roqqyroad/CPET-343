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
add wave -noupdate /add_sub_tb/sim_done
add wave -noupdate -radix unsigned /add_sub_tb/a_tb
add wave -noupdate -radix States /add_sub_tb/hexOut_tb
add wave -noupdate -radix States /add_sub_tb/hexA_tb
add wave -noupdate -radix States /add_sub_tb/hexB_tb
add wave -noupdate /add_sub_tb/clk_tb
add wave -noupdate /add_sub_tb/reset_n_tb
add wave -noupdate /add_sub_tb/pb_tb
add wave -noupdate -radix binary /add_sub_tb/led_tb
add wave -noupdate -divider UUT
add wave -noupdate /add_sub_tb/UUT/clk_50mhz
add wave -noupdate -radix unsigned /add_sub_tb/UUT/a_in
add wave -noupdate /add_sub_tb/UUT/reset_n
add wave -noupdate /add_sub_tb/UUT/reset_edge
add wave -noupdate /add_sub_tb/UUT/pb_in
add wave -noupdate -radix unsigned /add_sub_tb/UUT/a_reg
add wave -noupdate -radix unsigned /add_sub_tb/UUT/b_reg
add wave -noupdate -radix unsigned /add_sub_tb/UUT/add_reg
add wave -noupdate -radix unsigned /add_sub_tb/UUT/sub_reg
add wave -noupdate -radix unsigned /add_sub_tb/UUT/output
add wave -noupdate /add_sub_tb/UUT/coutSigA
add wave -noupdate /add_sub_tb/UUT/coutSigS
add wave -noupdate /add_sub_tb/UUT/out_12b
add wave -noupdate -radix States /add_sub_tb/UUT/hex2
add wave -noupdate -radix States /add_sub_tb/UUT/hex1
add wave -noupdate -radix States /add_sub_tb/UUT/hex0
add wave -noupdate /add_sub_tb/UUT/ledOut
add wave -noupdate /add_sub_tb/UUT/current_state
add wave -noupdate /add_sub_tb/UUT/next_state
add wave -noupdate /add_sub_tb/UUT/pb_sync
add wave -noupdate -divider sth
add wave -noupdate /add_sub_tb/UUT/pushButton/clock
add wave -noupdate /add_sub_tb/UUT/pushButton/reset_n
add wave -noupdate /add_sub_tb/UUT/pushButton/DataIn
add wave -noupdate /add_sub_tb/UUT/pushButton/RisingEdge
add wave -noupdate /add_sub_tb/UUT/pushButton/FallingEdge
add wave -noupdate /add_sub_tb/UUT/pushButton/PrevDataIn1
add wave -noupdate /add_sub_tb/UUT/pushButton/PrevDataIn2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {798 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {301 ns} {830 ns}