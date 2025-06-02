cmake_minimum_required(VERSION 3.24.0)

#set(COMPILER_PATH "/home/jonathan/.opt/riscv/bin/")
#set(CMAKE_CXX_COMPILER "${COMPILER_PATH}riscv32-unknown-elf-g++")
#set(CMAKE_C_COMPILER "${COMPILER_PATH}riscv32-unknown-elf-gcc")
#set(CMAKE_LINKER "${COMPILER_PATH}riscv32-unknown-elf-ld")
#set(CMAKE_OBJDUMP "${COMPILER_PATH}riscv32-unknown-elf-objdump")
#set(CMAKE_OBJCOPY "${COMPILER_PATH}riscv32-unknown-elf-objcopy")
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/toolchain.cmake)
add_compile_definitions("SIMULATION")


project("Hans2")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(HardwareDesign)
#add_subdirectory(SoftwareStack)
add_subdirectory(Software/Bootloader)
