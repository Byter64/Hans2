cmake_minimum_required (VERSION 3.23)

set(HEADERS
	${GRAPHICS_HEADERS}
)

set(SOURCES 
	${GRAPHICS_SOURCES}
	"src/Hapi.cpp"
	"src/ControllerInput.cpp"
)
 
add_library(Graphic_Hans_API ${SOURCES} ${HEADERS})
target_link_options(Graphic_Hans_API PRIVATE -Wl,--gc-sections)
target_compile_definitions(Graphic_Hans_API PRIVATE HANS)
target_include_directories(Graphic_Hans_API PRIVATE "include")
target_include_directories(Graphic_Hans_API PRIVATE "../include")
target_include_directories(Graphic_Hans_API PRIVATE "../../Assets/include")