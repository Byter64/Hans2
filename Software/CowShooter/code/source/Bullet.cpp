#include "Bullet.h"
#include "Fruits.h"
#include "Defines.h"

Bullet::Bullet(int x, int y, int speed, ColorType type) : Object((unsigned short*)Fruits, FRUITS_WIDTH, 0, 0, x, y, WIDTH, HEIGHT)
{
    this->speed = speed;
    this->type = type;

    int offset = (int)type - 1;
    imageOffsetX = offset * WIDTH;
}

void Bullet::Update()
{
    x += GAME_SPEED * speed;
}