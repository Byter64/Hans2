#pragma once
#include "Object.h"
#include "Player.h"
#include "ColorType.h"

struct Bullet : public Object
{
    static const int WIDTH = 15;
    static const int HEIGHT = 16;
    ColorType type;
    int speed;

    Bullet() = default;
    /// @brief 
    /// @param x 
    /// @param y 
    /// @param speed horizontal speed
    /// @param deathTime 1/60 s ticks until death
    Bullet(int x, int y, int speed, ColorType type);

    void Update();
};