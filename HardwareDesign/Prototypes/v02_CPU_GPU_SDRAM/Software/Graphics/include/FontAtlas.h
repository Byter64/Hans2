#pragma once
#include <map>
#include <string>
#include "Rectangle.h"

namespace Hapi
{
	struct FontAtlas
	{
		std::map<char, Rectangle> atlas;

		/// <summary>
		/// Add an entry to the font atlas
		/// </summary>
		/// <param name="character">The character which this entry represents</param>
		/// <param name="position">The position and the size of the glyph in the fontatlas. The origin is top-left</param>
		void Add(char character, Rectangle position);

		const Rectangle& operator[](char character);
	};
}