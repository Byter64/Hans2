#include "FontAtlas.h"

void Text::FontAtlas::Add(char character, Rectangle position)
{
	atlas[character] = position;
}

const Text::Rectangle& Text::FontAtlas::operator[](char character)
{
	return atlas[character];
}
