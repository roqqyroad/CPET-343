vlib work
vcom -2008 -quiet -work work ../../src/lab6/clock_synchronizer.vhd
vcom -2008 -quiet -work work ../../src/lab6/Hex2seven_seg.vhd
vcom -2008 -quiet -work work ../../src/lab6/edge_detect.vhd
vcom -2008 -quiet -work work ../../src/lab6/raminfr.vhd
vcom -2008 -quiet -work work ../../src/lab6/common.vhd
vcom -2008 -quiet -work work ../../src/lab6/alu.vhd
vcom -2008 -quiet -work work ../../src/lab6/calculator.vhd

vcom -93 -quiet -work work ../../src/ROM/ROM.vhd
vcom -93 -quiet -work work ../../src/delay_register.vhd
vcom -2008 -quiet -work work ../../src/processor.vhd
vcom -93 -quiet -work work ../src/processor_tb.vhd
vsim -voptargs=+acc -msgmode both processor_tb
do wave.do
run -all
