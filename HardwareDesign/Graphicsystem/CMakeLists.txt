# Defining variables for simulation
set(name "graphicssystem")
# set(testbench "main_tb")
# list(APPEND sources_sim
#   ${CMAKE_CURRENT_SOURCE_DIR}/GPU.v
#   ${CMAKE_CURRENT_SOURCE_DIR}/gpu_tb.v
# )

# Defining variables for synthesis
set(top "GraphicSystem_Test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/GPU.v
  ${CMAKE_CURRENT_SOURCE_DIR}/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/GraphicSystem.v
  ${CMAKE_CURRENT_SOURCE_DIR}/GraphicSystem_Test.v
)

# Generating the targets
# add_simulation(${name}, ${testbench}, "${sources_sim}")
#add_synthesis(${name}, ${top}, "${sources_synth}")
unset(sources_sim)
unset(sources_synth)
