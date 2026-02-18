# pragma once

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC void InitGlyphsC();
EXTERNC void PrintC(const char* text);

#undef EXTERNC