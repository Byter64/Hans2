# Define the name for the targets (must be unambiguous)
set(name "Storage")

# Define variables for simulation
#set(testbench "regs_tb")
#list(APPEND sources_sim
#  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
#  ${CMAKE_CURRENT_SOURCE_DIR}/regs_tb.sv
#)

# Define variables for synthesis
set(top "sd_card_test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_reader.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_test.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/debouncer.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/fifo.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_controller.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../pll/ecp5pll.sv
)

# Generate the targets from the variables
#add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")

# Define the name for the targets (must be unambiguous)
set(name "Storage_Write")

# Define variables for simulation
#set(testbench "regs_tb")
#list(APPEND sources_sim
#  ${CMAKE_CURRENT_SOURCE_DIR}/regs.sv
#  ${CMAKE_CURRENT_SOURCE_DIR}/regs_tb.sv
#)

# Define variables for synthesis
set(top "sd_card_write_test")
list(APPEND sources_synthtest
${CMAKE_CURRENT_SOURCE_DIR}/sd_card_write_test.sv
${CMAKE_CURRENT_SOURCE_DIR}/sd_card_controller.sv
${CMAKE_CURRENT_SOURCE_DIR}/../pll/ecp5pll.sv
)

# Generate the targets from the variables
#add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synthtest}")