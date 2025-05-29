#include "FontAtlas.h"

void Hapi::FontAtlas::Add(char character, Rectangle position)
{
	atlas[character] = position;
}

const Hapi::Rectangle& Hapi::FontAtlas::operator[](char character)
{
	return atlas[character];
}
