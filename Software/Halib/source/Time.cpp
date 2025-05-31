#include "Time.h"
#include "Hall.h"

extern int Halib::SECS_TO_TICKS = Hall::SYSTEM_CLK_FREQUENCY / 65536;

Halib::Tick Halib::GetCurrentTick()
{
	return Hall::GetSystemTime(2);
}

int Halib::GetCurrentSeconds()
{
	return GetCurrentTick() / Hall::SYSTEM_CLK_FREQUENCY;
}

int Halib::GetCurrentMilliSeconds()
{
	return GetCurrentSeconds() * 1000;
}

int Halib::GetCurrentMicroSeconds()
{
	return GetCurrentMilliSeconds() * 1000;
}


int Halib::TickToSeconds(Tick tick)
{
	return (int)tick / SECS_TO_TICKS;
}

int Halib::TickToMilliSeconds(Tick tick)
{
	return ((int)tick * 1000) / SECS_TO_TICKS;
}

int Halib::TickToMicroSeconds(Tick tick)
{
	return ((int)tick * 1000000) / SECS_TO_TICKS;
}