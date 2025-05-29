#include "Hapi.h"
#include "../../../Assets/include/fonts/minifont5x3.h"
#include <stdlib.h>

volatile char* GPU_BLOCK = (char*)0x02000000;
volatile int* GPU_IMAGE_START = (int*)(GPU_BLOCK + 0);
volatile int* GPU_IMAGE_X = (int*)(GPU_BLOCK + 4);
volatile int* GPU_IMAGE_Y = (int*)(GPU_BLOCK + 8);
volatile int* GPU_IMAGE_WIDTH = (int*)(GPU_BLOCK + 12);
volatile int* GPU_EXCERPT_WIDTH = (int*)(GPU_BLOCK + 16);
volatile int* GPU_EXCERPT_HEIGHT = (int*)(GPU_BLOCK + 20);
volatile int* GPU_SCREEN_X = (int*)(GPU_BLOCK + 24);
volatile int* GPU_SCREEN_Y = (int*)(GPU_BLOCK + 28);
volatile int* GPU_CLEAR_COLOR = (int*)(GPU_BLOCK + 32);
volatile int* GPU_COMMAND_DRAW = (int*)(GPU_BLOCK + 36);
volatile int* GPU_COMMAND_CLEAR = (int*)(GPU_BLOCK + 40);
volatile int* GPU_IS_BUSY = (int*)(GPU_BLOCK + 44);

volatile int* GPU_VSYNC = (int*)(GPU_BLOCK + 48);
volatile int* GPU_HSYNC = (int*)(GPU_BLOCK + 52);

volatile int* GPU_COMMAND_SWAP_BUFFERS = (int*)(GPU_BLOCK + 56);
volatile int* VSYNC_BUFFER_SWAP = (int*)(GPU_BLOCK + 60);


static Hapi::FontAtlas* atlas;
Hapi::Font Hapi::defaultFont;
static Hapi::Font LoadMiniFont()
{
	for (char i = 0; i < 26; i++) atlas->Add('A' + i, { i * 4, 0, 3, 5 });
	atlas->Add('[', { 26 * 4, 0, 3, 5 });
	atlas->Add(']', { 27 * 4, 0, 3, 5 });
	atlas->Add('{', { 28 * 4, 0, 3, 5 });
	atlas->Add('}', { 29 * 4, 0, 3, 5 });
	
	for (char i = 0; i < 26; i++) atlas->Add('a' + i, { i * 4, 5, 3, 5 });
	atlas->Add('\\', { 26 * 4, 5, 3, 5 });
	atlas->Add('/', { 27 * 4, 5, 3, 5 });
	atlas->Add('<', { 28 * 4, 5, 3, 5 });
	atlas->Add('>', { 29 * 4, 5, 3, 5 });

	for (char i = 1; i < 10; i++) atlas->Add('0' + i, { (i - 1) * 4, 10, 3, 5 });
	atlas->Add('0', { 9 * 4, 10, 3, 5 });
	atlas->Add('!', { 10 * 4, 10, 3, 5 });
	atlas->Add('"', { 11 * 4, 10, 3, 5 });
	atlas->Add('$', { 12 * 4, 10, 3, 5 });
	atlas->Add('%', { 13 * 4, 10, 3, 5 });
	atlas->Add('^', { 14 * 4, 10, 3, 5 });
	atlas->Add('*', { 15 * 4, 10, 3, 5 });
	atlas->Add('(', { 16 * 4, 10, 3, 5 });
	atlas->Add(')', { 17 * 4, 10, 3, 5 });
	atlas->Add('`', { 18 * 4, 10, 3, 5 });
	atlas->Add('\'', { 19 * 4, 10, 3, 5 });
	atlas->Add('-', { 20 * 4, 10, 3, 5 });
	atlas->Add('=', { 21 * 4, 10, 3, 5 });
	atlas->Add('_', { 22 * 4, 10, 3, 5 });
	atlas->Add('+', { 23 * 4, 10, 3, 5 });
	atlas->Add('?', { 24 * 4, 10, 3, 5 });
	atlas->Add('|', { 25 * 4, 10, 3, 5 });
	atlas->Add('.', { 26 * 4, 10, 3, 5 });
	atlas->Add(',', { 27 * 4, 10, 3, 5 });
	atlas->Add(':', { 28 * 4, 10, 3, 5 });
	atlas->Add(';', { 29 * 4, 10, 3, 5 });

	atlas->Add(' ', { -1, -1, 3, 5 });

	return Hapi::LoadFont((char*)Assets::minifont5x3, 120, 15, atlas);
}

int Hapi::Init()
{
	atlas = (FontAtlas*)(sizeof(FontAtlas));
	defaultFont = LoadMiniFont();
	return 0;
}

int Hapi::Terminate()
{
	return 0;
}

bool Hapi::ShouldClose()
{
	return false;
}

Hapi::Image Hapi::LoadImage(char* start, int width, int height)
{
	Image image = (Image)start;
	return image;
}

void Hapi::UpdateImage(Image image, char* start, int width, int height)
{
	//Because CPU and GPU share the same RAM, nothing needs to be done here
}

void Hapi::UnloadImage(Image image)
{
	//imageData.erase(image);
}


Hapi::Font Hapi::LoadFont(char* start, int width, int height, FontAtlas* fontatlas)
{
	Font font = {start, width, height, fontatlas };
	return font;
}

void Hapi::UnloadFont(Font font)
{
	//fontData.erase(font);
}

void Hapi::StartDrawing()
{

}

static void WaitForGPU()
{
	volatile int* isGPUBusy = (int*)(GPU_IS_BUSY);
	while (*isGPUBusy);
}

void Hapi::EndDrawing()
{
	WaitForGPU();
	*GPU_COMMAND_SWAP_BUFFERS = true;
	while (!*GPU_VSYNC);
}

void Hapi::Draw(Image image, int ssX, int ssY, int x, int y, int width, int height, int image_width)
{
	WaitForGPU();
	*GPU_IMAGE_START = image;
	*GPU_IMAGE_X = ssX;
	*GPU_IMAGE_Y = ssY;
	*GPU_IMAGE_WIDTH = image_width;
	*GPU_EXCERPT_WIDTH = width;
	*GPU_EXCERPT_HEIGHT = height;
	*GPU_SCREEN_X = x;
	*GPU_SCREEN_Y = y;
	*GPU_COMMAND_DRAW = true;
}

void Hapi::DrawText(const char* text, Font font, int posX, int posY, unsigned int maxWidth)
{
	int startX = posX;
	FontAtlas* atlas = font.atlas;

	for (; *text != '\0'; text++)
	{
		if(*text >= 128)
		{
			posX += atlas->atlas['a'].width;
			continue;
		}
		const Rectangle& rect = atlas->atlas[*text];
		int charSize = rect.width + 1;

		if ((posX + charSize) - startX >= maxWidth)
		{
			posX = startX;
			posY += rect.height + 1;
		}

		if (*text != ' ')
		{
			WaitForGPU();
			Draw((Hapi::Image)font.fontSheet, rect.x, rect.y, posX, posY, rect.width, rect.height, font.fontSheetWidth);
		}
		posX += charSize;
	}
}

void Hapi::DrawText(const char* text, int posX, int posY, unsigned int maxWidth)
{
	DrawText(text, defaultFont, posX, posY, maxWidth);
}

void Hapi::Clear(Color color)
{
	WaitForGPU();

	*GPU_CLEAR_COLOR = color.GetColor();
	*GPU_COMMAND_CLEAR = true;
}

void Hapi::SetTargetFPS(int fps)
{

}

void Hapi::SetVSync(bool vSync)
{
	*VSYNC_BUFFER_SWAP = vSync;
}
