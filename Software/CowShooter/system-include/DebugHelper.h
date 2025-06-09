#pragma once
#include <fatfs/ff.h>

#define USE_STARTUP_SCREEN

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
void ScreenPrintHWord(unsigned short hword);
void ScreenPrintWord(unsigned int word);

const char* FRESULTToString(FRESULT fResult);
const char* ByteToHex(unsigned char byte, char* buffer);
