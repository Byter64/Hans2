#include <Hall/Hall.h>
#include "Assets/include/fonts/minifont5x3.h"
#include "Helper.h"

struct Rect
{
	unsigned char x, y;
	static const unsigned char width = 3;
	static const unsigned char height = 5;
};

Rect glyphs[128];

void InitGlyphs()
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

void Print(const char* text)
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