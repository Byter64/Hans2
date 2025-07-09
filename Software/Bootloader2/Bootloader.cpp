//I have to check, that .data and .bss is properly initialised.
//If any changes made to the linker script, they must be also added to the software template
#include <Hall/Hall.h>
#include "Assets/include/fonts/minifont5x3.h"

struct Rect
{
	unsigned char x, y;
	unsigned char width, height;
};

Rect glyphs[128];

static void InitGlyphs()
{
	for(int i = 0; i < 128; i++)
	{
		glyphs[i] = {104, 5, 3, 5}; //This draws a '.' for unkown glyphs
	}

	for(unsigned char c = 'a'; c <= 'z'; c++)
		glyphs[c] = {(unsigned char)(c * 4), 0, 3, 5};
	for(unsigned char c = 'A'; c <= 'Z'; c++)
		glyphs[c] = {(unsigned char)(c * 4), 0, 3, 5};
	for(unsigned char c = '1'; c <= '9'; c++)
		glyphs[c] = {(unsigned char)(c * 4), 5, 3, 5};
	glyphs['0'] = {40, 5, 3, 5};

   glyphs['\\'] = {104, 0, 3, 5};
	glyphs['/'] = {108, 0, 3, 5};
	glyphs['<'] = {112, 0, 3, 5};
	glyphs['>'] = {116, 0, 3, 5};

	glyphs['!'] = {44, 5, 3, 5};
	glyphs['"'] = {48, 5, 3, 5};
	glyphs['$'] = {52, 5, 3, 5};
	glyphs['%'] = {56, 5, 3, 5};
	glyphs['^'] = {60, 5, 3, 5};
	glyphs['*'] = {64, 5, 3, 5};
	glyphs['('] = {68, 5, 3, 5};
	glyphs['`'] = {72, 5, 3, 5};
   glyphs['\''] = {76, 5, 3, 5};
	glyphs['-'] = {80, 5, 3, 5};
	glyphs['='] = {84, 5, 3, 5};
	glyphs['_'] = {88, 5, 3, 5};
	glyphs['+'] = {92, 5, 3, 5};
	glyphs['?'] = {96, 5, 3, 5};
	glyphs['|'] = {100, 5, 3, 5};
	glyphs['.'] = {104, 5, 3, 5};
	glyphs[','] = {108, 5, 3, 5};
	glyphs[':'] = {112, 5, 3, 5};
	glyphs[';'] = {116, 5, 3, 5};
}

static void DrawText(const char* text, int x, int y)
{
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
			continue;
		}

		while(Hall::GetIsGPUBusy());
		Hall::SetExcerpt(rect.x, rect.y, rect.width, rect.height);
		Hall::SetScreenPosition(x, y);
		Hall::Draw();

		x += rect.width + 1;
	}
}

int main()
{
	Hall::Init();
	InitGlyphs();

	Hall::SetImage((const Hall::Color*)Assets::minifont5x3, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetExcerpt(0, 0, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetScreenPosition(10, 10);
	Hall::Draw();

	DrawText("Hallo!\n >> Ich bin ein Text :D", 10, 100);

	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();



	while(true);
	return 0;
}