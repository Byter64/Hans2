# controller_test.v
set(name "controller")
set(top "cont_test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/controller_test.v
)

add_synthesis(${name}, ${top}, "${sources_synth}")
unset(sources_synth)

# NMOS_test.v
set(name "nmos_test")
set(top "nmos_test")
list(APPEND sources_synth
  ${CMAKE_CURRENT_SOURCE_DIR}/NMOS_test.v
)

add_synthesis(${name}, ${top}, "${sources_synth}")
