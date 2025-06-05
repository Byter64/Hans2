#include "../include/Image.h"
Halib::Image::Image(const uint16_t* data, Veci2 imageSize)
{
	SetImage((char*)data, imageSize);
}

void Halib::Image::Draw(Veci2 position) const
{
	Hapi::Draw(image, 0, 0, position.x, position.y, imageSize.x, imageSize.y, imageSize.x);
}

void Halib::Image::Draw(Veci2 position, Veci2 framePos, Veci2 frameSize) const
{
	Hapi::Draw(image, framePos.x, framePos.y, position.x, position.y, frameSize.x, frameSize.y, imageSize.x);
}

void Halib::Image::SetImage(char* data, Veci2 imageSize)
{
	image = Hapi::LoadImage(data, imageSize.x, imageSize.y);
	this->imageSize = imageSize;
	rawData = (uint16_t*)data;
}

Hapi::Image Halib::Image::GetImage() const
{
	return image;
}

Halib::Veci2 Halib::Image::GetImageSize() const
{
	return imageSize;
}

uint16_t* Halib::Image::GetRawData()
{
	return rawData;
}