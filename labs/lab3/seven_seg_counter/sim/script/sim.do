vlib work
vcom -93 -quiet -work work ../../src/generic_adder_beh.vhd
vcom -93 -quiet -work work ../../src/generic_counter.vhd
vcom -93 -quiet -work work ../../src/bcd2seven_seg.vhd
vcom -93 -quiet -work work ../../src/seven_seg_counter.vhd
vcom -93 -quiet -work work ../src/seven_seg_counter_tb.vhd
vsim -voptargs=+acc -msgmode both seven_seg_counter_tb
do wave.do
run -all