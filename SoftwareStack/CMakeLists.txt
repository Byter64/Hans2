cmake_minimum_required(VERSION 3.24.0)
project("Hans2_Software")

set(CMAKE_CXX_COMPILER "clang")
set(CMAKE_C_COMPILER ${CMAKE_CXX_COMPILER})
set(CMAKE_LINKER "ld.lld")
set(CMAKE_OBJDUMP "/usr/bin/llvm-objdump")
set(CMAKE_OBJCOPY "/usr/bin/riscv64-linux-gnu-objcopy")

add_compile_options(-target riscv32 -march=rv32im -mabi=ilp32 -W -Os -Bstatic
                    -ffreestanding -nostdlib
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
)

add_link_options(-target riscv32 -march=rv32im -mabi=ilp32 -W -Os -Bstatic
                 -T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld -nostdlib
                 -ffreestanding
)

include(newlib) # Loading cmake/newlib.cmake

add_executable(test.elf
  test.cpp
)

target_link_libraries(test.elf
  newlib
)

target_include_directories(test.elf
  PRIVATE ${newlib_sources_SOURCE_DIR}/newlib/libc/include/
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
