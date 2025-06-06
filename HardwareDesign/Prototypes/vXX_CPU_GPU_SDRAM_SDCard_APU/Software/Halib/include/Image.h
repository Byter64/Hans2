#pragma once
#include "Hapi.h"
#include "Veci2.h"

namespace Halib
{
	struct Image
	{
		Image() = default;
		Image(const uint16_t* data, Veci2 imageSize);

		void Draw(Veci2 position) const;

		/// <summary>
		/// Draws an excerpt from the image
		/// </summary>
		/// <param name="position"></param>
		/// <param name="framePos">Top left of the excerpt in the image</param>
		/// <param name="frameSize">size of the excerpt</param>
		void Draw(Veci2 position, Veci2 framePos, Veci2 frameSize) const;

		void SetImage(char* data, Veci2 imageSize);
		Hapi::Image GetImage() const;

		Veci2 GetImageSize() const;
		uint16_t* GetRawData();

	protected:
		Hapi::Image image = -1;
		Veci2 imageSize;
		uint16_t* rawData;
	};
}