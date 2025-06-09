#pragma once
#include "Object.h"
#include "Tree.h"

struct Player : public Object
{
    static const int WIDTH = TREE_WIDTH;
    static const int HEIGHT = TREE_HEIGHT;
    int spawnedBullets = 0;
    int controllerID = 0;

	//controller inputs
	unsigned short controller;
	unsigned short wasPressed;
	unsigned short wasReleased;

    Player(int startX, int startY, int controllerID);
    void Update();

private:
	void UpdateController();
    void UpdateMovement();
    void UpdateBullet();
};