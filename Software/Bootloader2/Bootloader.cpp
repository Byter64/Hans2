//I have to check, that .data and .bss is properly initialised.
//If any changes made to the linker script, they must be also added to the software template
#include <Hall/Hall.h>
#include "Assets/include/fonts/minifont5x3.h"

int main()
{
	Hall::Init();
	Hall::SetImage((const Hall::Color*)Assets::minifont5x3, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetExcerpt(0, 0, MINIFONT5X3_WIDTH, MINIFONT5X3_HEIGHT);
	Hall::SetScreenPosition(10, 10);
	Hall::Draw();

	while(Hall::GetIsGPUBusy());
	Hall::SetCommandSwapBuffers();
	//Hall::SetCommandSwapBuffers();
	while(true);
	return 0;
}