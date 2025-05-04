#include "fatfs/ff.h"
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>

void *__dso_handle = 0;

const TCHAR path[30] = "stdout.log";
FIL fp;
FATFS FatFs;

int _write([[maybe_unused]] int fd, char *ptr, int len) {
  f_mount(&FatFs, "", 0);

  FRESULT fr = f_open(&fp, path, FA_WRITE);
  if (fr != 0) {
    return fr;
  }

  UINT written = 0;

  fr = f_write(&fp, ptr, len, &written);
  if (fr != 0) {
    // TODO: Set errno
    return -1;
  }

  f_close(&fp);
  return written;
}

int _read([[maybe_unused]] int fd, [[maybe_unused]] char *ptr,
          [[maybe_unused]] int len) {
  return 0;
}

void *_sbrk(int incr) {
  extern int heap_begin;
  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) {
    heap = (unsigned char *)&heap_begin;
  }
  prev_heap = heap;

  heap += incr;

  return prev_heap;
}

int _fstat([[maybe_unused]] int fd, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

int _lseek([[maybe_unused]] int fd, [[maybe_unused]] int offset,
           [[maybe_unused]] int whence) {
  return 0;
}

int _open([[maybe_unused]] const char *name, [[maybe_unused]] int flags,
          [[maybe_unused]] int mode) {
  errno = ENOSYS;
  return -1;
}

int _close([[maybe_unused]] int fd) { return -1; }

int _isatty([[maybe_unused]] int fd) { return 1; }

void _exit([[maybe_unused]] int status) {
  while (1) {
  }
}

int _kill([[maybe_unused]] int pid, [[maybe_unused]] int sig) {
  errno = EINVAL;
  return -1;
}

int _getpid() { return -1; }
