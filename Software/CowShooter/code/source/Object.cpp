#include "Object.h"
#include <Hall/Hall.h>

Object::Object(unsigned short* image, unsigned short imageWidth, unsigned short imageOffsetX, unsigned short imageOffsetY, short x, short y, unsigned short width, unsigned short height)
{
    this->image = image;
    this->imageWidth = imageWidth;
    this->imageOffsetX = imageOffsetX;
    this->imageOffsetY = imageOffsetY;
    this->x = x;
    this->y = y;
    this->width = width;
    this->height = height;
}

void Object::Draw()
{
    while(Hall::GetIsGPUBusy());
    Hall::Draw(image, imageOffsetX, imageOffsetY, x, y, width, height, imageWidth);
}