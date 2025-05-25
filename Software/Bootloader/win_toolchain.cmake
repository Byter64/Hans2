# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

set(CMAKE_C_FLAGS "riscv32-unknown-elf")
set(CMAKE_CXX_FLAGS "riscv32-unknown-elf")
set(CMAKE_ASM_FLAGS "riscv32-unknown-elf")

set(CMAKE_LINKER "ld.lld")
set(CMAKE_EXE_LINKER_FLAGS "--target=riscv32-unknown-elf -fuse-ld=lld -nostdlib")

# which compilers to use for C and C++
set(CMAKE_C_COMPILER   clang)
set(CMAKE_CXX_COMPILER clang++)

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  /usr/i586-mingw32msvc
    /home/alex/mingw-install)

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)