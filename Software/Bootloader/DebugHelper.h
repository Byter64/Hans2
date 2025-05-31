#pragma once
#include "ff.h"

const char* FRESULTToString(FRESULT fResult);

//Cant go backwards
void SetLoadingBar(int percent);

void ScreenPrint(const char* text);
void ScreenPrintStatus(const char* text);

void ScreenPrintByte(unsigned char byte);
void ScreenPrintHWord(uint16_t hword);
void ScreenPrintResult(FRESULT fatfsResult);

const char* ByteToHex(unsigned char byte, char* buffer);