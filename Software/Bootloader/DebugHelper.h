#pragma once
#include "ff.h"

#define USE_STARTUP_SCREEN
const char* FRESULTToString(FRESULT fResult);

//Cant go backwards
void SetLoadingBar(int percent);
void WaitFrame(int frames);

/// @brief 
/// @param text 
/// @param loadingProgress in percent
/// @param waitFrames number of frames to wait AFTER text and loading bar were updated
void SetStatus(const char* text, int loadingProgress, int waitFrames);

void ScreenPrint(const char* text);
void ScreenPrintStatus(const char* text);

void ScreenPrintByte(unsigned char byte);
void ScreenPrintHWord(uint16_t hword);
void ScreenPrintWord(uint32_t word);
void ScreenPrintResult(FRESULT fatfsResult);

const char* ByteToHex(unsigned char byte, char* buffer);