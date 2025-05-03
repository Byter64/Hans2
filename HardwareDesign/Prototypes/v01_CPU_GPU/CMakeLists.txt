# Define the name for the targets (must be unambiguous)
set(name "prot1")

# Defining variables for simulation
set(testbench "testbench")

list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/testbench.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/v01_CPU_GPU.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/picorv32.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GPU.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GraphicSystem.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Controller/controller.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../AxiLiteMemory.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_addr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_rd.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_wr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/arbiter.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_register_rd.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_register_wr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/priority_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../ecp5u/EHXPLLL.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../ecp5u/ODDRX1F.v
)

# Defining variables for synthesis
set(top "CPU_with_GPU")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/v01_CPU_GPU.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/picorv32.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GPU.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GraphicSystem.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Controller/controller.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/AxiLiteInterconnect.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/arbiter.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/priority_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../AxiLiteMemory.sv
)

# Generating the targets
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
