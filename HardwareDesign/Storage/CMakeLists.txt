# Define the name for the targets (must be unambiguous)
set(name "Storage")

# Define variables for simulation
set(testbench "top")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_tb.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_reader_top.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_reader.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_controller_test.sv
)
set(top "top_ulx3s_sd_mem")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_reader_top.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_reader.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sd_card_controller.sv
)
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
