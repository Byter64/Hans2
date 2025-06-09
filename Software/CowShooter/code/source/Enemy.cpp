#include "Enemy.h"
#include "Cows.h"
#include "Defines.h"

Enemy::Enemy(int y, int speed, ColorType type) : Object(cows, COWS_WIDTH, 0, 0, 420, y, WIDTH, HEIGHT)
{
	this->type = type;
	this->speed = speed;

	ChangeType(type);
	animationCounter = TICKS_PER_FRAME;
}

void Enemy::Update()
{
	x += speed * GAME_SPEED / 2;

	UpdateAnimation();
}

void Enemy::UpdateAnimation()
{
	//speed is negative, so we must add
	animationCounter += speed * GAME_SPEED;
	if(animationCounter <= 0)
	{
		animationCounter = TICKS_PER_FRAME;
		imageOffsetX += WIDTH;
		if(imageOffsetX >= 84)
			imageOffsetX = 0;
	}
}

void Enemy::ChangeType(ColorType type)
{
	this->type = type;
	int offset = (int)type - 1;
	imageOffsetY = offset * HEIGHT;
}