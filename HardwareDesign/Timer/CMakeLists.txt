set(name "timer")
# Defining variables for simulation
set(testbench "Timer_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/Timer.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Timer_tb.sv
)

# Defining variables for synthesis
set(top "Timer")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/Timer.sv
)

# Generating the targets
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
