#pragma once
#include "Rectangle.h"
#include <stdint.h>

namespace Hapi
{
	struct FontAtlas
	{
		Rectangle atlas[256];

		/// <summary>
		/// Add an entry to the font atlas
		/// </summary>
		/// <param name="character">The character which this entry represents</param>
		/// <param name="position">The position and the size of the glyph in the fontatlas. The origin is top-left</param>
		void Add(char character, Rectangle position);

		const Rectangle& operator[](char character);
	};
}