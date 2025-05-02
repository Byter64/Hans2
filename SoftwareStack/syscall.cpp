#include <cerrno>
#include <cstdio>
#include <sys/stat.h>

extern "C" {

void *__dso_handle = 0;

int _write(int fd, char *ptr, int len) {
  int written = 0;

  if ((fd != 1) && (fd != 2) && (fd != 3)) {
    return -1;
  }

  for (; len != 0; --len) {
    // uart_putchar((uint8_t)*ptr++);
    ++written;
  }
  return written;
}

int _read(int fd, char *ptr, int len) { return 0; }

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

int _fstat(int fd, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

int _lseek(int fd, int offset, int whence) { return 0; }

int _open(const char *name, int flags, int mode) {
  errno = ENOSYS;
  return -1;
}

int _close(int fd) { return -1; }

int _isatty(int fd) { return 1; }

void _exit(int status) {
  while (1) {
  }
}

int _kill(int pid, int sig) {
  errno = EINVAL;
  return -1;
}

int _getpid() { return -1; }
}
