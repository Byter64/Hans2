cmake_minimum_required (VERSION 3.23)

set(RAYLIB_VERSION 5.5)
find_package(raylib ${RAYLIB_VERSION} QUIET) # QUIET or REQUIRED
if (NOT raylib_FOUND) # If there's none, fetch and build raylib
  include(FetchContent)
  FetchContent_Declare(
    raylib
    DOWNLOAD_EXTRACT_TIMESTAMP OFF
    URL https://github.com/raysan5/raylib/releases/download/5.5/raylib-5.5_linux_amd64.tar.gz
  )
  FetchContent_GetProperties(raylib)
  if (NOT raylib_POPULATED) # Have we downloaded raylib yet?
    set(FETCHCONTENT_QUIET NO)
    FetchContent_MakeAvailable(raylib)
    set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples
  endif()
endif()

set(HEADERS
	${GRAPHICS_HEADERS}
)

set(SOURCES 
	${GRAPHICS_SOURCES}
	"src/Hapi.cpp"
	"src/ControllerInput.cpp"
)


add_library(Graphic_Desktop_API ${HEADERS} ${SOURCES})
target_link_libraries(Graphic_Desktop_API raylib)
target_compile_definitions(Graphic_Desktop_API PUBLIC DESKTOP)
target_include_directories(Graphic_Desktop_API PRIVATE "include")
target_include_directories(Graphic_Desktop_API PRIVATE "../include")
target_include_directories(Graphic_Desktop_API PRIVATE "raylib/src")