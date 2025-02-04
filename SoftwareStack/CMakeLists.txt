cmake_minimum_required(VERSION 3.24.0)
project("Hans2_Software")

set(OBJCOPY "/usr/bin/riscv64-linux-gnu-objcopy")

include(ExternalProject)
ExternalProject_Add(newlib
    # SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libantlr
    SOURCE_DIR /home/jonathan/Programme/newlib-cygwin
    CONFIGURE_COMMAND /home/jonathan/Programme/newlib-cygwin/configure --prefix=<INSTALL_DIR>
    BUILD_COMMAND ${MAKE}
)

add_compile_options(-mabi=ilp32 -march=rv32im -W -Os -Bstatic --freestanding -lstdc++)

# nostdlib!!
add_link_options(-W -Os -Bstatic -T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld --freestanding -nostdlib -mabi=ilp32 -march=rv32im)

list(APPEND sources
  test.cpp
)

add_executable(test.elf ${sources})
target_link_libraries(test.elf newlib)

add_custom_command(OUTPUT test.tmp
  DEPENDS test.elf
  COMMAND ${OBJCOPY} -O verilog test.elf test.tmp
  COMMENT "Generating verilog binary"
)

add_custom_command(OUTPUT start.tmp
  DEPENDS start.elf
  COMMAND ${OBJCOPY} -O verilog ${CMAKE_CURRENT_SOURCE_DIR}/start.elf start.tmp
  COMMENT "Generating verilog binary"
)

add_custom_command(OUTPUT test.hex
  DEPENDS test.tmp start.tmp
  COMMAND cat test.tmp start.tmp > test.hex
)

add_custom_target(erstmal_das
  DEPENDS test.hex
)

# add_custom_command(test_32.hex
# ....
# )
