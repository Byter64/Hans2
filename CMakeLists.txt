cmake_minimum_required(VERSION 3.24.0)
project("Hans2")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

add_subdirectory(HardwareDesign)
add_subdirectory(SoftwareStack)
