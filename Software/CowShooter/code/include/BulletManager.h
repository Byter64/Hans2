#pragma once
#include "Bullet.h"
#include "ColorType.h"

struct BulletManager
{
	struct BulletContainer
	{
		Bullet bullet;
		bool isUsed;
	};

	static const int MAX_BULLETS = 4;
	BulletContainer bulletContainers[MAX_BULLETS];

	BulletManager();
	bool SpawnBullet(int x, int y, int speed, ColorType type);
	void HandleCollision(BulletContainer& bulletContainer);

	void Update();
	void Draw();
};