cmake_minimum_required (VERSION 3.30.0)
project ("Bootloader")
enable_language(C CXX ASM)

add_compile_definitions("__riscv32__")

add_compile_options(
	-fno-exceptions
	-nostdlib
	-fno-unwind-tables
	-fno-rtti
	-ffreestanding
	-march=rv32imf
	-mabi=ilp32f
	-Os
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


include_directories(TrapHandler.elf
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable (TrapHandler.elf)

target_sources(TrapHandler.elf PUBLIC
	"main.cpp"
)

add_custom_command(TARGET TrapHandler.elf POST_BUILD
	COMMAND objcopy ARGS -O verilog TrapHandler.elf Bootloader.hex)

add_custom_command(TARGET TrapHandler.elf POST_BUILD
	COMMAND python ARGS ${CMAKE_CURRENT_SOURCE_DIR}/hex8tohex32.py Bootloader.hex > Bootloader32.hex
)
