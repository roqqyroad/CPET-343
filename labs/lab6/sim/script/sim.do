vlib work
vcom -93 -quiet -work work ../../src/clock_synchronizer.vhd
vcom -93 -quiet -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -quiet -work work ../../src/alu.vhd
vcom -93 -quiet -work work ../../src/memory.vhd
vcom -93 -quiet -work work ../../src/seven_seg.vhd
vcom -93 -quiet -work work ../../src/three_digit_display.vhd
vcom -93 -quiet -work work ../../src/fsm.vhd
vcom -93 -quiet -work work ../../src/top.vhd
vcom -93 -quiet -work work ../src/top_tb.vhd
vsim -voptargs=+acc -msgmode both top_tb
do wave.do
run -all