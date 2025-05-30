#pragma once
#include <stdint.h>

namespace Hall
{
	const int SCREEN_HEIGHT = 240;
	const int SCREEN_WIDTH = 400;

	/// <summary>
	/// Draws an excerpt of the given data onto the screen. All coordinates describe the top-left corner
	/// </summary>
	/// <param name="data">A pointer to the first pixel of an image</param>
	/// <param name="xOffset">The x offset within that image</param>
	/// <param name="yOffset">The y offset within that image</param>
	/// <param name="screenX">The x position on screen.</param>
	/// <param name="screenY">The y position on screen.</param>
	/// <param name="width">The width of the excerpt</param>
	/// <param name="height">The height of the excerpt</param>
	/// <param name="dataWidth">The width of the image (NOT EXCERPT)</param>
	void Draw(unsigned short* data, unsigned short xOffset, unsigned short yOffset, unsigned short screenX, unsigned short screenY, unsigned short width, unsigned short height, unsigned short dataWidth);

	/// <summary>
	/// Clears the whole screen with the given color
	/// </summary>
	/// <param name="color">The format is 5R5G5B1A, with the alpha bit being lsb</param>
	void Clear(unsigned short color);

	void SetData(unsigned short* data);
	void SetXOffset(unsigned short xOffset);
	void SetYOffset(unsigned short yOffset);
	void SetImageWidth(unsigned short imageWidth);
	void SetWidth(unsigned short width);
	void SetHeight(unsigned short height);
	void SetScreenX(unsigned short x);
	void SetScreenY(unsigned short y);
	void SetClearColor(unsigned short color);
	void SetCommandDraw();
	void SetCommandClear();
	void SetCommandSwapBuffers();

	bool GetIsGPUBusy();
	bool GetVSync();
	bool GetHSync();
}