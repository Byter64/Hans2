project("fatfs")

add_compile_options(-nostdlib
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
                    -fno-exceptions
)

add_link_options(-nostdlib)

add_library(fatfs STATIC
  diskio.c
  ff.c
)

target_link_libraries(fatfs
  m
  c
)
