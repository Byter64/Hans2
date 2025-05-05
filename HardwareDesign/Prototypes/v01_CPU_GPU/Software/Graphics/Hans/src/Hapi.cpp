#include "Hapi.h"

struct ImageData
{
	char* data;
	int width; //Pixel width of the image
	int height; //Pixel height of the image
};




volatile char* GPU_BLOCK 			= (char*)0x02000000;
volatile int* GPU_IMAGE_START		= (int*)(GPU_BLOCK + 0);
volatile int* GPU_IMAGE_X			= (int*)(GPU_BLOCK + 4);
volatile int* GPU_IMAGE_Y			= (int*)(GPU_BLOCK + 8);
volatile int* GPU_IMAGE_WIDTH		= (int*)(GPU_BLOCK + 12);
volatile int* GPU_EXCERPT_WIDTH		= (int*)(GPU_BLOCK + 16);
volatile int* GPU_EXCERPT_HEIGHT	= (int*)(GPU_BLOCK + 20);
volatile int* GPU_SCREEN_X			= (int*)(GPU_BLOCK + 24);
volatile int* GPU_SCREEN_Y			= (int*)(GPU_BLOCK + 28);
volatile int* GPU_CLEAR_COLOR		= (int*)(GPU_BLOCK + 32);
volatile int* GPU_COMMAND_DRAW		= (int*)(GPU_BLOCK + 36);
volatile int* GPU_COMMAND_CLEAR		= (int*)(GPU_BLOCK + 40);
volatile int* GPU_IS_BUSY			= (int*)(GPU_BLOCK + 44);

volatile int* GPU_VSYNC				= (int*)(GPU_BLOCK + 48);
volatile int* GPU_HSYNC				= (int*)(GPU_BLOCK + 52);

volatile int* GPU_COMMAND_SWAP_BUFFERS= (int*)(GPU_BLOCK + 56);
volatile int* VSYNC_BUFFER_SWAP		= (int*)(GPU_BLOCK + 60);

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
	return image;
}

void Hapi::UpdateImage(Image image, char* start, int width, int height)
{
	//Because CPU and GPU share the same RAM, nothing needs to be done here
}

void Hapi::UnloadImage(Image image)
{
	//imageData.erase(image);
}

void Hapi::StartDrawing()
{

}

void Hapi::EndDrawing()
{
	*GPU_COMMAND_SWAP_BUFFERS = true;
	while (!*GPU_VSYNC);
}


static void WaitForGPU()
{
	volatile int* isGPUBusy = (int*)(GPU_IS_BUSY);
	while (*isGPUBusy);
}

void Hapi::Draw(Image image, int ssX, int ssY, int x, int y, int width, int height, int image_width)
{
	WaitForGPU();
	*GPU_IMAGE_START = image;
	*GPU_IMAGE_X = ssX;
	*GPU_IMAGE_Y = ssY;
	*GPU_IMAGE_WIDTH = image_width;
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
	
}

void Hapi::SetVSync(bool vSync)
{
	*VSYNC_BUFFER_SWAP = vSync;
}
