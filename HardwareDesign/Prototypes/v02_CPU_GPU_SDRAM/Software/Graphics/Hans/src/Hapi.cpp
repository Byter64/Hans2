#include "Hapi.h"
#include "FontAtlas.h"
#include <iostream>

struct ImageData
{
	char* data;
	int width; //Pixel width of the image
	int height; //Pixel height of the image
};

struct FontData
{
	char* data;
	int width; //Pixel width of the font
	int height; //Pixel height of the font
	Hapi::FontAtlas fontatlas;
};


std::map<Hapi::Image, ImageData> imageData{};
std::map<Hapi::Image, FontData> fontData{};

volatile char* GPU_BLOCK = (char*)8192;
volatile int* GPU_IMAGE_START		= (int*)(GPU_BLOCK + 0);
volatile int* GPU_IMAGE_X			= (int*)(GPU_BLOCK + 4);
volatile int* GPU_IMAGE_Y			= (int*)(GPU_BLOCK + 8);
volatile int* GPU_IMAGE_WIDTH		= (int*)(GPU_BLOCK + 12);
volatile int* GPU_EXCERPT_WIDTH		= (int*)(GPU_BLOCK + 16);
volatile int* GPU_EXCERPT_HEIGHT	= (int*)(GPU_BLOCK + 20);
volatile int* GPU_SCREEN_X			= (int*)(GPU_BLOCK + 24);
volatile int* GPU_SCREEN_Y			= (int*)(GPU_BLOCK + 28);
volatile int* GPU_COMMAND_DRAW		= (int*)(GPU_BLOCK + 32);
volatile int* GPU_CLEAR_COLOR		= (int*)(GPU_BLOCK + 36);
volatile int* GPU_COMMAND_CLEAR		= (int*)(GPU_BLOCK + 40);
volatile int* GPU_IS_BUSY			= (int*)(GPU_BLOCK + 44);

volatile int* GPU_SWAP_BUFFERS		= (int*)(GPU_BLOCK + 256);
volatile int* GPU_IS_V_SYNCED		= (int*)(GPU_BLOCK + 260);

volatile char* CLOCK = nullptr;
volatile int* CLOCK_FREQ = (int*)CLOCK;
volatile int* CLOCK_LOW = (int*)(CLOCK + 4);
volatile int* CLOCK_HIGH = (int*)(CLOCK + 8);

volatile char* INPUT_ADDRESS = (char*) - 1;

static int lastTime = 0;
static int targetTicks = 0;

int Hapi::Init()
{
	return 0;
}

int Hapi::Terminate()
{
	return 0;
}

bool Hapi::ShouldClose()
{
	return false;
}

Hapi::Image Hapi::LoadImage(char* start, int width, int height)
{
	Image image = (Image)start;
	imageData[image] = ImageData{ start, width, height };

	return image;
}

void Hapi::UpdateImage(Image image, char* start, int width, int height)
{
	//Because CPU and GPU share the same RAM, nothing needs to be done here
}

void Hapi::UnloadImage(Image image)
{
	imageData.erase(image);
}

void Hapi::StartDrawing()
{

}

void Hapi::EndDrawing()
{
	*GPU_SWAP_BUFFERS = true;
	//To "skip" clock overflows
	int offset = lastTime + targetTicks < lastTime ? targetTicks : 0;
	int currentTime = *CLOCK_LOW;
	while ((lastTime + offset) - (currentTime + offset) < targetTicks)
		currentTime = *CLOCK_LOW;
	lastTime = currentTime;
}

Hapi::Font Hapi::LoadFont(char* start, int width, int height, FontAtlas fontatlas)
{
	Font font = (Font)start;
	fontData[font] = FontData{ start, width, height, fontatlas };

	return font;
}

void Hapi::UnloadFont(Font font)
{
	fontData.erase(font);
}

static void WaitForGPU()
{
	volatile int* isGPUBusy = (int*)(GPU_IS_BUSY);
	while (*isGPUBusy);
}

void Hapi::DrawText(const char* text, Font font, int posX, int posY, unsigned int maxWidth)
{
	int startX = posX;
	FontAtlas& atlas = fontData[font].fontatlas;

	for (; *text != '\0'; text++)
	{
		const Rectangle& rect = atlas.atlas[*text];
		int charSize = rect.width + 1;

		if ((posX + charSize) - startX >= maxWidth)
		{
			posX = startX;
			posY += rect.height + 1;
		}

		WaitForGPU();
		Draw(font, rect.x, rect.y, posX, posY, rect.width, rect.height);
		posX += charSize;
	}
}

void Hapi::Draw(Image image, int imageX, int imageY, int x, int y, int width, int height)
{
	WaitForGPU();

	*GPU_IMAGE_START = image;
	*GPU_IMAGE_X = imageX;
	*GPU_IMAGE_Y = imageY;
	*GPU_IMAGE_WIDTH = imageData[image].width;
	*GPU_EXCERPT_WIDTH = width;
	*GPU_EXCERPT_HEIGHT = height;
	*GPU_SCREEN_X = x;
	*GPU_SCREEN_Y = y;
	*GPU_COMMAND_DRAW = true;
}

void Hapi::Clear(Color color)
{
	WaitForGPU();

	*GPU_CLEAR_COLOR = color.GetColor();
	*GPU_COMMAND_CLEAR = true;
}

void Hapi::SetTargetFPS(int fps)
{
	targetTicks = *CLOCK_FREQ / fps;
}

void Hapi::SetVSync(bool vSync)
{
	*GPU_IS_V_SYNCED = vSync;
}

Hapi::ControllerInput Hapi::GetControllerInput()
{
	return ControllerInput{ *(uint16_t*)INPUT_ADDRESS};
}