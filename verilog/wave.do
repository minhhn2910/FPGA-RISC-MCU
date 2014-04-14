onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_RISC_SPM/M2/clk
add wave -noupdate /test_RISC_SPM/M2/rst
add wave -noupdate /test_RISC_SPM/M2/zero
add wave -noupdate /test_RISC_SPM/M2/instruction
add wave -noupdate /test_RISC_SPM/M2/Bus_1a
add wave -noupdate /test_RISC_SPM/M2/Bus_1b
add wave -noupdate /test_RISC_SPM/M2/Load_R0
add wave -noupdate /test_RISC_SPM/M2/Load_R1
add wave -noupdate /test_RISC_SPM/M2/Load_R2
add wave -noupdate /test_RISC_SPM/M2/Load_R3
add wave -noupdate /test_RISC_SPM/M2/Load_PC
add wave -noupdate /test_RISC_SPM/M2/Inc_PC
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Bus_2
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/R0_out
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/R1_out
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/R2_out
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/R3_out
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/PC_count
add wave -noupdate /test_RISC_SPM/M2/M1_Controller/state
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/mux_out
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/data_a
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/data_b
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/data_c
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/data_d
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/data_e
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/Mux_2/sel
add wave -noupdate /test_RISC_SPM/M2/M0_Processor/alu_out
add wave -noupdate {/test_RISC_SPM/M2/M2_SRAM/memory[112]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161 ps} 0}
configure wave -namecolwidth 293
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {952 ps} {1187 ps}
