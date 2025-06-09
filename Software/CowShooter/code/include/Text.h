#pragma once
#include "FontAtlas.h"

namespace Text
{
    struct Font
	{
		char* fontSheet;
		int fontSheetWidth;
		int fontSheetHeight;
		FontAtlas* atlas;
	};

    extern Font defaultFont;

    int Init();
    Font LoadFont(char* start, int width, int height, FontAtlas* fontatlas);
    void DrawText(const char* text, int posX, int posY, unsigned int maxWidth);
    void DrawText(const char* text, Font font, int posX, int posY, unsigned int maxWidth);
};