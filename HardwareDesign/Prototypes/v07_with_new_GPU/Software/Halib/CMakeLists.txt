cmake_minimum_required (VERSION 3.23)



add_library(Halib_Hans)
add_library(Halib_Desktop)

target_include_directories(Halib_Hans PRIVATE "../Graphics/include")
target_include_directories(Halib_Hans PRIVATE "include")
target_compile_definitions(Halib_Hans PUBLIC HANS)

target_include_directories(Halib_Desktop PRIVATE "../Graphics/include")
target_include_directories(Halib_Desktop PRIVATE "include")
target_compile_definitions(Halib_Desktop PUBLIC DESKTOP)
target_link_libraries(Halib_Desktop raylib)

target_sources(Halib_Hans
	PUBLIC 
	"include/Sprite.h"	
	"include/Halib.h" 
	"include/Veci2.h" "include/Vec2.h" "include/ScaleSprite.h" "include/Image.h")


target_sources(Halib_Hans
	PRIVATE 
	"src/Sprite.cpp"
	"src/Veci2.cpp" "src/Vec2.cpp" "src/ScaleSprite.cpp" "src/Image.cpp")

target_sources(Halib_Desktop
	PUBLIC 
	"include/Sprite.h"	
	"include/Halib.h" 
	"include/Veci2.h" "include/Vec2.h" "include/ScaleSprite.h" "include/Image.h")


target_sources(Halib_Desktop
	PRIVATE 
	"src/Sprite.cpp"
	"src/Veci2.cpp" "src/Vec2.cpp" "src/ScaleSprite.cpp" "src/Image.cpp")