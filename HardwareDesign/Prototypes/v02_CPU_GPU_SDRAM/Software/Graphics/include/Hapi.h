#pragma once
#include <stdint.h>
#include "Color.h"
#include "FontAtlas.h"

namespace Hapi
{
	typedef uint32_t Image;
	struct Font
	{
		char* fontSheet;
		int fontSheetWidth;
		int fontSheetHeight;
		FontAtlas* atlas;
	};

	const int SCREEN_WIDTH = 400;
	const int SCREEN_HEIGHT = 240;

	/// <summary>Initializes the graphical backend 
	/// </summary>
	/// <returns>0 on success or error index at failure</returns>
	int Init();

	/// <summary> Deinitializes the graphical backend
	/// </summary>
	/// <returns>0 on success or error index at failure</returns>
	int Terminate();

	/// <summary>
	/// Checks if the application is requested to close itself
	/// </summary>
	/// <returns>true if should close itself, else false</returns>
	bool ShouldClose();

	/// <summary>
	/// Loads the given image and returns an ID that is unique to this image
	/// </summary>
	/// <param name="start">The start of the image</param>
	/// <param name="width">The width in pixels of the image</param>
	/// <param name="height">The height in pixels of the image</param>
	/// <returns>An ID for this image</returns>
	Image LoadImage(char* start, int width, int height);

	void UpdateImage(Image image, char* start, int width, int height);

	/// <summary>
	/// Unloads the given image
	/// </summary>
	/// <param name="image"></param>
	void UnloadImage(Image image);

	/// <summary>
	/// Loads the given font and returns an ID that is unique to this font
	/// </summary>
	/// <param name="start">The start of the font sheet</param>
	/// <param name="width">The width in pixels of the font</param>
	/// <param name="height">The height in pixels of the font</param>
	/// <returns>An ID for this image</returns>
	Font LoadFont(char* start, int width, int height, FontAtlas* fontatlas);

	void UnloadFont(Font font);

	void StartDrawing();

	void EndDrawing();

	void Draw(Image image, int ssX, int ssY, int x, int y, int width, int height, int image_width);

	/// <summary>
	/// Draw text. The text is always left aligned
	/// </summary>
	/// <param name="text">The text to be drawn</param>
	/// <param name="font">The font in which the text will be drawn</param>
	/// <param name="fontSheetWidth">The width of the font sheet in pixels</param>
	/// <param name="fontSheetHeight">The height of the font sheet in pixels</param>
	/// <param name="posX">The left border</param>
	/// <param name="posY">The top border of the text</param>
	/// <param name="maxWidth">The maximum text box width. If text exceeds this width, it will wrap into a new line.</param>
	void DrawText(const char* text, Font font, int posX, int posY, unsigned int maxWidth);

	/// <summary>
	/// Draw text. The text is always left aligned
	/// </summary>
	/// <param name="text">The text to be drawn</param>
	/// <param name="posX">The left border</param>
	/// <param name="posY">The top border of the text</param>
	/// <param name="maxWidth">The maximum text box width. If text exceeds this width, it will wrap into a new line.</param>
	void DrawText(const char* text, int posX, int posY, unsigned int maxWidth);


	/// <summary>
	/// Clears the whole screen with the given color
	/// </summary>
	/// <param name="color"></param>
	void Clear(Color color);

	void SetTargetFPS(int fps);

	/// <summary>
	/// Sets V-Synchronisation. If vSync is activated, the fps should be only set to a divider of 60 for smoother video
	/// </summary>
	/// <param name="vSync"></param>
	void SetVSync(bool vSync);
}