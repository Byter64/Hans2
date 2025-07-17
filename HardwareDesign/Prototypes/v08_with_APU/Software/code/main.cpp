#include <Hall/Hall.h>
#include "sabre_dance_short.h"

Hall::Color test[6]  __attribute__ ((__aligned__(4))) = 
{
	0x0001, 0xFFFF, 0x0001,
	0x0001, 0xFFFF, 0x0001
};
int main() 
{
	Hall::SetImage(test, 3, 2);
	Hall::SetExcerpt(0, 0, 2, 2);
	Hall::SetScreenPosition(0, 0);
	Hall::Draw();
	while(Hall::GetIsGPUBusy());

	Hall::SetImage(test + 1, 2, 2);
	Hall::Draw();
	while(Hall::GetIsGPUBusy());

	while(true);
	return 0;
}
