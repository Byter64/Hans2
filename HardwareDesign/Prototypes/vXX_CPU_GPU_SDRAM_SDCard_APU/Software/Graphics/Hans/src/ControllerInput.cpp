#include "ControllerInput.h"

Hapi::ControllerInput::ControllerInput(uint16_t rawInput)
{
	this->rawInput = rawInput;
}

bool Hapi::ControllerInput::IsButtonDown(Button button)
{
	return (rawInput & (1 << (int)button)) != 0;
}

uint16_t Hapi::ControllerInput::GetRawInput()
{
	return rawInput;
}