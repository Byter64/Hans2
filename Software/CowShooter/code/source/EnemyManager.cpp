#include "EnemyManager.h"
#include "Defines.h"
#include <Hall/Hall.h>

EnemyManager::EnemyManager()
{
	for (int i = 0; i < MAX_ENEMIES; i++)
	{
		enemyContainers[i].isUsed = false;
	}
	activeEnemies = 0;
	killedEnemies = 0;
}

bool EnemyManager::SpawnEnemy(int y, int speed, ColorType type)
{
	for (int i = 0; i < MAX_ENEMIES; i++)
	{
		if (!enemyContainers[i].isUsed)
		{
			enemyContainers[i].isUsed = true;
			enemyContainers[i].enemy = Enemy(y, speed, type);
			activeEnemies++;
			return true;
		}
	}
	return false;
}

void EnemyManager::DespawnEnemy(Enemy* enemy)
{
	EnemyContainer* enemyContainer = (EnemyContainer*) enemy;
	enemyContainer->isUsed = false;
	activeEnemies--;
	despawnedEnemies++;
}

void EnemyManager::KillEnemy(Enemy* enemy)
{
	DespawnEnemy(enemy);
	killedEnemies++;
}

int EnemyManager::GetMissedEnemies()
{
	return despawnedEnemies - killedEnemies;
}

void EnemyManager::Update()
{
	for (int i = 0; i < MAX_ENEMIES; i++)
	{
		EnemyContainer& enemyContainer = enemyContainers[i];
		if (enemyContainer.isUsed)
		{
			enemyContainer.enemy.Update();

			if (enemyContainer.enemy.x <= 0 - 40)
			{
				DespawnEnemy(&enemyContainer.enemy);
			}
		}
	}
}

void EnemyManager::Draw()
{
	for (int i = 0; i < MAX_ENEMIES; i++)
	{
		if (enemyContainers[i].isUsed)
			enemyContainers[i].enemy.Draw();
	}
}