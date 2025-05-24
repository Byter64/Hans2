cmake_minimum_required (VERSION 3.8)
enable_language(C CXX ASM)

project ("Bootloader")

add_compile_definitions("__riscv32__")
#add_compile_definitions("DEBUG")

add_compile_options(
                    -fno-exceptions
                    -nostdlib
                    -fno-unwind-tables
                    -fno-rtti
					"--target=riscv32-none-elf"
					-march=rv32im 
					-Os
					"-Wl,--gc-sections" 
					-ffreestanding 
					-Bstatic
)

add_link_options(-nostdlib -nostartfiles
  -T${CMAKE_CURRENT_SOURCE_DIR}/riscv.ld
)


add_subdirectory("elfload")
add_subdirectory("fatfs")

add_executable (Bootloader.elf)

target_link_libraries(Bootloader.elf "elfload")

target_sources(Bootloader.elf PRIVATE
	"start.S"
	"Bootloader.cpp"
)



if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET Bootloader.elf PROPERTY CXX_STANDARD 20)
endif()
