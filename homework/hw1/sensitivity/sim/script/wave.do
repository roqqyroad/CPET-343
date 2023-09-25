onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group test1 /sensitivity_tb/a
add wave -noupdate -expand -group test1 -color {Medium Violet Red} /sensitivity_tb/b
add wave -noupdate -expand -group test1 /sensitivity_tb/s
add wave -noupdate -expand -group test1 /sensitivity_tb/c
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {13 ns}
