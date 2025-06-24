#include <Hall/Video.h>

volatile char* GPU_START				  = (char*)0x02000000;
const Hall::Color** GPU_IMAGE_START      = (const Hall::Color**)(GPU_START + 0);
short* GPU_IMAGE_X               		  = (short*)			(GPU_START + 4);
short* GPU_IMAGE_Y               		  = (short*)			(GPU_START + 8);
unsigned short* GPU_IMAGE_WIDTH           = (unsigned short*)	(GPU_START + 12);
short* GPU_IMAGE_SCALE_X                  = (short*)			(GPU_START + 16);
short* GPU_IMAGE_SCALE_Y                  = (short*)			(GPU_START + 20);
bool* GPU_IMAGE_FLIP_X                    = (bool*)				(GPU_START + 24);
bool* GPU_IMAGE_FLIP_Y                    = (bool*)				(GPU_START + 28);
Hall::CTType* GPU_COLOR_TABLE_TYPE        = (Hall::CTType*)		(GPU_START + 32);
const Hall::Color** GPU_COLOR_TABLE_OFFSET= (const Hall::Color**)(GPU_START + 36);
short* GPU_EXCERPT_WIDTH         		  = (short*)			(GPU_START + 40);
short* GPU_EXCERPT_HEIGHT        		  = (short*)			(GPU_START + 44);
short* GPU_SCREEN_X              		  = (short*)			(GPU_START + 48);
short* GPU_SCREEN_Y              		  = (short*)			(GPU_START + 52);
Hall::Color* GPU_DRAW_COLOR               = (Hall::Color*)		(GPU_START + 56);
Hall::Shape* GPU_DRAW_SHAPE               = (Hall::Shape*)		(GPU_START + 60);
Hall::ColorSource* GPU_DRAW_COLOR_SOURCE  = (Hall::ColorSource*)(GPU_START + 64);
volatile bool* GPU_COMMAND_DRAW           = (bool*)				(GPU_START + 68);
volatile bool* GPU_IS_BUSY                = (bool*)				(GPU_START + 72);
volatile bool* GPU_VSYNC                  = (bool*)				(GPU_START + 76);
volatile bool* GPU_HSYNC                  = (bool*)				(GPU_START + 80);
volatile bool* GPU_COMMAND_SWAP_BUFFERS   = (bool*)				(GPU_START + 84);
volatile bool* GPU_VSYNC_BUFFER_SWAP      = (bool*)				(GPU_START + 88);

void Hall::SetImage(const Color* image, unsigned short imageWidth)
{
	*GPU_IMAGE_START = image;
	*GPU_IMAGE_WIDTH = imageWidth;
}

void Hall::SetImage(const IndexContainer* image, unsigned short imageWidth)
{
	//This is ugly code, but it represents the hardware
	*GPU_IMAGE_START = (const Color*)image;
	*GPU_IMAGE_WIDTH = imageWidth;
}

void Hall::SetExcerpt(short x, short y)
{
	*GPU_IMAGE_X = x;
	*GPU_IMAGE_Y = y;
}

void Hall::SetExcerpt(short x, short y, short width, short height)
{
	*GPU_IMAGE_X = x;
	*GPU_IMAGE_Y = y;
	*GPU_EXCERPT_WIDTH = width;
	*GPU_EXCERPT_HEIGHT = height;
}

void Hall::SetScale(short x, short y)
{
	*GPU_IMAGE_SCALE_X = x;
	*GPU_IMAGE_SCALE_Y = y;
}

void Hall::SetFlip(bool x, bool y)
{
	*GPU_IMAGE_FLIP_X = x;
	*GPU_IMAGE_FLIP_Y = y;
}

void Hall::SetColorTable(CTType type)
{
	*GPU_COLOR_TABLE_TYPE = type;
}

void Hall::SetColorTable(CTType type, const Color* colorTable)
{
	*GPU_COLOR_TABLE_TYPE = type;
	*GPU_COLOR_TABLE_OFFSET = colorTable;
}

void Hall::SetScreenPosition(short x, short y)
{
	*GPU_SCREEN_X = x;
	*GPU_SCREEN_Y = y;
}

void Hall::SetColorSource(ColorSource ColorSource)
{
	*GPU_DRAW_COLOR_SOURCE = ColorSource;
}

void Hall::SetColor(Color color)
{
	*GPU_DRAW_COLOR = color;
}

void Hall::SetShape(Shape shape)
{
	*GPU_DRAW_SHAPE = shape;
}

void Hall::SetRectangle(signed x, signed y, signed width, signed height)
{
	*GPU_SCREEN_X = x;
	*GPU_SCREEN_Y = y;
	*GPU_EXCERPT_WIDTH = width;
	*GPU_EXCERPT_HEIGHT = height;
}

void Hall::Draw()
{
	*GPU_COMMAND_DRAW = true;
}



void Hall::Draw(const unsigned short* data, unsigned short xOffset, unsigned short yOffset, unsigned short screenX, unsigned short screenY, unsigned short width, unsigned short height, unsigned short dataWidth)
{
	*GPU_IMAGE_START = data;
	*GPU_IMAGE_X = xOffset;
	*GPU_IMAGE_Y= yOffset;
	*GPU_IMAGE_WIDTH = dataWidth;
	*GPU_EXCERPT_WIDTH = width;
	*GPU_EXCERPT_HEIGHT = height;
	*GPU_SCREEN_X = screenX;
	*GPU_SCREEN_Y = screenY;
	*GPU_COMMAND_DRAW = true;
}


void Hall::Clear(unsigned short color)
{
	SetRectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	SetColor(color);
	SetColorSource(Hall::COLOR);
	SetColorTable(Hall::NONE);
	SetScale(1, 1);
	SetShape(Hall::RECTANGLE);
	Draw();
}

void Hall::SetData(const unsigned short* data)
{
	*GPU_IMAGE_START = data;
}

void Hall::SetXOffset(unsigned short xOffset)
{
	*GPU_IMAGE_X = xOffset;
}

void Hall::SetYOffset(unsigned short yOffset)
{
	*GPU_IMAGE_Y = yOffset;
}

void Hall::SetImageWidth(unsigned short imageWidth)
{
	*GPU_IMAGE_WIDTH = imageWidth;
}

void Hall::SetWidth(unsigned short width)
{
	*GPU_EXCERPT_WIDTH = width;
}

void Hall::SetHeight(unsigned short height)
{
	*GPU_EXCERPT_HEIGHT = height;
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
	*GPU_DRAW_COLOR = color;
}

void Hall::SetCommandDraw()
{
	*GPU_COMMAND_DRAW = true;
}

void Hall::SetCommandClear()
{
	Draw();
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
