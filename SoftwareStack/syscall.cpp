#include "fatfs/ff.h"
#include <cerrno>
#include <cstdio>
#include <sys/stat.h>

extern "C" {

void *__dso_handle = 0;

int _write(int fd, [[maybe_unused]] char *ptr, int len) {
  int written = 0;

  if ((fd != 1) && (fd != 2) && (fd != 3)) {
    return -1;
  }

  for (; len != 0; --len) {
    // uart_putchar((uint8_t)*ptr++);
    f_write(NULL, NULL, 1, NULL);
    ++written;
  }
  return written;
}

int _read([[maybe_unused]] int fd, [[maybe_unused]] char *ptr,
          [[maybe_unused]] int len) {
  return 0;
}

void *_sbrk(int incr) {
  extern int _bss_end;
  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) {
    heap = (unsigned char *)&_bss_end;
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
}
