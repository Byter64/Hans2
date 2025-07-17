#include "Hapi.h"
#include "../../../Assets/include/fonts/minifont5x3.h"
#include <stdlib.h>
#include "../../../Hall-main/include/Hall/Hall.h"

static Hapi::FontAtlas atlas = {0};
Hapi::Font Hapi::defaultFont;
static Hapi::Font LoadMiniFont()
{
	for (char i = 0; i < 26; i++) atlas.Add('A' + i, { (short)(i * 4), 0, 3, 5 });
	atlas.Add('[', { 26 * 4, 0, 3, 5 });
	atlas.Add(']', { 27 * 4, 0, 3, 5 });
	atlas.Add('{', { 28 * 4, 0, 3, 5 });
	atlas.Add('}', { 29 * 4, 0, 3, 5 });
	
	for (char i = 0; i < 26; i++) atlas.Add('a' + i, { short(i * 4), 0, 3, 5 });
	atlas.Add('\\', { 26 * 4, 0, 3, 5 });
	atlas.Add('/', { 27 * 4, 0, 3, 5 });
	atlas.Add('<', { 28 * 4, 0, 3, 5 });
	atlas.Add('>', { 29 * 4, 0, 3, 5 });

	for (char i = 1; i < 10; i++) atlas.Add('0' + i, { short((i - 1) * 4), 5, 3, 5 });
	atlas.Add('0', { 9 * 4, 5, 3, 5 });
	atlas.Add('!', { 10 * 4, 5, 3, 5 });
	atlas.Add('"', { 11 * 4, 5, 3, 5 });
	atlas.Add('$', { 12 * 4, 5, 3, 5 });
	atlas.Add('%', { 13 * 4, 5, 3, 5 });
	atlas.Add('^', { 14 * 4, 5, 3, 5 });
	atlas.Add('*', { 15 * 4, 5, 3, 5 });
	atlas.Add('(', { 16 * 4, 5, 3, 5 });
	atlas.Add(')', { 17 * 4, 5, 3, 5 });
	atlas.Add('`', { 18 * 4, 5, 3, 5 });
	atlas.Add('\'', { 19 * 4, 5, 3, 5 });
	atlas.Add('-', { 20 * 4, 5, 3, 5 });
	atlas.Add('=', { 21 * 4, 5, 3, 5 });
	atlas.Add('_', { 22 * 4, 5, 3, 5 });
	atlas.Add('+', { 23 * 4, 5, 3, 5 });
	atlas.Add('?', { 24 * 4, 5, 3, 5 });
	atlas.Add('|', { 25 * 4, 5, 3, 5 });
	atlas.Add('.', { 26 * 4, 5, 3, 5 });
	atlas.Add(',', { 27 * 4, 5, 3, 5 });
	atlas.Add(':', { 28 * 4, 5, 3, 5 });
	atlas.Add(';', { 29 * 4, 5, 3, 5 });

	atlas.Add(' ', { -1, -1, 3, 5 });

	return Hapi::LoadFont((char*)Assets::minifont5x3, 120, 15, &atlas);
}

int Hapi::Init()
{
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
	while (Hall::GetIsGPUBusy());
}

void Hapi::EndDrawing()
{
	WaitForGPU();
	bool vSync = false;
	bool newVSync = false;
	while(!(!vSync && newVSync))
	{
		vSync = newVSync;
		newVSync = Hall::GetVSync();
	}
	Hall::SetCommandSwapBuffers();
}

void Hapi::Draw(Image image, int ssX, int ssY, int x, int y, int width, int height, int image_width)
{
	WaitForGPU();
	Hall::Draw((Hall::Color*)image, ssX, ssY, x, y, width, height, image_width);
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

	Hall::Clear(color.GetColor());
}

void Hapi::SetTargetFPS(int fps)
{

}

void Hapi::SetVSync(bool vSync)
{
	//We don't support this anymore
	//*VSYNC_BUFFER_SWAP = vSync;
}
