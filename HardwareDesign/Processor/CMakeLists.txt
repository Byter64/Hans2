# Defining variables for synthesis
set(name "processor")
set(top "picorv32")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/picorv32.v
)

# Generating the targets
add_synthesis(${name}, ${top}, "${sources_synth}")
