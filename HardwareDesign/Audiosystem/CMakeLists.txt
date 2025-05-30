# Define the name for the targets (must be unambiguous)
set(name "audiosystem")

# Define variables for simulation
set(testbench "Test")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/Audiosystem_tb.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Audiosystem_Test.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Audiosystem.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Channel.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/ClockGenerator.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/I2STransmitter.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/AXILiteMemory.sv
)

list(APPEND resources
  8channelTest.hex
  StereoTest.hex
)

# Define variables for synthesis
set(top "Audiosystem_Test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/Audiosystem_Test.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Audiosystem.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/Channel.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/ClockGenerator.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/I2STransmitter.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/AXILiteMemory.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/ecp5pll.sv
)

# Generate the targets from the variables
add_simulation_with_resources(
  NAME ${name}
  TESTBENCH ${testbench}
  SOURCES "${sources_sim}"
  RESOURCES ${resources}
)

add_synthesis(${name}, ${top}, "${sources_synth}")
