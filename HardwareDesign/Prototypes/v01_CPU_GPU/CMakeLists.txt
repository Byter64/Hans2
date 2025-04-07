# Define the name for the targets (must be unambiguous)
set(name "v01_CPU_GPU")

# Defining variables for simulation
set(testbench "testbench")

list(APPEND sources_sim
  "C:/Users/Yanni/Desktop/ecp5u/EHXPLLL.v"
  "C:/Users/Yanni/Desktop/ecp5u/ODDRX1F.v"
  ${CMAKE_CURRENT_SOURCE_DIR}/testbench.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/picorv32.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GPU.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GraphicSystem.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Controller/controller.sv
)

# Defining variables for synthesis
set(top "CPU_with_GPU")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/v01_CPU_GPU.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/picorv32.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GPU.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GraphicSystem.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Controller/controller.sv
)

# Generating the targets
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
