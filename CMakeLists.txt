set(CMAKE_CXX_COMPILER "/usr/bin/riscv64-linux-gnu-g++")
set(CMAKE_C_COMPILER "/usr/bin/riscv64-linux-gnu-gcc")

cmake_minimum_required(VERSION 3.24.0)
project("Hans2")

add_subdirectory(HardwareDesign)
add_subdirectory(SoftwareStack)
