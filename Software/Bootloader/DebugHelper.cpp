extern "C" {
    #include "DebugHelper.h"
}
#include "Hapi.h"
#include "fatfs/ff.h"

const uint16_t BACKGROUND_COLOUR = 0x18c7; //HTML Farben: (30, 30, 30)
const uint16_t MAIN_COLOUR = 0x0265; //HTML Farben: (10, 71, 137)

const uint16_t backgroundColourRectangle[32] = 
{
    BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR,
    BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR,
    BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR,
    BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR, BACKGROUND_COLOUR
};

const uint16_t mainColourRectangle[32] = 
{
    MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR,
    MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR,
    MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR,
    MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR, MAIN_COLOUR
};

static const int LOADING_BAR_WIDTH = 293;
static const int LOADING_BAR_X = 49;
static const int LOADING_BAR_Y = 197;
static const int RECTANGLE_WIDTH = 8;
static const int RECTANGLE_HEIGHT = 4;


extern volatile int* GPU_VSYNC;
void WaitFrame(int frames)
{
    for(int i = 0; i < frames; i++)
    {
        while (!*GPU_VSYNC);
        while (*GPU_VSYNC);
        while (!*GPU_VSYNC);
        while (*GPU_VSYNC);
    }
}

void SetLoadingBar(int percent)
{
    static int loaded = 0; //In percent
    
    for(int i = loaded * 3; i <= percent * 3; i += RECTANGLE_WIDTH)
        Hapi::Draw((Hapi::Image)mainColourRectangle, 0, 0, LOADING_BAR_X + i, LOADING_BAR_Y, RECTANGLE_WIDTH, RECTANGLE_HEIGHT, RECTANGLE_WIDTH);
    Hapi::EndDrawing();
    
    for(int i = loaded; i <= percent; i += RECTANGLE_WIDTH)
        Hapi::Draw((Hapi::Image)mainColourRectangle, 0, 0, LOADING_BAR_X + i, LOADING_BAR_Y, RECTANGLE_WIDTH, RECTANGLE_HEIGHT, RECTANGLE_WIDTH);
    Hapi::EndDrawing();

    loaded = percent;
}

void SetStatus(const char* text, int loadingProgress, int waitFrames)
{
#ifdef USE_STARTUP_SCREEN
    ScreenPrintStatus(text);
    SetLoadingBar(loadingProgress);
    WaitFrame(waitFrames);
#else
    ScreenPrint(text);
#endif    
}

void ScreenPrintStatus(const char* text)
{
	static const int x = LOADING_BAR_X;
	static const int y = LOADING_BAR_Y - 7;

    for(int i = 0; i < LOADING_BAR_WIDTH; i += RECTANGLE_WIDTH)
        Hapi::Draw((Hapi::Image)backgroundColourRectangle, 0, 0, x + i, y, RECTANGLE_WIDTH, RECTANGLE_HEIGHT, RECTANGLE_WIDTH);
	Hapi::DrawText(">", x, y, 100);
	Hapi::DrawText(text, x + 4, y, 1000000);
	Hapi::EndDrawing();

    for(int i = 0; i < LOADING_BAR_WIDTH; i += RECTANGLE_WIDTH)
        Hapi::Draw((Hapi::Image)backgroundColourRectangle, 0, 0, x + i, y, RECTANGLE_WIDTH, RECTANGLE_HEIGHT, RECTANGLE_WIDTH);
	Hapi::DrawText(">", x, y, 100);
	Hapi::DrawText(text, x + 4, y, 1000000);
	Hapi::EndDrawing();
}


const char* FRESULTToString(FRESULT fResult)
{
	switch (fResult)
	{
	case FR_OK:
		return "FR_OK";
	break;
	case FR_DISK_ERR:
		return"FR_DISK_ERR";
	break;
	case FR_INT_ERR:
		return"FR_INT_ERR";
	break;
	case FR_NOT_READY:
		return"FR_NOT_READY";
	break;
	case FR_NO_FILE:
		return"FR_NO_FILE";
	break;
	case FR_NO_PATH:
		return"FR_NO_PATH";
	break;
	case FR_INVALID_NAME:
		return"FR_INVALID_NAME";
	break;
	case FR_DENIED:
		return"FR_DENIED";
	break;
	case FR_EXIST:
		return"FR_EXIST";
	break;
	case FR_INVALID_OBJECT:
		return"FR_INVALID_OBJECT";
	break;
	case FR_WRITE_PROTECTED:
		return"FR_WRITE_PROTECTED";
	break;
	case FR_INVALID_DRIVE:
		return"FR_INVALID_DRIVE";
	break;
	case FR_NOT_ENABLED:
		return"FR_NOT_ENABLED";
	break;
	case FR_NO_FILESYSTEM:
		return"FR_NO_FILESYSTEM";
	break;
	case FR_MKFS_ABORTED:
		return"FR_MKFS_ABORTED";
	break;
	case FR_TIMEOUT:
		return"FR_TIMEOUT";
	break;
	case FR_LOCKED:
		return"FR_LOCKED";
	break;
	case FR_NOT_ENOUGH_CORE:
		return"FR_NOT_ENOUGH_CORE";
	break;
	case FR_TOO_MANY_OPEN_FILES:
		return"FR_TOO_MANY_OPEN_FILES";
	break;
	case FR_INVALID_PARAMETER:
		return"FR_INVALID_PARAMETER";
	break;
	default:
		return"Invalid result";
	break;
	}
}

void ScreenPrintWord(uint32_t word)
{
    char buffer[9];
	unsigned char byte0 =  word & 0xFF;
	unsigned char byte1 = (word & 0xFF00) >> 8;
	unsigned char byte2 = (word & 0xFF0000) >> 16;
	unsigned char byte3 = (word & 0xFF000000) >> 24;

	ByteToHex(byte3, buffer + 0);
	ByteToHex(byte2, buffer + 2);
	ByteToHex(byte1, buffer + 4);
	ByteToHex(byte0, buffer + 6);

	ScreenPrint(buffer);
}

void ScreenPrintHWord(uint16_t hword)
{
	char buffer[5];
	unsigned char byte0 = hword & 0x00FF;
	unsigned char byte1 = (hword & 0xFF00) >> 8;

	ByteToHex(byte1, buffer + 0);
	ByteToHex(byte0, buffer + 2);

	ScreenPrint(buffer);
}

void ScreenPrintByte(unsigned char byte)
{
	char buffer[3];
	ByteToHex(byte, buffer);
	ScreenPrint(buffer);
}

const char* ByteToHex(unsigned char byte, char* buffer)
{
	unsigned char nibble0 = byte & 0x0F;
	unsigned char nibble1 = (byte & 0xF0) >> 4;

	if(nibble0 < 10) buffer[1] = '0' + nibble0;
	else 			 buffer[1] = 'A' + nibble0 - 10;

	if(nibble1 < 10) buffer[0] = '0' + nibble1;
	else 			 buffer[0] = 'A' + nibble1 - 10;
	
	buffer[2] = '\0';
	return buffer;
}

void ScreenPrint(const char* text)
{
	static int x = 5;
	static int y = 5;
	Hapi::DrawText(">", x - 4, y, 100);
	Hapi::DrawText(text, x, y, 1000000);
	Hapi::EndDrawing();

	Hapi::DrawText(">", x - 4, y, 100);
	Hapi::DrawText(text, x, y, 1000000);
	Hapi::EndDrawing();

	y += 6;
	if (y >= 230)
	{
		y = 5;
		x += 35;
	}
}


void ScreenPrintResult(FRESULT fatfsResult)
{
	ScreenPrint(FRESULTToString(fatfsResult));
}