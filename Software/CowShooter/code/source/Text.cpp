#include "Text.h"
#include "fonts/shortenedFont.h"
#include <Hall/Hall.h>
#include "FontAtlas.h"

static Text::FontAtlas atlas = {0};
Text::Font Text::defaultFont;
static Text::Font LoadMiniFont()
{
	for (char i = 0; i < 26; i++) atlas.Add('A' + i, { i * 3, 0, 3, 4 });
	for (char i = 0; i < 26; i++) atlas.Add('a' + i, { i * 3, 0, 3, 4 });
	
	for (char i = 1; i < 10; i++) atlas.Add('0' + i, { (i + 26 - 1) * 3, 0, 3, 4 });
	atlas.Add('0', { 35 * 3, 0, 3, 4 });
	atlas.Add('!', { 36 * 3, 0, 3, 4 });
	atlas.Add('?', { 37 * 3, 0, 3, 4 });
	atlas.Add('.', { 38 * 3, 0, 3, 4 });
	atlas.Add(':', { 39 * 3, 0, 3, 4 });

	atlas.Add(' ', { -1, -1, 3, 4 });

	return Text::LoadFont((char*)shortenedFont, 120, 5, &atlas);
}

int Text::Init()
{
	defaultFont = LoadMiniFont();
	return 0;
}

Text::Font Text::LoadFont(char* start, int width, int height, FontAtlas* fontatlas)
{
	Font font = {start, width, height, fontatlas };
	return font;
}

void Text::DrawText(const char* text, Font font, int posX, int posY, unsigned int maxWidth)
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
			while(Hall::GetIsGPUBusy());
			Hall::Draw((unsigned short*)font.fontSheet, rect.x, rect.y, posX, posY, rect.width, rect.height, font.fontSheetWidth);
		}
		posX += charSize;
	}
}

void Text::DrawText(const char* text, int posX, int posY, unsigned int maxWidth)
{
	DrawText(text, defaultFont, posX, posY, maxWidth);
}