# Define the name for the targets (must be unambiguous)
set(name "prot7")

# Defining variables for simulation
set(testbench "testbench")

list(APPEND sources_all
  ${CMAKE_CURRENT_SOURCE_DIR}/Top.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/AXILiteMemory.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/mkaxi2axil_bridge.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/FIFO2.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_addr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_rd.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_crossbar_wr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/arbiter.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_register_rd.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/axil_register_wr.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../AXI/verilog-axi-master/rtl/priority_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/VexRiscvAxiLite.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Processor/VexRiscvAxi4.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../pll/ecp5pll.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/BufferController.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/Framebuffer.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GPU2.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/GraphicSystem.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/HDMI_Out.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Graphicsystem/ULX3S_hdmi/TMDS_encoder.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../SDRAM-Controller/AXILite_SDRAM.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../SDRAM-Controller/core_sdram_axi4-master/src_v/sdram_axi.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../SDRAM-Controller/core_sdram_axi4-master/src_v/sdram_axi_core.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../SDRAM-Controller/core_sdram_axi4-master/src_v/sdram_axi_pmem.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Storage/sd_card_reader.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Controller/controller.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Counter/counter.sv
  
)

list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/testbench.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/../../ecp5u/EHXPLLL.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../ecp5u/ODDRX1F.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../SDRAM-Controller/42s16160.v
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Storage/sd_card_controller_test.sv
  ${sources_all}
)

# Defining variables for synthesis
set(top "Top")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/../../Storage/sd_card_controller.sv  
  ${sources_all}
)

# Generating the targets
add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
