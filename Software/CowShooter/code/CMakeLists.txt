cmake_minimum_required(VERSION 3.24.0)
enable_language(C CXX ASM)
project("Cool game")

add_compile_options(
  -fno-exceptions
  -nostdlib
  -fno-unwind-tables
  -fno-rtti
  -march=rv32im
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

add_executable (game.elf)

target_include_directories(game.elf
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include/newlib
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include
  PUBLIC SYSTEM ${WUEHANS_ROOT}/lib
  PUBLIC SYSTEM ${WUEHANS_ROOT}/wuehans
  PUBLIC include
  PUBLIC Assets/include
)

target_link_libraries(game.elf
  ${WUEHANS_ROOT}/lib/newlib/libc.a
  ${WUEHANS_ROOT}/lib/newlib/libg.a
  ${WUEHANS_ROOT}/lib/newlib/libgloss.a
  ${WUEHANS_ROOT}/lib/newlib/libm.a
  ${WUEHANS_ROOT}/lib/newlib/libgcc.a
  fatfs
  Hall
)

target_sources(game.elf PUBLIC
  PUBLIC ${WUEHANS_ROOT}/wuehans/start.S
  PUBLIC ${WUEHANS_ROOT}/wuehans/syscall.c

  # Add your .cpp files here
  source/main.cpp
  source/Object.cpp
  source/Player.cpp
  source/Bullet.cpp
  source/BulletManager.cpp
  source/Enemy.cpp
  source/EnemyManager.cpp
  source/GameManager.cpp
  source/Text.cpp
  source/FontAtlas.cpp
  source/printf.c
)

add_custom_command(TARGET game.elf POST_BUILD
	COMMAND objcopy ARGS -O verilog game.elf game.hex)

add_custom_command(TARGET game.elf POST_BUILD
	COMMAND python ARGS ${WUEHANS_ROOT}/tools/hex8tohex32.py game.hex > game32.hex
)