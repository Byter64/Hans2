/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2019        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

// File adapted for Hans2
#include "diskio.h" /* Declarations of disk functions */
#include "ff.h"     /* Obtains integer types */
#include <stdint.h>

static volatile void* const SD_CARD_START = (void*)0x80000000;
static volatile uint32_t* const SD_CARD_STATUS = (volatile uint32_t*)0xFFFFFFF0;

#define SD_INIT_DONE  (1 << 0)
#define SD_INIT_ERR   (1 << 1)
#define SD_CACHE_VAL  (1 << 2)
#define SD_CACHE_DIRTY (1 << 3)
#define SD_ERR_CODE_MASK (0x000000F0)

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status(BYTE pdrv /* Physical drive nmuber to identify the drive */
) {
    uint32_t status;
    if (pdrv != 0) return STA_NOINIT;
    status = *SD_CARD_STATUS;

    if (!(status & SD_INIT_DONE) || (status & SD_INIT_ERR)) {
        return STA_NOINIT;
    }

    return 0;
}

/*-----------------------------------------------------------------------*/
/* Initialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS
disk_initialize(BYTE pdrv /* Physical drive nmuber to identify the drive */
) {
    volatile int timeout;

    if (pdrv != 0) return STA_NOINIT;

    timeout = 10000000; 
    while (timeout > 0) {
        uint32_t status = *SD_CARD_STATUS;
        
        if (status & SD_INIT_DONE) {
            if (status & SD_INIT_ERR) {
                return STA_NOINIT;
            }
            return 0;
        }
        
        timeout--;
        __asm__ volatile ("nop");
    }
    return STA_NOINIT;
}

/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/
DRESULT disk_read(BYTE pdrv,  /* Physical drive nmuber to identify the drive */
                  BYTE *buff, /* Data buffer to store read data */
                  LBA_t sector, /* Start sector in LBA */
                  UINT count    /* Number of sectors to read */
) {
  DRESULT res = RES_OK;
  BYTE *baseAddress = ((BYTE*)(SD_CARD_START)) + (sector * 512);

  for (int i = 0; i < count * 512; i++)
  {
    buff[i] = baseAddress[i];
  }

  return res;
}

/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write(BYTE pdrv, /* Physical drive nmuber to identify the drive */
                   const BYTE *buff, /* Data to be written */
                   LBA_t sector,     /* Start sector in LBA */
                   UINT count        /* Number of sectors to write */
) {
  if (pdrv != 0) return RES_PARERR;

    BYTE *baseAddress = ((BYTE*)(SD_CARD_START)) + (sector * 512);

    for (int i = 0; i < count * 512; i++) {
        baseAddress[i] = buff[i];
    }

    volatile uint32_t* const SD_CARD_CONTROL = (volatile uint32_t*)0xFFFFFFF4;
    *SD_CARD_CONTROL = 0x01;

    while (*SD_CARD_STATUS & SD_CACHE_DIRTY) {
        __asm__ volatile ("nop");
    }

    return RES_OK;
}

#endif

/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl(BYTE pdrv, /* Physical drive nmuber (0..) */
                   BYTE cmd,  /* Control code */
                   void *buff /* Buffer to send/receive control data */
) {
  DRESULT res;
  int result;

  // Not needed for Hans2

  return RES_PARERR;
}
