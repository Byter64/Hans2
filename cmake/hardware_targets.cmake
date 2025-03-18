# Target definition for subdirectories
function(add_simulation
    name, testbench, sources)
  add_custom_command(OUTPUT ${name}.out
    DEPENDS ${sources}
    COMMAND iverilog -g2012 -s ${testbench} -o ${CMAKE_CURRENT_BINARY_DIR}/${name}.out ${sources}
  )

  add_custom_target(${name}_simulation
    DEPENDS ${name}.out
    COMMAND vvp ${CMAKE_CURRENT_BINARY_DIR}/${name}.out -lxt2
  )
endfunction()

function(add_synthesis
    name, top, sources)
  # Synthesis
  add_custom_command(OUTPUT ${name}.json
    DEPENDS ${sources}
    # COMMAND yosys -m slang -f "slang --ignore-unknown-modules" -p \"synth_ecp5 -top ${top}\; write_json ${CMAKE_CURRENT_BINARY_DIR}/${name}.json\" ${sources}
    COMMAND yosys -p \"synth_ecp5 -top ${top}\; write_json ${CMAKE_CURRENT_BINARY_DIR}/${name}.json\" ${sources}
  )

  add_custom_target(${name}_synthesis
    DEPENDS ${name}.json
  )

  # Place and route
  add_custom_command(OUTPUT ${name}.config
    DEPENDS ${name}.json
    DEPENDS ulx3s.lpf

    COMMAND nextpnr-ecp5 --85k --package CABGA381 --lpf ${CMAKE_CURRENT_SOURCE_DIR}/ulx3s.lpf --lpf-allow-unconstrained --json ${CMAKE_CURRENT_BINARY_DIR}/${name}.json --textcfg ${CMAKE_CURRENT_BINARY_DIR}/${name}.config
  )

  add_custom_target(${name}_pr
    DEPENDS ${name}.config
  )

  # Bitstream
  add_custom_command(OUTPUT ${name}.bit
    DEPENDS ${name}.config

    COMMAND ecppack ${CMAKE_CURRENT_BINARY_DIR}/${name}.config ${CMAKE_CURRENT_BINARY_DIR}/${name}.bit
  )

  add_custom_target(${name}_bitstream
    DEPENDS ${name}.bit
  )

  # Upload targets
  add_custom_target(${name}_upload
    DEPENDS ${name}.bit
    COMMAND fujprog ${CMAKE_CURRENT_BINARY_DIR}/${name}.bit
  )

  add_custom_target(${name}_flash
    DEPENDS ${name}.bit
    COMMAND fujprog -j flash ${CMAKE_CURRENT_BINARY_DIR}/${name}.bit
  )
endfunction()
