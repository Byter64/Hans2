#pragma once

namespace Hall
{
	typedef unsigned short Color;
	typedef unsigned int   IndexContainer;

	static Color* const COLOR_TABLE_MEMORY = (Color*)0x02002000;

	enum CTType  //Color table type
	{
		NONE   = 0b0, //Disables color tables. The image data is interpreted as a color array
	    BIT_1  = 0b100001, //Interprets the image data as array of 1-Bit indices into a color table
	    BIT_2  = 0b100010, //Interprets the image data as array of 2-Bit indices into a color table
	    BIT_4  = 0b100100, //Interprets the image data as array of 4-Bit indices into a color table
	    BIT_8  = 0b101000, //Interprets the image data as array of 8-Bit indices into a color table
	    BIT_16 = 0b110000 //Interprets the image data as array of 16-Bit indices into a color table
	};

	enum Shape 
	{
		RECTANGLE = 0,
		LINE      = 1
	};

	enum ColorSource
	{
		MEMORY = 0, //Takes the image data from the given memory address
		COLOR = 1   //Takes the image data from the given color
	};


	const int SCREEN_HEIGHT = 240;
	const int SCREEN_WIDTH = 400;

	/// @brief
	/// @param image A pointer to the first pixel of the image
	/// @param imageWidth The width of the image in pixels
	void SetImage(const Color* image, unsigned short imageWidth);

	/// @brief
	/// @param image A pointer to the first pixel of the image
	/// @param imageWidth The width of the image in pixels
	void SetImage(const IndexContainer* image, unsigned short imageWidth);


	/// @brief Sets the x and y position of the excerpt of the image that will be drawn
	/// @param x The x position within the image
	/// @param y The y position within the imagae
	void SetExcerpt(short x, short y);

	/// @brief Sets the excerpt of the image that will be drawn
	/// @param x The x position within the image
	/// @param y The y position within the imagae
	/// @param width The width of the excerpt
	/// @param height The height of the excerpt
	void SetExcerpt(short x, short y, short width, short height);

	/// @brief Sets the scale. Positive values are interpreted as factors. Negative values are interpreted as their positive reciprocal. E.g. -2 <=> factor of 1/2, -10 <=> factor of 1/10
	/// @param x The scale in x-direction
	/// @param y The scale in y-direction
	void SetScale(short x, short y);

	/// @brief 
	/// @param x If true, the image will appear flipped in x-direction
	/// @param y If true, the image will appear flipped in y-direction
	void SetFlip(bool x, bool y);

	/// @brief sets The color table mode. Use Hall::NONE to disable color table mode
	/// @param type 
	void SetColorTable(CTType type);

	/// @brief sets The color table mode. Use Hall::NONE to disable color table mode
	/// @param type 
	/// @param colorTable A pointer int the color table memory to the start of the desired color table
	void SetColorTable(CTType type, const Color* colorTable);

	/// @brief 
	/// @param x Visible area is [0,400]
	/// @param y Visible area is [0,240]
	void SetScreenPosition(short x, short y);

	/// @brief Sets the source from which the color for the image will be taken
	/// @param ColorSource 
	void SetColorSource(ColorSource ColorSource);

	/// @brief Sets the color register. This color is used for drawing, if color source is set to COLOR
	/// @param color 
	void SetColor(Color color);

	/// @brief Sets the shape that will be drawn
	/// @param shape 
	void SetShape(Shape shape);

	/// @brief If the drawn shape is a rectangle, this function will  set its position on the screen
	/// @param x 
	/// @param y 
	/// @param width 
	/// @param height 
	void SetRectangle(signed x, signed y, signed width, signed height);
	
	/// @brief Checks if the GPU is busy currently. The GPU will ignore draw calls while it is busy
	/// @return True, if GPU is busy, else false
	bool GetIsGPUBusy();

	/// @brief Executes a draw call with the data given through the other SET functions
	void Draw();
	
	/// @brief Swaps the buffers
	void SetCommandSwapBuffers();
	bool GetVSync();
	bool GetHSync();

	[[deprecated("This function misses a large amount of features and was depracted in favour of more modular setters. See the Hall::Set... functions in combination with Hall::Draw()")]]
	void Draw(const unsigned short* data, unsigned short xOffset, unsigned short yOffset, unsigned short screenX, unsigned short screenY, unsigned short width, unsigned short height, unsigned short dataWidth);

	/// <summary>
	/// Clears the whole screen with the given color
	/// </summary>
	/// <param name="color">The format is R5G5B5A1, with the alpha bit being lsb</param>
	[[deprecated("This function does not fit the philosophy of Hall because it calls underlying functionality with arbitrary values for a specific use case. Please prefer the Clear function that the higher level API has hopefully provided to you")]]
	void Clear(unsigned short color);

	[[deprecated("Use SetImage instead")]] void SetData(const unsigned short* data);
	[[deprecated("Use SetExcerpt instead")]] void SetXOffset(unsigned short xOffset);
	[[deprecated("Use SetExcerpt instead")]] void SetYOffset(unsigned short yOffset);
	[[deprecated("Use SetImage instead")]] void SetImageWidth(unsigned short imageWidth);
	[[deprecated("Use SetExcerpt instead")]] void SetWidth(unsigned short width);
	[[deprecated("Use SetExcerpt instead")]] void SetHeight(unsigned short height);
	[[deprecated("Use SetScreenPosition instead")]] void SetScreenX(unsigned short x);
	[[deprecated("Use SetScreenPosition instead")]] void SetScreenY(unsigned short y);
	[[deprecated("Use SetColor instead")]] void SetClearColor(unsigned short color);
	[[deprecated("Use Draw instead")]] void SetCommandDraw();
	[[deprecated("Please refrain from using this")]] void SetCommandClear();
}
