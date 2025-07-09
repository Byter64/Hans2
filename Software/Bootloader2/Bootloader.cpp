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
	glyphs['0'] = {40, 5};

   glyphs['\\'] = {104, 0};
	glyphs['/'] = {108, 0};
	glyphs['<'] = {112, 0};
	glyphs['>'] = {116, 0};

	glyphs['!'] = {44, 5};
	glyphs['"'] = {48, 5};
	glyphs['$'] = {52, 5};
	glyphs['%'] = {56, 5};
	glyphs['^'] = {60, 5};
	glyphs['*'] = {64, 5};
	glyphs['('] = {68, 5};
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

int main()
{
	Hall::Init();
	InitGlyphs();

	Hall::SetImage((const Hall::Color*)Assets::minifont5x3, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetExcerpt(0, 0, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetScreenPosition(10, 10);
	Hall::Draw();

	DrawText("Hallo!\n>> Ich bin ein Text :D", 10, 100);
	DrawText("Hallo!\n>> Ich bin ein anderer Text :D\n>> Kannst du mich lesen?", 10, 120);

	char buffer[32];
	char* number = ToString(-988776655, buffer, 32);
	DrawText(number, 150, 10);
	number = ToString(testNumber, buffer, 32);
	DrawText(number, 150, 20);
	number = ToString(testNumber2, buffer, 32);
	DrawText(number, 150, 30);

	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();



	while(true);
	return 0;
}