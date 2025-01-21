# Setting some variables
set(testbench "regs_tb")
set(top "regs")

list(APPEND sources_sim "${CMAKE_CURRENT_SOURCE_DIR}/regs.sv" "${CMAKE_CURRENT_SOURCE_DIR}/regs_tb.sv")
list(APPEND sources_synth "${CMAKE_CURRENT_SOURCE_DIR}/regs.sv")

# Generate the targets
add_simulation(${testbench}, "${sources_sim}")
add_synthesis(${top}, "${sources_synth}")
add_pr(${top})
add_bitstream(${top})
add_flash(${top})
