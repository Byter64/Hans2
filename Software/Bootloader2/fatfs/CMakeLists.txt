project("fatfs")
enable_language(C)

add_compile_options(-nostdlib
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
                    -fno-exceptions
)

add_link_options(-nostdlib)

add_library(fatfs STATIC
  diskio.c
  ff.c
  ffunicode.c
)

target_link_libraries(fatfs
  ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/libc.a
  ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/libg.a
  ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/libgloss.a
  ${CMAKE_CURRENT_SOURCE_DIR}/../newlib/libm.a
)
