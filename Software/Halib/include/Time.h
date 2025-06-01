#pragma once

namespace Halib
{
	using Tick = int;
	using PreciseTick = short;
	struct Time
	{
		Tick tick;
		PreciseTick preciseTick;
	};

	extern const int SECS_TO_TICKS;

	extern const int MIL_SECS_TO_PREC_TICKS;
	extern const int MIC_SECS_TO_PREC_TICKS;

	Tick GetCurrentTick();
	PreciseTick GetCurrentPreciseTick();
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