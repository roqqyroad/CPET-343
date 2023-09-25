vlib work
vcom -93 -work work ../../src/sequential.vhd
vcom -93 -work work ../../src/concurrent.vhd
vcom -93 -work work ../src/concurrency_tb.vhd
vsim -voptargs=+acc concurrency_tb
do wave.do
run 10 ns
