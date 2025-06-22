#include <Hall/Hall.h>

#include "Assets/include/sprites/SproutLands/Objects/Boats.h"
int main() 
{
	//This is your game loop. The program should never leave it.
	while(true) 
	{
		Hall::SetRectangle(0, 0, Hall::SCREEN_WIDTH, Hall::SCREEN_HEIGHT);
		Hall::SetColorSource(Hall::COLOR);
		Hall::SetColor(0b0100001000000001);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		Hall::SetImage(SproutLands::Boats, 48);
		Hall::SetExcerpt(0, 0, 48, 32);
		Hall::SetColorSource(Hall::MEMORY);
		Hall::Draw();
		while (Hall::GetIsGPUBusy());

		//YOu still need to test the color tables!!!
		//YOu still need to test the scaling!!!
		//YOu still need to test the mirroring!!!

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
