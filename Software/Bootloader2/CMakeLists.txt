cmake_minimum_required (VERSION 3.30.0)
project ("Bootloader2")
enable_language(C CXX ASM)

add_compile_definitions("__riscv32__")

add_compile_options(
	-fno-exceptions
	-nostdlib
	-fno-unwind-tables
	-fno-rtti
	-ffreestanding
	-march=rv32im
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


include_directories(Bootloader2.elf
	PUBLIC SYSTEM ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/newlib-4.5.0.20241231/newlib/libc/include
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
	PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/fatfs
)

include(FetchContent)
FetchContent_Declare(Hall
	GIT_REPOSITORY "https://github.com/Byter64/Hall"
	GIT_TAG main
)
FetchContent_MakeAvailable(Hall)

add_subdirectory("elfload")
add_subdirectory("fatfs")
add_executable (Bootloader2.elf)

target_link_libraries(Bootloader2.elf 
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libc.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libg.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libgloss.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libm.a
	elfload
	fatfs
	Hall
	)

target_sources(Bootloader2.elf PUBLIC
	"syscall.c"
	"start.S"
	"start.cpp"
	"Bootloader.cpp"

)

add_custom_command(TARGET Bootloader2.elf POST_BUILD
	COMMAND objcopy ARGS -O verilog Bootloader2.elf Bootloader2.hex)

add_custom_command(TARGET Bootloader2.elf POST_BUILD
	COMMAND python ARGS ${CMAKE_CURRENT_SOURCE_DIR}/hex8tohex32.py Bootloader2.hex > Bootloader32.hex
)
