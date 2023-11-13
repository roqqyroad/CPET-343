vlib work
vcom -93 -quiet -work work ../../src/generic_adder_beh.vhd
vcom -93 -quiet -work work ../../src/generic_subtractor_beh.vhd
vcom -93 -quiet -work work ../../src/double_dabble.vhd
vcom -93 -quiet -work work ../../src/edge_detect.vhd
vcom -93 -quiet -work work ../../src/bcd2seven_seg.vhd
vcom -93 -quiet -work work ../../src/clock_synchronizer.vhd
vcom -93 -quiet -work work ../../src/add_sub.vhd
vcom -93 -quiet -work work ../src/add_sub_tb.vhd
vsim -voptargs=+acc -msgmode both add_sub_tb
do wave.do
run -all