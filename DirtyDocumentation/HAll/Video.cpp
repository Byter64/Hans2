#include "Audio.h"

volatile void* GPU_START					= (void*)0x02000000;
volatile unsigned short* GPU_IMAGE_START	= (unsigned short*)(GPU_START + 0);
volatile unsigned short* GPU_IMAGE_X_OFFSET	= (unsigned short*)(GPU_START + 4);
volatile unsigned short* GPU_IMAGE_Y_OFFSET	= (unsigned short*)(GPU_START + 8);
volatile unsigned short* GPU_IMAGE_WIDTH	= (unsigned short*)(GPU_START + 12);
volatile unsigned short* GPU_WIDTH			= (unsigned short*)(GPU_START + 16);
volatile unsigned short* GPU_HEIGHT			= (unsigned short*)(GPU_START + 20);
volatile unsigned short* GPU_SCREEN_X		= (unsigned short*)(GPU_START + 24);
volatile unsigned short* GPU_SCREEN_Y		= (unsigned short*)(GPU_START + 28);
volatile unsigned short* GPU_CLEAR_COLOR	= (unsigned short*)(GPU_START + 32);
volatile bool* GPU_COMMAND_DRAW				= (bool*)(GPU_START + 36);
volatile bool* GPU_COMMAND_CLEAR			= (bool*)(GPU_START + 40);
volatile bool* GPU_IS_BUSY					= (bool*)(GPU_START + 44);
volatile bool* GPU_VSYNC					= (bool*)(GPU_START + 48);
volatile bool* GPU_HSYNC					= (bool*)(GPU_START + 52);
volatile bool* GPU_COMMAND_SWAP_BUFFERS		= (bool*)(GPU_START + 56);
volatile bool* VSYNC_BUFFER_SWAP			= (bool*)(GPU_START + 60);


void Hall::Draw(unsigned short* data, unsigned short xOffset, unsigned short yOffset, unsigned short screenX, unsigned short screenY, unsigned short width, unsigned short height, unsigned short dataWidth)
{
	*GPU_IMAGE_START = data;
	*GPU_IMAGE_X_OFFSET = xOffset;
	*GPU_IMAGE_Y_OFFSET = yOffset;
	*GPU_IMAGE_WIDTH = dataWidth;
	*GPU_WIDTH = width;
	*GPU_HEIGHT = height;
	*GPU_SCREEN_X = screenX;
	*GPU_SCREEN_Y = screenY;
	*GPU_COMMAND_DRAW = true;
}


void Hall::Clear(unsigned short color)
{
	*GPU_CLEAR_COLOR = color;
	*GPU_COMMAND_CLEAR = true;
}

void Hall::SetData(unsigned short* data)
{
	*GPU_IMAGE_START = data;
}

void Hall::SetXOffset(unsigned short xOffset)
{
	*GPU_IMAGE_X_OFFSET = xOffset;
}

void Hall::SetYOffset(unsigned short yOffset)
{
	*GPU_IMAGE_Y_OFFSET = yOffset;
}

void Hall::SetImageWidth(unsigned short imageWidth)
{
	*GPU_IMAGE_WIDTH = imageWidth;
}

void Hall::SetWidth(unsigned short width)
{
	*GPU_WIDTH = width;
}

void Hall::SetHeight(unsigned short height)
{
	*GPU_HEIGHT = height;
}


void Hall::SetScreenX(unsigned short x)
{
	*GPU_SCREEN_X = x;
}


void Hall::SetScreenY(unsigned short y)
{
	*GPU_SCREEN_Y = y;
}

void Hall::SetClearColor(unsigned short color)
{
	*GPU_CLEAR_COLOR = color;
}

void Hall::SetCommandDraw()
{
	*GPU_COMMAND_DRAW = true;
}

void Hall::SetCommandClear()
{
	*GPU_COMMAND_CLEAR = true;
}

void Hall::SetCommandSwapBuffers()
{
	*GPU_COMMAND_SWAP_BUFFERS = true;
}

bool Hall::GetIsGPUBusy()
{
	return *GPU_IS_BUSY;
}

bool Hall::GetVSync()
{
	return *GPU_VSYNC;
}

bool Hall::GetHSync()
{
	return *GPU_HSYNC;
}
