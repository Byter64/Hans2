#include "BulletManager.h"
#include "Defines.h"
#include <Hall/Hall.h>
#include "EnemyManager.h"
#include <stdlib.h>

BulletManager::BulletManager()
{
	for (int i = 0; i < MAX_BULLETS; i++)
	{
		bulletContainers[i].isUsed = false;
	}
}

bool BulletManager::SpawnBullet(int x, int y, int speed, ColorType type)
{
	for (int i = 0; i < MAX_BULLETS; i++)
	{
		if (!bulletContainers[i].isUsed)
		{
			bulletContainers[i].isUsed = true;
			bulletContainers[i].bullet = Bullet(x, y, speed, type);
			return true;
		}
	}
	return false;
}

void BulletManager::HandleCollision(BulletContainer& bulletContainer)
{
	for(int i = 0; i < EnemyManager::MAX_ENEMIES; i++)
	{
		EnemyManager::EnemyContainer& enemyContainer = enemyManager.enemyContainers[i];
		if(!enemyContainer.isUsed) continue;

		Enemy& enemy = enemyContainer.enemy;
		Bullet& bullet = bulletContainer.bullet;
		
		
		//Calculate the center of the sprites, to ease final collision calculation
		bool hasCollided = true;
		int enemyX = enemy.x + Enemy::WIDTH / 2;
		int enemyY = enemy.y + Enemy::HEIGHT / 2;
		int bulletX = bullet.x + Bullet::WIDTH / 2;
		int bulletY = bullet.y + Bullet::HEIGHT / 2;
		if(abs(enemyX - bulletX) > (Enemy::WIDTH + Bullet::WIDTH) / 2) hasCollided = false;
		if(abs(enemyY - bulletY) > (Enemy::HEIGHT + Bullet::HEIGHT) / 2) hasCollided = false;
		if(!hasCollided) continue;
		
		if(bullet.type != enemy.type) 
		{
			//enemy.ChangeType(bullet.type);
			bulletContainer.isUsed = false;
		}
		else
		{
			enemyManager.KillEnemy(&enemy);
			bulletContainer.isUsed = false;
		}
	}
}

void BulletManager::Update()
{
	for (int i = 0; i < MAX_BULLETS; i++)
	{
		if (bulletContainers[i].isUsed)
		{
			bulletContainers[i].bullet.Update();

			if (bulletContainers[i].bullet.x >= Hall::SCREEN_WIDTH + 16)
				bulletContainers[i].isUsed = false;
			
			HandleCollision(bulletContainers[i]);
		}
	}
}

void BulletManager::Draw()
{
	for (int i = 0; i < MAX_BULLETS; i++)
	{
		if (bulletContainers[i].isUsed)
			bulletContainers[i].bullet.Draw();
	}
}