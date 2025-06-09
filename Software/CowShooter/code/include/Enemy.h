#pragma once
#include "Object.h"
#include "ColorType.h"

struct Enemy : public Object
{
	static const signed char TICKS_PER_FRAME = 12;
	static const char WIDTH = 21;
	static const char HEIGHT = 15;
	signed char animationCounter;
	ColorType type;
	int speed; //horizontal speed

	Enemy() = default;
	/// @brief 
	/// @param y 
	/// @param speed must be negative in order to move the cow to the lelft
	/// @param type 
	Enemy(int y, int speed, ColorType type);

	void ChangeType(ColorType type);

	void Update();
	void UpdateAnimation();
};