cmake_minimum_required(VERSION 3.24.0)
project("Hans2")

# Target definition for subdirectories
function(add_simulation testbench, sources)
  # Join internal list structure a;b;c to string a b c
  list(JOIN sources " " sources_var)

  add_custom_command(OUTPUT ${testbench}.out
    DEPENDS ${sources}
    COMMAND "iverilog -g2012 -s ${testbench} -o ${testbench}.out ${sources_var}"
  )

  add_custom_target(${testbench}_simulation
    DEPENDS ${testbench}.out
    COMMAND "vvp ${testbench}.out"
  )
endfunction()

function(add_synthesis top, sources)
  list(JOIN sources " " sources_var)

  add_custom_command(OUTPUT ${top}.json
    DEPENDS ${sources}
    COMMAND "yosys -p \"synth_ecp5 -top ${top}; write_json ${top}.json\" ${sources_var}"
  )

  add_custom_target(${top}_synthesis
    DEPENDS ${top}.json
  )
endfunction()

function(add_pr top)
  add_custom_command(OUTPUT ${top}.config
    DEPENDS ${top}.json
    DEPENDS ulx3s.pcf

    COMMAND "nextpnr-ecp5 --85k --package CABGA381 --lpf ulx3s.lpf --lpf-allow-unconstrained --json ${top}.json --textcfg ${top}.config"
  )

  add_custom_target(${top}_pr
    DEPENDS ${top}.config
  )
endfunction()

function(add_bitstream top)
  add_custom_command(OUTPUT ${top}.bit
    DEPENDS ${top}.config

    COMMAND "ecppack ${top}.config ${top}.bit"
  )

  add_custom_target(${top}_bitstream
    DEPENDS ${top}.bit
  )
endfunction()

function(add_flash top)
  add_custom_target(${top}_flash
    COMMNAND "fujprog -j flash ${top}.bit"
  )
endfunction()

# Adding all subdirectories
add_subdirectory(cmake_example)
