cmake_minimum_required(VERSION 3.24.0)
enable_language(C CXX ASM)
project("Cool game")

add_executable (Game.elf)
  
target_include_directories(Game.elf
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include/libstdc++
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include/libstdc++/riscv32-unknown-elf
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include
  PUBLIC SYSTEM ${WUEHANS_ROOT}/lib
  PUBLIC SYSTEM ${WUEHANS_ROOT}/wuehans
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include/newlib # This needs to be after libstdc++ because of include_nexts - JH
)

target_link_libraries(Game.elf
  ${WUEHANS_ROOT}/lib/newlib/libc.a
  ${WUEHANS_ROOT}/lib/newlib/libg.a
  ${WUEHANS_ROOT}/lib/newlib/libgloss.a
  ${WUEHANS_ROOT}/lib/newlib/libm.a
  ${WUEHANS_ROOT}/lib/newlib/libgcc.a
  ${WUEHANS_ROOT}/lib/libstdc++.a
  ${WUEHANS_ROOT}/lib/libsupc++.a
  fatfs
  Hall
)

target_sources(Game.elf PUBLIC
  PUBLIC ${WUEHANS_ROOT}/wuehans/start.S
  PUBLIC ${WUEHANS_ROOT}/wuehans/syscall.c

  # Add your .cpp files here
  "main.cpp"
)

# This is stuff for debugging the hardware. Just ignore it :)
 add_custom_command(TARGET Game.elf POST_BUILD
	COMMAND objcopy ARGS -O verilog Game.elf Game.hex)

 add_custom_command(TARGET Game.elf POST_BUILD
	COMMAND python ARGS ${WUEHANS_ROOT}/wuehans/hex8tohex32.py Game.hex > Game32.hex
)
