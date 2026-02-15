# Target definition for subdirectories
function(add_simulation_with_resources
    name, testbench, sources, resources)

  cmake_parse_arguments(
    PARSE_ARGV
    0
    arg # prefix of output variables
    "" # list of names of the boolean arguments (only defined ones will be true)
    "NAME;TESTBENCH" # list of names of mono-valued arguments
    "SOURCES;RESOURCES" # list of names of multi-valued arguments (output variables are lists)
  )

  list(JOIN arg_SOURCES " " sources_var)
  add_custom_command(OUTPUT ${arg_NAME}.out
    DEPENDS ${arg_SOURCES}
    COMMAND iverilog
            -DSTARTSCREEN_PATH=${CMAKE_SOURCE_DIR}/HardwareDesignGraphicsystem/StartScreen.hex
            -DBOOTLOADER_PATH=${CMAKE_BINARY_DIR}/Software/Bootloader/Bootloader.hex
            -g2012 -s ${arg_TESTBENCH} -o ${CMAKE_CURRENT_BINARY_DIR}/${arg_NAME}.out ${sources_var}
  )

  # Copy all resources to the binary dir
  foreach(resource ${arg_RESOURCES})
    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${resource}
      DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${resource}

      COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/${resource}
      ${CMAKE_CURRENT_BINARY_DIR}/${resource}
    )
    list(APPEND resources_list ${CMAKE_CURRENT_BINARY_DIR}/${resource})
  endforeach()

  add_custom_target(${arg_NAME}_simulation
    DEPENDS ${arg_NAME}.out
    DEPENDS ${resources_list}

    COMMAND vvp ${CMAKE_CURRENT_BINARY_DIR}/${arg_NAME}.out -lxt2
  )

endfunction()

function(add_simulation
    name, testbench, sources)
  add_simulation_with_resources(
    NAME "${name}"
    TESTBENCH "${testbench}"
    SOURCES "${sources}"
    RESOURCES ""
  )
endfunction()

function(add_synthesis
    name, top, sources)
  # Synthesis
  add_custom_command(OUTPUT ${name}.json
    DEPENDS ${sources}
    COMMAND yosys
            -DSTARTSCREEN_PATH=${CMAKE_SOURCE_DIR}/HardwareDesign/Graphicsystem/StartScreen.hex
            -DBOOTLOADER_PATH=${CMAKE_BINARY_DIR}/Software/Bootloader/Bootloader.hex
            -p \"synth_ecp5 -top ${top}\; write_json ${CMAKE_CURRENT_BINARY_DIR}/${name}.json\" ${sources}
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
