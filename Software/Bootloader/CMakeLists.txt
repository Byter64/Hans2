cmake_minimum_required (VERSION 3.8)
project ("Bootloader")
enable_language(C CXX ASM)

add_compile_definitions("__riscv32__")
#add_compile_definitions("DEBUG")

add_compile_options(
                    -fno-exceptions
                    -nostdlib
                    -fno-unwind-tables
                    -fno-rtti
					--target=riscv32-none-elf
					-march=rv32im 
					-Os
					-ffreestanding 
					-Bstatic
					-fuse-ld=ld.lld
					"-Wl,--gc-sections" 
)

add_link_options(
	-nostdlib 
	-nostartfiles
	-T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
	"-Wl,--gc-sections" 
)

include_directories(Bootloader.elf
	PUBLIC SYSTEM ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/newlib-4.5.0.20241231/newlib/libc/include
	PUBLIC SYSTEM ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/newlib-4.5.0.20241231/newlib/libc/include/sys
)

add_subdirectory("elfload")

add_executable (Bootloader.elf)

target_link_libraries(Bootloader.elf 
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libc.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libg.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libgloss.a
	${CMAKE_CURRENT_SOURCE_DIR}/newlib/libm.a
	elfload)

target_sources(Bootloader.elf PUBLIC
	"start.S"
	"Bootloader.cpp"
)



if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET Bootloader.elf PROPERTY CXX_STANDARD 20)
endif()
