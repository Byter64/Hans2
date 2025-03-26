# ============== Channel ==============
set(name "channel")
set(testbench "main_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/channel_tb.v
  ${CMAKE_CURRENT_SOURCE_DIR}/channel.v
)

set(top "top")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/channel_top.v
  ${CMAKE_CURRENT_SOURCE_DIR}/channel.v
)

add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
unset(sources_sim)
unset(sources_synth)

# ============== Lerper ==============
set(name "lerper")
set(testbench "main_tb")
list(APPEND sources_sim
  ${CMAKE_CURRENT_SOURCE_DIR}/lerper_tb.v
  ${CMAKE_CURRENT_SOURCE_DIR}/lerper.v
)

set(top "lerper")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/lerper.v
)

add_simulation(${name}, ${testbench}, "${sources_sim}")
add_synthesis(${name}, ${top}, "${sources_synth}")
unset(sources_sim)
unset(sources_synth)

# ============== I2S Test ==============
set(name "i2stest")
set(top "I2S_Test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/ecp5pll.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/I2S_test.v
)

add_synthesis(${name}, ${top}, "${sources_synth}")
