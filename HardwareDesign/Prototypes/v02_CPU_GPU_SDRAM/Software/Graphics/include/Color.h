#pragma once
#include <stdint.h>

#ifdef DESKTOP
extern "C"
{
	#include "raylib.h"
}
#endif // Desktop

namespace Hapi
{
	/// <summary>
	/// Color is stored as R5G5B5A1, so with 5 Bits per channel + 1 Bit for transparency
	/// </summary>
	class Color
	{
		uint16_t color;
		unsigned char red;        // Color red value
		unsigned char green;      // Color green value
		unsigned char blue;       // Color blue value
		bool alpha;               // Transparency bit. 0 == transparent, 1 == opaque

	public:
		Color(unsigned char red, unsigned char green, unsigned char blue, bool alpha);

		void SetRed(unsigned char red);
		void SetGreen(unsigned char green);
		void SetBlue(unsigned char blue);
		void SetAlpha(bool alpha);
		void SetColor(unsigned char red, unsigned char green, unsigned char blue);
		void SetColor(unsigned char red, unsigned char green, unsigned char blue, bool alpha);
		void SetColor16(uint16_t color);

		unsigned char GetRed();
		unsigned char GetGreen();
		unsigned char GetBlue();
		bool GetAlpha();
		uint16_t GetColor();

#ifdef DESKTOP
		::Color ToRaylib();
#endif // DESKTOP
	};
}