#pragma once

struct Object
{
    unsigned short* image;
    unsigned short imageWidth;
    unsigned short imageOffsetX;
    unsigned short imageOffsetY;
    short x;
    short y;
    unsigned short width;
    unsigned short height;

    Object() = default;
    Object(unsigned short* image, unsigned short imageWidth, unsigned short imageOffsetX, unsigned short imageOffsetY, short x, short y, unsigned short width, unsigned short height);
    void Draw();
};