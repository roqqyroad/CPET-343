vlib work
vcom -93 -work work ../../src/prop_delay.vhd
vcom -93 -work work ../src/prop_delay_tb.vhd
vsim -voptargs=+acc prop_delay_tb
do wave.do
run 10 ns
