#pragma once

namespace Hall
{
	static const int SYSTEM_CLK_FREQUENCY = 50000000; //50 MHz
	static void* const SDRAM_START = 0x0; //Start of the RAM. It is 32 MB large
	static void* const BOOTLOADER_START = 0x02010000 //Start of the bootloader. It is 32 kB large
	static void* const SD_CARD_START = 0x80000000; //Start of the SD-Card

	/// <summary>
	/// Returns a 4-Byte excerpt of the 8-Byte system time in ticks since startup. The precision determines the byte offset.
	/// </summary>
	/// <param name="precision">Value in [0, 4]. The higher the precision, the varier you must be because of overflows</param>
	/// <returns>The system clock with the given precision</returns>
	unsigned int GetSystemTime(int precision);

	/// <summary>
	/// Returns the state of all buttons on the controller.
	/// </summary>
	/// <param name="id">Must be in the range [0,1]</param>
	/// <returns>Each button corresponds to one bit: 0 - B, 1 - Y, 2 - Select, 3 - Start, 4 - Up, 5 - Down, 6 - Left, 7 - Right, 8 - A, 9 - X, 10 - L, 11 - R</returns>
	unsigned short GetController(int id);
}