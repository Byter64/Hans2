set(name "counter")
# Defining variables for simulation
set(testbench "counter_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/counter.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/counter_tb.sv
)

# Defining variables for synthesis
set(top "counter")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/counter.sv
)

# Generating the targets
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
