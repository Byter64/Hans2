# Target definition for subdirectories
function(add_simulation testbench, sources)
  add_custom_command(OUTPUT ${testbench}.out
    DEPENDS ${sources}
    COMMAND iverilog -g2012 -s ${testbench} -o ${CMAKE_CURRENT_BINARY_DIR}/${testbench}.out ${sources}
  )

  add_custom_target(${testbench}_simulation
    DEPENDS ${testbench}.out
    COMMAND vvp ${CMAKE_CURRENT_BINARY_DIR}/${testbench}.out -lxt2
  )
endfunction()

function(add_synthesis top, sources)
  add_custom_command(OUTPUT ${top}.json
    DEPENDS ${sources}
    COMMAND yosys -m slang -f slang -p \"synth_ecp5 -top ${top}\; write_json ${CMAKE_CURRENT_BINARY_DIR}/${top}.json\" ${sources}
  )

  add_custom_target(${top}_synthesis
    DEPENDS ${top}.json
  )
endfunction()

function(add_pr top)
  add_custom_command(OUTPUT ${top}.config
    DEPENDS ${top}.json
    DEPENDS ulx3s.lpf

    COMMAND nextpnr-ecp5 --85k --package CABGA381 --lpf ${CMAKE_CURRENT_SOURCE_DIR}/ulx3s.lpf --lpf-allow-unconstrained --json ${CMAKE_CURRENT_BINARY_DIR}/${top}.json --textcfg ${CMAKE_CURRENT_BINARY_DIR}/${top}.config
  )

  add_custom_target(${top}_pr
    DEPENDS ${top}.config
  )
endfunction()

function(add_bitstream top)
  add_custom_command(OUTPUT ${top}.bit
    DEPENDS ${top}.config

    COMMAND ecppack ${CMAKE_CURRENT_BINARY_DIR}/${top}.config ${CMAKE_CURRENT_BINARY_DIR}/${top}.bit
  )

  add_custom_target(${top}_bitstream
    DEPENDS ${top}.bit
  )
endfunction()

function(add_upload top)
  add_custom_target(${top}_upload
    COMMAND fujprog ${CMAKE_CURRENT_BINARY_DIR}/${top}.bit
  )
endfunction()

function(add_flash top)
  add_custom_target(${top}_flash
    COMMAND fujprog -j flash ${CMAKE_CURRENT_BINARY_DIR}/${top}.bit
  )
endfunction()
