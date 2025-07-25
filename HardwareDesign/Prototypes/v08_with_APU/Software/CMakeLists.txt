cmake_minimum_required(VERSION 3.24.0)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/toolchain.cmake)
set(WUEHANS_LINKERSCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/wuehans/wuehans.ld)
set(WUEHANS_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project("WueHans Template Game")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

  include_directories(
  SYSTEM ${WUEHANS_ROOT}/system-include/libstdc++
  SYSTEM ${WUEHANS_ROOT}/system-include/libstdc++/riscv32-unknown-elf
  SYSTEM ${WUEHANS_ROOT}/system-include
  SYSTEM ${WUEHANS_ROOT}/lib
  SYSTEM ${WUEHANS_ROOT}/system-include/newlib # This needs to be after libstdc++ because of include_nexts - JH
  )

include(FetchContent)
FetchContent_Declare(Hall
    GIT_REPOSITORY https://github.com/byter64/Hall.git
    GIT_TAG main
)

add_subdirectory(lib)
FetchContent_MakeAvailable(Hall)

add_compile_options(
  -fno-exceptions
  -nostdlib
  -fno-unwind-tables
  -fno-rtti
  -march=rv32imf
  -mabi=ilp32f
  -Os
  -ffreestanding
  -Bstatic
  -nostdinc
  -fno-builtin
)

add_link_options(
  -nostdlib
  -T ${WUEHANS_LINKERSCRIPT}
  -Wl,--gc-sections
  -ffreestanding
  -Bstatic
  -nostdlib
  -fno-builtin
)

add_subdirectory(code)
