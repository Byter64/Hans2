#pragma once

namespace Hall
{
	static const int SYSTEM_CLK_FREQUENCY = 50000000; //50 MHz
	static void* const SDRAM_START = 0x0; //Start of the RAM. It is 32 MB large
	static void* const BOOTLOADER_START = (void* const) 0x02010000; //Start of the bootloader. It is 32 kB large
	static void* const SD_CARD_START = (void* const) 0x80000000; //Start of the SD-Card

	/// <summary>
	/// Returns an 8-Byte int, that represents the number of ticks that passed since the system's boot-up. Divide by SYSTEM_CLK_FREQUENCY to get seconds
	/// </summary>
	/// <returns>The system time since boot-up in ticks</returns>
	unsigned long long GetSystemTime();

	/// <summary>
	/// Returns the state of all buttons on the controller.
	/// </summary>
	/// <param name="id">Must be in the range [0,1]</param>
	/// <returns>Each button corresponds to one bit: 0 - B, 1 - Y, 2 - Select, 3 - Start, 4 - Up, 5 - Down, 6 - Left, 7 - Right, 8 - A, 9 - X, 10 - L, 11 - R</returns>
	unsigned short GetController(int id);

	unsigned int GetSystemTimeExcerpt(int precision);
	bool GetA(unsigned short controller);
	bool GetB(unsigned short controller);
	bool GetX(unsigned short controller);
	bool GetY(unsigned short controller);
	bool GetStart(unsigned short controller);
	bool GetSelect(unsigned short controller);
	bool GetUp(unsigned short controller);
	bool GetDown(unsigned short controller);
	bool GetLeft(unsigned short controller);
	bool GetRight(unsigned short controller);
	bool GetL(unsigned short controller);
	bool GetR(unsigned short controller);
}
