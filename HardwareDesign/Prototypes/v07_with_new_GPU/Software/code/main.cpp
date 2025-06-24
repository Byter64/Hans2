#include <Hall/Hall.h>

#include "Assets/include/sprites/SproutLands/Objects/Boats.h"
#include "Assets/Checkerboard.h"
#include "Assets/Arrow.h"

// 4x4 square
Hall::IndexContainer ct_8[] = {0x00010203, 0x04050607, 0x08090A0B, 0x0C0D0E0F}; 

//5 x 5 square
Hall::IndexContainer ct_1[] = {0b11111100011010110001111110000000}; 

int main() 
{
	*(Hall::COLOR_TABLE_MEMORY + 1)  = 0b1111100000000101; //red
	*(Hall::COLOR_TABLE_MEMORY + 2)  = 0b1111100000001001;
	*(Hall::COLOR_TABLE_MEMORY + 3)  = 0b1111100000001101;
	*(Hall::COLOR_TABLE_MEMORY + 4)  = 0b1111100000010001;
	*(Hall::COLOR_TABLE_MEMORY + 5)  = 0b1111100000010101;
	*(Hall::COLOR_TABLE_MEMORY + 6)  = 0b1111100000011001;
	*(Hall::COLOR_TABLE_MEMORY + 7)  = 0b1111100000011101;
	*(Hall::COLOR_TABLE_MEMORY + 8)  = 0b1111100000100001;
	*(Hall::COLOR_TABLE_MEMORY + 9)  = 0b1111100000100101;
	*(Hall::COLOR_TABLE_MEMORY + 10) = 0b1111100000101001;
	*(Hall::COLOR_TABLE_MEMORY + 11) = 0b1111100000101101;
	*(Hall::COLOR_TABLE_MEMORY + 12) = 0b1111100000110001;
	*(Hall::COLOR_TABLE_MEMORY + 13) = 0b1111100000110101;
	*(Hall::COLOR_TABLE_MEMORY + 14) = 0b1111100000111001;
	*(Hall::COLOR_TABLE_MEMORY + 15) = 0b1111100000111101; //red + blue
	*(Hall::COLOR_TABLE_MEMORY + 16) = 0b1111110000111111; //red + blue + green
	//This is your game loop. The program should never leave it.
	while(true) 
	{
		
		Hall::SetScale(1, 1);
		Hall::SetFlip(false, false);
		Hall::SetColorTable(Hall::NONE);
		Hall::SetRectangle(0, 0, Hall::SCREEN_WIDTH, Hall::SCREEN_HEIGHT);
		Hall::SetColorSource(Hall::COLOR);
		Hall::SetColor(0b0000001111000001);
		Hall::SetShape(Hall::RECTANGLE);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		//Draw image without ct
		Hall::SetImage(SproutLands::Boats, 48);
		Hall::SetExcerpt(0, 0, 48, 32);
		Hall::SetScreenPosition(200, 0);
		Hall::SetColorSource(Hall::MEMORY);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		//Draw image with ct_8
		Hall::SetImage(ct_8, 4);
		Hall::SetScreenPosition(0, 0);
		Hall::SetExcerpt(0, 0, 16, 1);
		Hall::SetColorSource(Hall::MEMORY);
		Hall::SetColorTable(Hall::BIT_8, Hall::COLOR_TABLE_MEMORY + 1);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		//Draw image with ct_1
		Hall::SetImage(ct_1, 5);
		Hall::SetScreenPosition(20, 0);
		Hall::SetExcerpt(0, 0, 5, 5);
		Hall::SetColorSource(Hall::MEMORY);
		Hall::SetColorTable(Hall::BIT_1, Hall::COLOR_TABLE_MEMORY + 15);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		*(Hall::COLOR_TABLE_MEMORY + 15) = *(Hall::COLOR_TABLE_MEMORY + 15) + 2; //red + blue
		*(Hall::COLOR_TABLE_MEMORY + 16) = *(Hall::COLOR_TABLE_MEMORY + 16) + 2; //red + blue + green

		//Scale test
		Hall::SetImage(Checkerboard, 8);
		Hall::SetExcerpt(0, 0, 8, 8);
		Hall::SetScreenPosition(0, 20);
		Hall::SetColorSource(Hall::MEMORY);
		Hall::SetColorTable(Hall::NONE);
		Hall::SetScale(1, 1);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetScale(2, 1);
		Hall::SetScreenPosition(20, 20);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetScale(1, 2);
		Hall::SetScreenPosition(40, 20);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());
		
		Hall::SetScale(2, 2);
		Hall::SetScreenPosition(60, 20);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetScreenPosition(80, 20);
		Hall::SetScale(-2, 1);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetScale(1, -2);
		Hall::SetScreenPosition(100, 20);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetScale(-2, -2);
		Hall::SetScreenPosition(120, 20);
		Hall::Draw();
		
		//Mirror test
		while (Hall::GetIsGPUBusy());
		Hall::SetImage(Arrow, 32);
		Hall::SetExcerpt(0, 0, 32, 32);
		Hall::SetScale(1, 1);
		Hall::SetFlip(false, false);
		Hall::SetScreenPosition(0, 40);
		Hall::Draw();

		while (Hall::GetIsGPUBusy());
		Hall::SetImage(Arrow, 32);
		Hall::SetExcerpt(0, 0, 32, 32);
		Hall::SetScale(1, 1);
		Hall::SetFlip(true, false);
		Hall::SetScreenPosition(40, 40);
		Hall::Draw();

		while (Hall::GetIsGPUBusy());
		Hall::SetImage(Arrow, 32);
		Hall::SetExcerpt(0, 0, 32, 32);
		Hall::SetScale(1, 1);
		Hall::SetFlip(false, true);
		Hall::SetScreenPosition(80, 40);
		Hall::Draw();

		while (Hall::GetIsGPUBusy());
		Hall::SetImage(Arrow, 32);
		Hall::SetExcerpt(0, 0, 32, 32);
		Hall::SetScale(1, 1);
		Hall::SetFlip(true, true);
		Hall::SetScreenPosition(120, 40);
		Hall::Draw();

		bool vSync = false;
		bool newVSync = false;
		while(!(!vSync && newVSync))
		{
			vSync = newVSync;
			newVSync = Hall::GetVSync();
		}
		
		Hall::SetCommandSwapBuffers();

	}
	return 0;
}
