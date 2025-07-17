project("fatfs")
enable_language(C)

add_compile_options(-nostdlib
                    -DHAVE_MMAP=0 # don't compile MMAP
                    -D_LDBL_EQ_DBL=0 # no long double support
                    -fno-exceptions
	                  -fno-unwind-tables
	                  -fno-rtti
	                  -march=rv32imf
	                  -mabi=ilp32f
	                  -Os #this could be changed to O3 in general
	                  -ffreestanding
	                  -Bstatic
	                  -nostdinc
	                  -fno-builtin
)

add_link_options( -nostdlib
	                -ffreestanding
	                -Bstatic
	                -nostdlib
	                -fno-builtin
)

add_library(fatfs STATIC
  diskio.c
  ff.c
  ffunicode.c
)

target_include_directories(fatfs
  PUBLIC SYSTEM ${WUEHANS_ROOT}/system-include/newlib
)
