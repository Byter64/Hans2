#pragma once

namespace Halib
{
	using Tick = int;

	extern const int SECS_TO_TICKS;

	Tick GetCurrentTick();
	int GetCurrentSeconds();
	int GetCurrentMilliSeconds();
	int GetCurrentMicroSeconds();

	constexpr int TickToSeconds(Tick tick);
	constexpr int TickToMilliSeconds(Tick tick);
	constexpr int TickToMicroSeconds(Tick tick);

	constexpr Tick SecondsToTick(int seconds);
	constexpr Tick MilliSecondsToTick(int milliSeconds);
	constexpr Tick MicroSecondsToTick(int microSeconds);
}