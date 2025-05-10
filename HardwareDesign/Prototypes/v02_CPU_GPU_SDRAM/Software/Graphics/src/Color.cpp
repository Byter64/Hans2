#include "Color.h"

Hapi::Color::Color(unsigned char red, unsigned char green, unsigned char blue, bool alpha)
{
	SetColor(red, green, blue, alpha);
}


void Hapi::Color::SetRed(unsigned char red)
{
	this->red = red;
	color = (color & 0b0000011111111111) | ((red >> 3) << 11);
}

void Hapi::Color::SetGreen(unsigned char green)
{
	this->green = green;
	color = (color & 0b1111100000111111) | ((green >> 3) << 6);
}

void Hapi::Color::SetBlue(unsigned char blue)
{
	this->blue = blue;
	color = (color & 0b1111111111000001) | ((blue >> 3) << 1);
}

void Hapi::Color::SetAlpha(bool alpha)
{
	this->alpha = alpha;
	color = (color & 0b1111111111111110) | (alpha & 1);
}

void Hapi::Color::SetColor(unsigned char red, unsigned char green, unsigned char blue)
{
	SetRed(red);
	SetGreen(green);
	SetBlue(blue);
}

void Hapi::Color::SetColor(unsigned char red, unsigned char green, unsigned char blue, bool alpha)
{
	SetRed(red);
	SetGreen(green);
	SetBlue(blue);
	SetAlpha(alpha);
}

void Hapi::Color::SetColor16(uint16_t color)
{
	this->color = color;
	this->red = ((color >> 11) & 0b11111) << 3;
	this->green = ((color >> 6) & 0b11111) << 3;
	this->blue = ((color >> 1) & 0b11111) << 3;
	this->alpha = color & 0b1;
}

unsigned char Hapi::Color::GetRed()
{
	return red;
}

unsigned char Hapi::Color::GetGreen()
{
	return green;
}

unsigned char Hapi::Color::GetBlue()
{
	return blue;
}

bool Hapi::Color::GetAlpha()
{
	return alpha;
}

uint16_t Hapi::Color::GetColor()
{
	return color;
}

#ifdef DESKTOP
::Color Hapi::Color::ToRaylib()
{
	return {red, green, blue, (unsigned char)(alpha ? 255 : 0 )};
}
#endif // DESKTOP