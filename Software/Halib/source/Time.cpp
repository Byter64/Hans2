#include "Time.h"
#include "Hall.h"

const int Halib::SECS_TO_TICKS			= Hall::SYSTEM_CLK_FREQUENCY / 65536;
		  
const int Halib::MIL_SECS_TO_PREC_TICKS	= Hall::SYSTEM_CLK_FREQUENCY / 1000;
const int Halib::MIC_SECS_TO_PREC_TICKS = Hall::SYSTEM_CLK_FREQUENCY / 1000000;

Halib::Tick Halib::GetCurrentTick()
{
	return Hall::GetSystemTime(2);
}

Halib::PreciseTick Halib::GetCurrentPreciseTick()
{
	return Hall::GetSystemTime(0);
}

int Halib::GetCurrentSeconds()
{
	return GetCurrentTick() / SECS_TO_TICKS;
}

int Halib::GetCurrentMilliSeconds()
{
	return GetCurrentPreciseTick() / MIL_SECS_TO_PREC_TICKS;
}

int Halib::GetCurrentMicroSeconds()
{
	return GetCurrentPreciseTick() / MIC_SECS_TO_PREC_TICKS;
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