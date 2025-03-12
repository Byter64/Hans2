# Define the name for the targets (must be unambiguous)
set(name "regs")

# Define variables for simulation
set(testbench "regs_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/regs_tb.sv
)

# Define variables for synthesis
set(top "regs")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
)

# Generate the targets from the variables
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
