#include <Hall/Hall.h>
#include "sabre_dance_short.h"

//5 x 5 square
Hall::IndexContainer ct_1[] = {0b11111100011010110001111110000000}; 

int main() 
{
	Hall::SetupMono(1, (short *)sabre_dance_short, 12496, 0, 12495, 128);
	Hall::Play(0b00000010);

	*(Hall::COLOR_TABLE_MEMORY + 15) = 0b1111100000111101; //red + blue
	*(Hall::COLOR_TABLE_MEMORY + 16) = 0b1111110000111111; //red + blue + green
	//This is your game loop. The program should never leave it.
	while(true) 
	{
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
