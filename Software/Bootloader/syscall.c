#include "fatfs/ff.h"
#include "wuehans_config.h"
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>

void *__dso_handle = 0;

const TCHAR STDOUT[30] = "stdout.log";
const TCHAR STDERR[30] = "stderr.log";
FIL fp;
FATFS FatFs;
BYTE is_mounted = 0;

struct FD_Data {
  FIL fp;
  BYTE mode;
  BYTE is_open;
} FD_Data_default = {NULL, FA_READ, 0};
typedef struct FD_Data FD_Data;

#define FILE_AMOUNT 4
static FD_Data fd_data[FILE_AMOUNT];

int _write(int fd, char *ptr, int len) {
  if (is_mounted == 0) {
    f_mount(&FatFs, "", 0);
    is_mounted = 1;
  }
  // stdout
  if (fd == 1) {

    FRESULT fr = f_open(&fp, STDOUT, FA_WRITE);
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
  } else if (fd > 2 && fd < FILE_AMOUNT && fd_data[fd].is_open) {
    UINT bw = 0;
    f_write(&fd_data[fd].fp, ptr, len, &bw);
    return bw;
  }

  return -1;
}

int _read(int fd, char *ptr, int len) {
  if (fd > 2 && fd < FILE_AMOUNT && fd_data[fd].is_open) {
    UINT br = 0;
    f_read(&fd_data[fd].fp, ptr, len, &br);
    return br;
  }

  return -1;
}

void *_sbrk(int incr) {
  extern int heap_begin;
  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) {
    heap = (unsigned char *)&heap_begin;
  }
  prev_heap = heap;

  if ((int)heap + incr < heap_begin + HEAP_SIZE) {
    heap += incr;
  }

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

int _open(const char *name, [[maybe_unused]] int flags, int mode) {
  if (is_mounted == 0) {
    f_mount(&FatFs, "", 0);
    is_mounted = 1;
  }

  int i;
  for (i = 0; i < FILE_AMOUNT; i++) {
    if (fd_data[i].is_open == 1) {
      // Entry already in use
      continue;
    }

    FRESULT fr = f_open(&fd_data[i].fp, name, mode);
    if (fr == 0) {
      return -1;
    }

    fd_data[i].mode = mode;
    fd_data[i].is_open = 1;
    return i;
  }

  return -1;
}

int _close(int fd) {
  if (fd > 2 && fd < FILE_AMOUNT) {
    fd_data[fd].is_open = 0;
    return 0;
  }

  return -1;
}

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
