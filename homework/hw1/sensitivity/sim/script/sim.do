vlib work
vcom -93 -work work ../../src/sensitivity.vhd
vcom -93 -work work ../src/sensitivity_tb.vhd
vsim -voptargs=+acc sensitivity_tb
do wave.do
run 10 ns