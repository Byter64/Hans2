cmake_minimum_required(VERSION 3.24.0)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/toolchain.cmake)
set(WUEHANS_LINKERSCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/wuehans/wuehans.ld)
set(WUEHANS_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project("WueHans Template Game")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(FetchContent)
FetchContent_Declare(Hall
    GIT_REPOSITORY https://github.com/byter64/Hall.git
    GIT_TAG main
)

add_subdirectory(lib)
FetchContent_MakeAvailable(Hall)

add_subdirectory(code)
