vlib work
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/pipeline.vhd
vcom -93 -work work ../src/pipeline_tb.vhd
vsim -voptargs=+acc -msgmode both  pipeline_tb
do wave.do
run 500 ns