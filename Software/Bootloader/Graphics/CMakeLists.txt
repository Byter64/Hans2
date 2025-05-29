cmake_minimum_required (VERSION 3.8)

set(GRAPHICS_HEADERS
	"../include/Hapi.h"
	"../include/Color.h"
	"../include/ControllerInput.h"
	"../include/FontAtlas.h"
	"../include/Rectangle.h"
)

set(GRAPHICS_SOURCES 
	"../src/Color.cpp"
	"../src/FontAtlas.cpp"
)

add_subdirectory("Hans")