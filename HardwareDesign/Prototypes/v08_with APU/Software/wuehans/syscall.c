#include <fatfs/ff.h>
#include <wuehans_config.h>
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>

void *__dso_handle = 0;

const TCHAR STDOUT[30] = "stdout.txt";
const TCHAR STDERR[30] = "stderr.txt";

FIL fp = {0};
FATFS FatFs = {0};
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

    FIL write_file;
    FRESULT fr = f_open(&write_file, STDOUT, FA_OPEN_APPEND | FA_WRITE);
    if (fr != 0) {
      return fr;
    }

    UINT written = 0;
    fr = f_write(&write_file, ptr, len, &written);
    if (fr != 0) {
      return -1;
    }

    f_close(&write_file);

    // HACK: Hackerman
    volatile int* x = (int*) 0x80000000;
    int b = *x;
    // HACK: Hackerman Ende
    return written;

  } else if (fd > 2 && (fd-3) < FILE_AMOUNT && fd_data[fd-3].is_open) {
    UINT bw = 0;
    f_write(&fd_data[fd-3].fp, ptr, len, &bw);

    return bw;
  }

  return -1;
}

int _read(int fd, char *ptr, int len) {
  if (fd > 2 && (fd-3) < FILE_AMOUNT && fd_data[fd-3].is_open) {
    UINT bytesRead = 0;
    FRESULT result = f_read(&fd_data[fd-3].fp, ptr, len, &bytesRead);

    return bytesRead;
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

  if ((int)heap + incr < (int) &heap_begin + HEAP_SIZE) {
    heap += incr;
  }

  return prev_heap;
}

int _lseek(int fd, int offset, int whence) {
  // Invalid lseek call
  if (fd <= 2 || (fd-3) >= FILE_AMOUNT || !fd_data[fd-3].is_open) {
    return -1;
  }

  // Calculate the correct offset for f_lseek()
  FSIZE_t ofs = 0;
  switch (whence) {
    // Set to offset directly
    case SEEK_SET:
      ofs = offset;
      break;

    // Increment by offset
    case SEEK_CUR:
      ofs = f_tell(&fd_data[fd-3].fp) + offset;
      break;

    // Append offset to EOF
    case SEEK_END:
      ofs = f_size(&fd_data[fd-3].fp) + offset;
      break;
    default:
      return -1;
  }

  FRESULT result = f_lseek(&fd_data[fd-3].fp, ofs);
  return result;
}

int _open(const char *name, int flags, int mode) {
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
    if (fr != FR_OK) {
      return -1;
    }

    fd_data[i].mode = mode;
    fd_data[i].is_open = 1;
    // Exclude stdout, stderr, stdin
    return i+3;
  }

  return -1;
}

int _close(int fd) {
  if (fd > 2 && (fd-3) < FILE_AMOUNT) {
    f_close(&fd_data[fd-3].fp);
    fd_data[fd-3].is_open = 0;
    return 0;
  }

  return -1;
}

int _fstat(int fd, struct stat *st) {
  st->st_mode = S_IFREG;
  return 0;
}

int _isatty(int fd)
{ 
  errno = ENOTTY;
  return 0;
}

void _exit(int status) {
  while (1) {
  }
}

int _kill(int pid, int sig) {
  errno = EINVAL;
  return -1;
}

int _getpid() { return -1; }
