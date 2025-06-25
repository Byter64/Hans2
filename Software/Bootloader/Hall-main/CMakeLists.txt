project("Hall")

add_compile_options(
  -fno-exceptions
  -nostdlib
  -fno-unwind-tables
  -fno-rtti
  -march=rv32im
  -Os
  -ffreestanding
  -Bstatic
  -nostdinc
)

add_link_options(
  -nostdlib
  -Wl,--gc-sections
  -ffreestanding
  -Bstatic
  -nostdlib
)

add_library(Hall STATIC
  "source/Audio.cpp"
  "source/System.cpp"
  "source/Video.cpp"
)

target_include_directories(Hall
  PUBLIC SYSTEM include
)
