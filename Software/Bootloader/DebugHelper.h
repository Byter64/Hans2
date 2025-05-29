#include "ff.h"

extern const char* FRESULTToString(FRESULT fResult);

extern void ScreenPrint(const char* text);

extern void ScreenPrintByte(unsigned char byte);
extern void ScreenPrintHWord(uint16_t hword);

extern const char* ByteToHex(unsigned char byte, char* buffer);