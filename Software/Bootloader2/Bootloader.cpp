//I have to check, that .data and .bss is properly initialised.
//If any changes made to the linker script, they must be also added to the software template
#include <Hall/Hall.h>
#include "Assets/include/fonts/minifont5x3.h"

extern "C" 
{
	#include "elfload/elfload.h"
}
#include "ff.h"

struct Rect
{
	unsigned char x, y;
	static const unsigned char width = 3;
	static const unsigned char height = 5;
};

Rect glyphs[128];
FIL elfFile;
void* loadAddress = 0;

static void InitGlyphs()
{
	for(int i = 0; i < 128; i++)
	{
		glyphs[i] = {104, 5}; //This draws a '.' for unkown glyphs
	}

	for(unsigned char i = 0; i < 26; i++)
		glyphs['a' + i] = {(unsigned char)(i * 4), 0};
	for(unsigned char i = 0; i < 26; i++)
		glyphs['A' + i] = {(unsigned char)(i * 4), 0};
	for(unsigned char i = 0; i < 9; i++)
		glyphs['1' + i] = {(unsigned char)(i * 4), 5};
	glyphs['0'] = {36, 5};

   glyphs['\\'] = {104, 0};
	glyphs['/'] = {108, 0};
	glyphs['<'] = {112, 0};
	glyphs['>'] = {116, 0};

	glyphs['!'] = {40, 5};
	glyphs['"'] = {44, 5};
	glyphs['$'] = {48, 5};
	glyphs['%'] = {52, 5};
	glyphs['^'] = {56, 5};
	glyphs['*'] = {60, 5};
	glyphs['('] = {64, 5};
	glyphs[')'] = {68, 5};
	glyphs['`'] = {72, 5};
   glyphs['\''] = {76, 5};
	glyphs['-'] = {80, 5};
	glyphs['='] = {84, 5};
	glyphs['_'] = {88, 5};
	glyphs['+'] = {92, 5};
	glyphs['?'] = {96, 5};
	glyphs['|'] = {100, 5};
	glyphs['.'] = {104, 5};
	glyphs[','] = {108, 5};
	glyphs[':'] = {112, 5};
	glyphs[';'] = {116, 5};
}

static void DrawText(const char* text, int x, int y)
{
	int startX = x;
	while(Hall::GetIsGPUBusy());
	Hall::SetImage((const Hall::Color*)Assets::minifont5x3, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);

	for(const char* c = text; *c != '\0'; c++)
	{
		char symbol = *c;
		const Rect& rect = glyphs[*c];
		if(symbol == ' ')
		{
			x += rect.width + 1;
			continue;
		}
		if(symbol == '\n')
		{
			y += rect.height + 1;
			x = startX;
			continue;
		}

		while(Hall::GetIsGPUBusy());
		Hall::SetExcerpt(rect.x, rect.y, rect.width, rect.height);
		Hall::SetScreenPosition(x, y);
		Hall::Draw();

		x += rect.width + 1;
	}
}

static void Print(const char* text)
{
	static int x = 5;
	static int y = 5;
	DrawText(">", x - 4, y);
	DrawText(text, x, y);
	
	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();

	DrawText(">", x - 4, y);
	DrawText(text, x, y);
	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();

	y += 6;
	if (y >= 190)
	{
		y = 5;
		x += 70;
	}
}


/// @brief 
/// @param number 
/// @param buffer 
/// @param bufferSize 
/// @return A pointer to the first valid char within the given buffer
static char* ToString(int number, char* buffer, int bufferSize)
{
	buffer[bufferSize - 1] = '\0';
	bufferSize--;

	bool isNegative = false;
	if(number < 0)
	{
		number = -number;
		isNegative = true;
	}

	char chars[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	do
	{
		int digit = number % 10;
		buffer[bufferSize - 1] = chars[digit];
		bufferSize--;

		number = number / 10;
	} while(number != 0 && bufferSize > 0);
	
	if(isNegative && bufferSize > 0)
	{
		buffer[bufferSize - 1] = '-';
		bufferSize--;
	}

	return buffer + bufferSize;
}

static bool fileRead(el_ctx* ctx, void* dest, size_t nb, size_t offset)
{
	if (f_lseek(&elfFile, offset))
		return false;

	unsigned int bytesRead;
	if (f_read(&elfFile, dest, nb, &bytesRead))
		return false;

	return true;
}

static void* memoryAllocation(el_ctx* ctx, Elf_Addr physicalAddress, Elf_Addr virtualAddress, Elf_Addr size)
{
	//This is what the example does, but I don't know why one can just return the virtual address
	return (void*)physicalAddress;
}

int testNumber;
int testNumber2 = 313445;

extern FATFS FatFs;
extern BYTE is_mounted;

int main()
{
	Hall::Init();
	InitGlyphs();
	static const int BUFFER_SIZE = 64;
	char buffer[BUFFER_SIZE];

	Hall::SetImage((const Hall::Color*)Assets::minifont5x3, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetExcerpt(0, 0, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetScreenPosition(280, 10);
	Hall::Draw();
	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();

	Hall::Draw();
	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();

	Print("Kannst du mich lesen?");

	Print("Ist das -988006655?");
	char* number = ToString(-988006655, buffer, BUFFER_SIZE);
	Print(number);
	number = ToString(testNumber, buffer, BUFFER_SIZE);
	Print("Ist das 0?");
	Print(number);
	number = ToString(testNumber2, buffer, BUFFER_SIZE);
	Print("Ist das 313445?");
	Print(number);

	//###################################
	//Finding the elf
	//###################################

	FRESULT fatfsResult;
	
	Print("Mounting SD-Card...");
	
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;
	
	if(fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		while(true);
	}
	Print(ToString(fatfsResult, buffer, BUFFER_SIZE));

	Print("Searching *.elf...");
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");

	if(fileInfo.fname[0] == '\0' || fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		Print("No .elf found");
		while(true);
	}
	
	if(fatfsResult != FR_OK) while(true);

	char elfFilePath[16] = "/";
	char debugMessage[32] = "Opening ";
	int i;
	for(i = 0; fileInfo.fname[i] != '\0'; i++)
	{
		elfFilePath[i + 1] = fileInfo.fname[i];
		debugMessage[i + 8] = fileInfo.fname[i];
	}
	elfFilePath[i + 1] = '\0';
	debugMessage[i + 8] = '.';
	debugMessage[i + 9] = '.';
	debugMessage[i + 10] = '.';
	debugMessage[i + 11] = '\0';
	Print(debugMessage);

	fatfsResult = f_open(&elfFile, elfFilePath, FA_READ);
	if(fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		Print("Open failed");
		while(true);
	}
	Print("Open succeeded");

	//################################
	//Loading the elf
	//################################
	el_ctx ctx;
	ctx.pread = fileRead;
	
	Print("Initialising elfloader...");
	el_status result = el_init(&ctx);
	if(result)
	{
		Print("Init FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	Print("Loading .elf file...");
	result = el_load(&ctx, memoryAllocation);
	if(result)
	{
		Print("Load FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}

	Print("Resolving relocations...");
	result = el_relocate(&ctx);
	if(result)
	{
		Print("Relocs FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}

	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;

	Print("Succeeded. What a journey man, Have fun :)");
	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();
	Print("This should not be readable!");

	while(true);
	return 0;
}