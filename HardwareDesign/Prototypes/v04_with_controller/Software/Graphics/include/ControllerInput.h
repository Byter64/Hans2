#pragma once
#include <stdint.h>

namespace Hapi
{
	//Don't change the order, except you know what you are doing!!!
	enum class Button
	{
		B,
		Y,
		Select,
		Start,
		Up,
		Down,
		Left,
		Right,
		A,
		X,
		L,
		R
	};

	/// <summary>
	/// Represents the input state of the controller at one point in time
	/// </summary>
	struct ControllerInput
	{
		ControllerInput() = default;
		ControllerInput(uint16_t rawInput);

		/// <summary>
		/// Checks the state of the given button and returns it
		/// </summary>
		/// <param name="button"></param>
		/// <returns>True, if the given button is pressed down, else false</returns>
		bool IsButtonDown(Button button);
		
		/// <summary>
		/// 
		/// </summary>
		/// <returns>Returns the raw input bit string of these inputs</returns>
		uint16_t GetRawInput();

	private:
		/// <summary>
		/// Is only used by the Hans implementation
		/// </summary>
		uint16_t rawInput;
	};
}