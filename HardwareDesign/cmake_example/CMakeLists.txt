# Defining variables for simulation
set(testbench "regs_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/regs_tb.sv
)

# Defining variables for synthesis
set(top "regs")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
)

# Generating the targets
add_simulation(${testbench}, "${sources_sim}")

add_synthesis(${top}, "${sources_synth}")
add_pr(${top})
add_bitstream(${top})
add_flash(${top})
add_upload(${top})
