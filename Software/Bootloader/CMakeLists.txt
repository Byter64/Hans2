cmake_minimum_required (VERSION 3.30.0)
project ("Bootloader")
enable_language(C CXX ASM)

add_compile_definitions("__riscv32__")

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
)

add_link_options(
	-nostdlib
	-nostartfiles
	-T ${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
	-Wl,--gc-sections
	-ffreestanding
	-Bstatic
	-nostdlib 
	-nostartfiles
)


include_directories(Bootloader.elf
	PUBLIC SYSTEM ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/newlib-4.5.0.20241231/newlib/libc/include
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/fatfs
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/Graphics/include
)

add_subdirectory("elfload")
add_subdirectory("fatfs")
add_subdirectory("Graphics")

add_executable (Bootloader.elf)

target_link_libraries(Bootloader.elf 
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libc.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libg.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libgloss.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libm.a
	elfload
	fatfs
	Graphic_Hans_API)

target_sources(Bootloader.elf PUBLIC
	"syscall.c"
	"start.S"
	"Bootloader.cpp"
	"DebugHelper.cpp"
)

add_custom_command(TARGET Bootloader.elf POST_BUILD
	COMMAND objcopy ARGS -O verilog Bootloader.elf Bootloader.hex)

add_custom_command(TARGET Bootloader.elf POST_BUILD
	COMMAND python ARGS ${CMAKE_CURRENT_SOURCE_DIR}/hex8tohex32.py Bootloader.hex > Bootloader32.hex
)
