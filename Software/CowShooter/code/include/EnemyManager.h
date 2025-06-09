#pragma once
#include "Enemy.h"
#include "ColorType.h"

struct EnemyManager
{
	struct EnemyContainer
	{
		Enemy enemy;
		bool isUsed;
	};

	static const int MAX_ENEMIES = 8;
	unsigned char activeEnemies = 0;
	int killedEnemies = 0;
	int despawnedEnemies = 0; //includes killed ones
	EnemyContainer enemyContainers[MAX_ENEMIES];

	EnemyManager();
	bool SpawnEnemy(int y, int speed, ColorType type);
	void DespawnEnemy(Enemy* enemy);
	void KillEnemy(Enemy* enemy);
	int GetMissedEnemies();

	void Update();
	void Draw();
};