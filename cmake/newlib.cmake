# Fetch newlib
include(FetchContent)

FetchContent_Declare(newlib_sources
  GIT_REPOSITORY https://sourceware.org/git/newlib-cygwin.git
  GIT_COMMIT a473f960e58bdc540eb8b6eb7f3efb52ff99cb33
)

message("Fetching newlib")
FetchContent_MakeAvailable(newlib_sources)

add_library(newlib
  ${CMAKE_CURRENT_SOURCE_DIR}/glue.c
  ${CMAKE_CURRENT_SOURCE_DIR}/sbrk_hans.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/signal/sig2str.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/signal/raise.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/signal/psignal.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/signal/signal.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/ffs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/strcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/strlen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/ieeefp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/memcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/machine/riscv/memmove-stub.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_add_sep.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/buf_findstr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_create.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_insert.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_entry.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_next.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_extract.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_append.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_delete.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_remove.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_add.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_stringify.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_create_sep.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_get.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_replace.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/argz_count.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_strip.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_add.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/argz/envz_merge.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswspace.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswupper_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/wctype.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isblank.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isxdigit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/ispunct.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isalnum.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towupper.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/toupper.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/jp2uc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswblank.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isascii_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isalpha.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iscntrl.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/categories.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isdigit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswdigit_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isascii.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isalnum_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswupper.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswcntrl.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isprint.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswspace_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswpunct.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswxdigit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/ispunct_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/toascii_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/tolower.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/islower_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towlower.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towctrans.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswgraph_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isxdigit_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswxdigit_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswcntrl_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/wctrans.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswblank_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/tolower_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswpunct_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isupper_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/islower.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswprint.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/toupper_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswalpha.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towupper_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isupper.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iscntrl_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswalnum_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/toascii.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towlower_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswctype.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswalpha_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswctype_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswdigit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/wctype_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/towctrans_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isspace.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/wctrans_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswprint_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isprint_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/ctype_.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isblank_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswlower_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isdigit_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isalpha_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/isspace_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswgraph.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswlower.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/ctype/iswalnum.c

  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcrtomb.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtodg.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-dmisc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/jrand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbstowcs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mtrim.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/freer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/l64a.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/quick_exit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/imaxdiv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoul.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoul.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/btowc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstombs_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstombs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/labs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/lcong48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/system.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/arc4random.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/msize.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/cfreer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/_Exit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/ldtoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtold.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mstats.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/arc4random_uniform.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbrtowc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wctob.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/malignr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/calloc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/seed48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoll_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/malign.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/callocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/malloptr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbsrtowcs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/pvallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mlock.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-ldtoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/cxa_atexit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/__atexit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/random.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/rpmatch.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atoi.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mallstatsr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/utoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/ecvtbuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atol.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atexit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcsrtombs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/llabs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstod.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbsinit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/sb_charsets.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoull.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoll_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtol.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/exit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/itoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/realloc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/cxa_finalize.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/eprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/__adjust.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/setenv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbstowcs_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/_mallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mblen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/abort.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atof.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/lldiv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atoll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/putenv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/atoff.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbtowc_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoimax.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/envlock.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoimax.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/valloc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/nrand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wctomb.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/reallocarray.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/efgcvt.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/reallocf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/imaxabs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-gdtoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/getsubopt.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/on_exit_args.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mprec.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/srand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbtowc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoull_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/malloc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstoumax.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/abs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/ldiv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/environ.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/vallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/on_exit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtod.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/rand.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbrlen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mblen_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-gethex.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstol.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mallinfor.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/reallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/div.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/putenv_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-hexnan.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/lrand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoull_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/setenv_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/rand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/getenv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/rand_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/dtoa.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wctomb_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/a64l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcstold.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mbsnrtowcs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtorx.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/__exp10.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoull.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/__ten_mu.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/getenv_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/erand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/wcsnrtombs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/getopt.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/nano-mallocr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/mrand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/drand48.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/gdtoa-gmisc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/dtoastub.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/aligned_alloc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/__call_atexit.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/strtoumax.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/msizer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdlib/assert.c

  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/table-pcs.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/table.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/utf-8.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/cesbi.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/ucs-4.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/us-ascii.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/utf-16.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/ucs-2-internal.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/euc.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/ucs-4-internal.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ces/ucs-2.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/ucsconv.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/nullconv.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/aliasesbi.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/iconvnls.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/iconv.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/lib/aliasesi.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1255.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_1.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cp775.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1257.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_4.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cp850.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_14.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_10.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_9.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cp855.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/ksx1001.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_5.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1256.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/koi8_uni.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1250.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/jis_x0208_1990.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1251.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_7.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/koi8_u.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/ccsbi.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/koi8_ru.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_2.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cns11643_plane14.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cns11643_plane2.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/big5.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_13.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1252.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1254.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cp866.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_11.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cp852.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_3.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/jis_x0201_1976.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/koi8_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1258.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/win_1253.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_8.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_ir_111.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/jis_x0212_1990.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_15.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/iso_8859_6.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/iconv/ccs/cns11643_plane1.c

  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysfork.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syswait.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysisatty.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysclose.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysstat.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysgetpid.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syslseek.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysread.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysfstat.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysfcntl.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysunlink.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syssbrk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysopen.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysgetentropy.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/systimes.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syskill.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syslink.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysexecve.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/sysgettod.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/syscalls/syswrite.c
 
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/timesr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/open64r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/isattyr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/linkr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/gettimeofdayr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/closer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/fstatr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/reent.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/unlinkr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/sbrkr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/openr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/getentropyr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/mkdirr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/stat64r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/fcntlr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/writer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/execr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/impure.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/renamer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/lseekr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/lseek64r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/fstat64r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/readr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/getreent.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/statr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/reent/signalr.c

  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/tzset.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/difftime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/mktime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/gmtime_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/time.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/wcsftime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/lcltime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/clock.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/asctime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/ctime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/tzset_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/month_lengths.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/ctime_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/tzlock.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/tzvars.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/gettzinfo.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/strftime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/lcltime_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/gmtime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/strptime.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/tzcalc_limits.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/time/asctime_r.c

  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcslen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcoll_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcpncpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strpbrk.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcasestr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/rindex.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/ffsl.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strncasecmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memrchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcslcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strdup.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strerror_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcspbrk.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmemmove.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strtok_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memset.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/gnu_basename.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/xpg_strerror_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcstok.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strlcat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strlcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strlen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/bcopy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strnlen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcswidth.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strstr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strsep.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strerror.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsxfrm_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscoll_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/stpncpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcasecmp_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcspn.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsnlen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmempcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memccpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strxfrm_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsstr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/timingsafe_bcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsncasecmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcslcat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strnstr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscasecmp_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strndup_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsspn.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strlwr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsncpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscasecmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcoll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/mempcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmemcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/index.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/rawmemchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcasecmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strncpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/u_strerr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strdup_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memmem.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/fls.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strverscmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/flsll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strxfrm.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memmove.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscspn.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/timingsafe_memcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strsignal.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsncasecmp_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strncasecmp_l.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmemcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/explicit_bzero.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsncat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strchrnul.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcschr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/memchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strncat.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strncmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strspn.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strndup.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/stpcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strrchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/ffsll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmemchr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsncmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/bzero.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/swab.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcwidth.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strtok.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsdup.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/flsl.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wmemset.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/bcmp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcpcpy.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcscoll.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/strupr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsxfrm.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/string/wcsrchr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/ffs.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/lock.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/fini.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/init.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/unctrl.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/misc/__dprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/errno/errno.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/pwrite.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/ttyname_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/basename.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/getpass.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/dirname.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/getcwd.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/getut.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/ttyname.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/getpwent.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/sigset.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/pread.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/unix/getlogin.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/freopen64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/fgetpos64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/fsetpos64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/fopen64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/fseeko64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/tmpfile64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/ftello64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/fdopen64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio64/stdio64.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_float.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_float_vax.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_private.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_mem.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_rec.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_stdio.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_sizeof.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_array.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/xdr/xdr_reference.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hcreate_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/twalk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/tfind.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash_log2.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/tdestroy.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash_buf.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/qsort_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash_bigkey.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/ndbm.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash_func.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hcreate.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/bsd_qsort_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/tdelete.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/bsearch.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/hash_page.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/qsort.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/search/tsearch.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/telldir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/nftw.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execlp.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/rewinddir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/readdir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/sleep.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/creat.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/wordexp.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/closedir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/seekdir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/readdir_r.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/usleep.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/wordfree.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execv.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/isatty.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/popen.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/opendir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/glob.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/dirfd.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/collcmp.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/scandir.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/fnmatch.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execl.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/collate.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/_isatty.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/regfree.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/engine.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execle.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execvp.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/ftw.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/execve.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/regerror.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/regexec.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/posix_spawn.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/posix/regcomp.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/stpcpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/vsprintf_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/vsnprintf_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/stpncpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/mempcpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/strcat_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/memmove_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/memset_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/stack_protector.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/strncat_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/strncpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/gets_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/memcpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/snprintf_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/strcpy_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/sprintf_chk.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/ssp/chk_fail.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/lmessages.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/duplocale.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/freelocale.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/newlocale.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/lnumeric.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/timelocal.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/localeconv.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/uselocale.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/nl_langinfo.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/locale.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/lmonetary.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/getlocalename_l.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/locale/lctype.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sfputws_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/clearerr_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfwscanf.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfprintf_float.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vasniprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetpos.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/stdio_ext.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfscanf_float.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfiscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/rename.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fvwrite.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/tmpnam.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putwchar_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ungetwc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/wscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/feof_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfiscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fscanf.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vasnprintf.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vasiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/iscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/mktemp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetws_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/printf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfiwscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getwc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfiwscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/setbuffer.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputws_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vswscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vwscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fread.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fflush.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putwc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sfputs_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/asnprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/funopen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putwc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fsetpos.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fopencookie.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getwchar_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetwc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fileno.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fileno_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/setbuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ferror.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fopen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgets.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/open_memstream.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fsetlocking.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/makebuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fmemopen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/puts.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputwc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/diprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/viscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetwc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputs.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/siscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ftell.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/viprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-svfscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/scanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwalk.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/freopen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putchar_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/wbufw.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwrite.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/tmpfile.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sswprint_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/siprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sprint_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/gets.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/stdio.c
  # ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getw.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fseeko.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputs_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vdiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsiscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/feof.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getchar.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/setlinebuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/setvbuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-svfprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfprintf_i.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/dprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fdopen.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ftello.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ssputws_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfwscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/clearerr.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/asniprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putw.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ferror_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/iprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/findfp.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputws.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ssprint_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/wbuf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getline.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/perror.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwide.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sniprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getdelim.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/flags.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putwchar.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsniprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/rget.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/swscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/refill.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getchar_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fseek.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgetws.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sccl.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fcloseall.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/rewind.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fflush_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fiscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vswprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getwc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/getwchar.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/asprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/nano-vfscanf_i.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fread_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ungetc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfscanf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwrite_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putchar.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/putc.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fgets_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vdprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vasprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/ssputs_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fpurge.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/sprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/wsetup.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vsnprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fclose.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/fputwc_u.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/snprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfiwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/vfiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/swprint_r.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/svfiwprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/remove.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/swprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/asiprintf.c
  ${newlib_sources_SOURCE_DIR}/newlib/libc/stdio/wprintf.c
)

target_include_directories(newlib
  PRIVATE ${newlib_sources_SOURCE_DIR}/newlib/libc/include/
)
