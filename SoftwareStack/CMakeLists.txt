cmake_minimum_required(VERSION 3.24.0)
enable_language(C ASM)
project("Hans2_Software")

add_compile_options(-nostdlib
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
                    -fno-exceptions
)
add_link_options(-nostdlib -fno-exceptions
  -T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
)

add_subdirectory(fatfs)

add_executable(test.elf
  start.S
  test.cpp
  syscall.cpp
)

target_link_libraries(test.elf
  fatfs
  m
  c
)

add_custom_command(OUTPUT test.tmp
  DEPENDS test.elf
  COMMAND ${CMAKE_OBJCOPY} -O verilog test.elf test.tmp
  COMMENT "Generating verilog binary"
)

add_custom_command(OUTPUT start.elf
  DEPENDS start.S
  COMMAND ${CMAKE_C_COMPILER} -target riscv32 -march=rv32im -mabi=ilp32 -W -Os -Bstatic -ffreestanding -nostdlib -o start.elf -T${CMAKE_CURRENT_SOURCE_DIR}/start.ld ${CMAKE_CURRENT_SOURCE_DIR}/start.S
  COMMENT "Generating start.elf from start.S"
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
