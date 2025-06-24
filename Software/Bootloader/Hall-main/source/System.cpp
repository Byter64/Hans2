#include <Hall/System.h>

volatile char* SYSTEM_TIME = (volatile char*)0x02000300;
volatile unsigned int* SYSTEM_TIME_0 = (volatile unsigned int*)(SYSTEM_TIME + 0); //Least precise
volatile unsigned int* SYSTEM_TIME_1 = (volatile unsigned int*)(SYSTEM_TIME + 4);
volatile unsigned int* SYSTEM_TIME_2 = (volatile unsigned int*)(SYSTEM_TIME + 8);
volatile unsigned int* SYSTEM_TIME_3 = (volatile unsigned int*)(SYSTEM_TIME + 12);
volatile unsigned int* SYSTEM_TIME_4 = (volatile unsigned int*)(SYSTEM_TIME + 16);//Most precise

volatile char* CONTROLLER_START = (volatile char*)0x02000200;
volatile unsigned short* CONTROLLER_0 = (volatile unsigned short*)(CONTROLLER_START + 0);
volatile unsigned short* CONTROLLER_1 = (volatile unsigned short*)(CONTROLLER_START + 2);

unsigned long long Hall::GetSystemTime()
{
	unsigned long long result = *SYSTEM_TIME_0;
	result = result << 32;
	result += *SYSTEM_TIME_4;
	return result;
}

unsigned int Hall::GetSystemTimeExcerpt(int precision)
{
	return *(SYSTEM_TIME_0 + precision);
}

unsigned short Hall::GetController(int id)
{
	return *(CONTROLLER_0 + id);
}

bool Hall::GetA(unsigned short controller)
{
	return controller & (1 << 8);
}

bool Hall::GetB(unsigned short controller)
{
	return controller & (1 << 0);
}

bool Hall::GetX(unsigned short controller)
{
	return controller & (1 << 9);
}

bool Hall::GetY(unsigned short controller)
{
	return controller & (1 << 1);
}

bool Hall::GetStart(unsigned short controller)
{
	return controller & (1 << 3);
}

bool Hall::GetSelect(unsigned short controller)
{
	return controller & (1 << 2);
}

bool Hall::GetUp(unsigned short controller)
{
	return controller & (1 << 4);
}

bool Hall::GetDown(unsigned short controller)
{
	return controller & (1 << 5);
}

bool Hall::GetLeft(unsigned short controller)
{
	return controller & (1 << 6);
}

bool Hall::GetRight(unsigned short controller)
{
	return controller & (1 << 7);
}

bool Hall::GetL(unsigned short controller)
{
	return controller & (1 << 10);
}

bool Hall::GetR(unsigned short controller)
{
	return controller & (1 << 11);
}
