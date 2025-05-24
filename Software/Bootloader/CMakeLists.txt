cmake_minimum_required (VERSION 3.8)

project ("Bootloader")

add_compile_definitions("__riscv32__")
add_compile_definitions("DEBUG")
add_subdirectory("elfload")

add_executable (Bootloader)

target_link_libraries(Bootloader "elfload")

target_sources(Bootloader PRIVATE
	"Bootloader.cpp"
)



if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET Bootloader PROPERTY CXX_STANDARD 20)
endif()
