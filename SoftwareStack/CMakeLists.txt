cmake_minimum_required(VERSION 3.24.0)
enable_language(C CXX ASM)
project("Hans2_Software")

add_compile_options(
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
                    -fno-exceptions
                    -nostartfiles
                    -nostdlib
                    -fno-unwind-tables
)
add_link_options(-nostdlib -nostartfiles
  -T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
)

add_subdirectory(fatfs)

add_executable(test.elf
  start.S
  test.cpp
  syscall.c
)

target_link_libraries(test.elf
  fatfs
  stdc++
  c
  gcc
  m
)

add_custom_command(OUTPUT start.tmp
  DEPENDS start.elf
  COMMAND ${CMAKE_OBJCOPY} -O verilog ${CMAKE_CURRENT_BINARY_DIR}/start.elf ${CMAKE_CURRENT_BINARY_DIR}/start.tmp
  COMMENT "Generating start.tmp from start.elf"
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
