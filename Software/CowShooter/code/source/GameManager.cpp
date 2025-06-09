#include "GameManager.h"
#include "EnemyManager.h"
#include "Defines.h"
#include <stdlib.h>
#include <Hall/Hall.h>
#include "Text.h"
#include "Player.h"

char* IntToString(char* buffer, int bufferSize, int number)
{
	bufferSize--;

	bool wasNegative = number < 0;
	buffer[bufferSize] = '\0';
	bufferSize--;
	if(number == 0)
	{
		buffer[bufferSize] = '0';
		return buffer + bufferSize;
	}

	while(bufferSize >= 0 && number != 0)
	{
		int digit = number % 10;
		buffer[bufferSize] = '0' + digit;
		number /= 10;
		bufferSize--;
	}

	if(wasNegative && bufferSize >= 0)
	{
		buffer[bufferSize] = 'N';
		bufferSize--;
	}

	//BufferSize points to the next free address, so we need to add one again
	return buffer + bufferSize + 1;
}

GameManager::GameManager()
{
	this->level = 0;
	this->minSpeed = 1;
	this->maxSpeed = 4;
	this->minSpawnTime = 120;
	this->maxSpawnTime = 600;
	this->state = INIT;
}

GameManager::GameManager(int minSpeed, int maxSpeed, int minSpawnTime, int maxSpawnTime)
{
	this->level = 0;
	this->minSpeed = minSpeed;
	this->maxSpeed = maxSpeed;
	this->minSpawnTime = minSpawnTime;
	this->maxSpawnTime = maxSpawnTime;
	this->state = INIT;
}

void GameManager::Update()
{
	char buffer[32];
	switch (state)
	{
	case INIT:
		static int timer = 200;
		timer--;
		if(timer == 0)
			state = SPAWN_FIRST_ENEMY;
		break;
	case SPAWN_FIRST_ENEMY:
			SpawnEnemy(ColorType::RED, -1);
			state = SPAWN_SECOND_ENEMY;
		break;
	case SPAWN_SECOND_ENEMY:
			if(enemyManager.activeEnemies == 0)
			{
				SpawnEnemy(ColorType::BLUE, -1);
				state = WAIT_FOR_SECOND_KILL;
			}
		break;
	case WAIT_FOR_SECOND_KILL:
			if(enemyManager.activeEnemies == 0)
				state = ENDLESS;
		break;
	default:
	case ENDLESS:
			
			short newLevel = (enemyManager.killedEnemies - enemyManager.GetMissedEnemies()) / ENEMIES_PER_LEVEL;
			newLevel = newLevel < 0 ? 0 : newLevel;
			/*
			char* intAsText = IntToString(buffer, 32, level);
			Text::DrawText("Level: ", 2, 2, INT16_MAX);
			Text::DrawText(intAsText, 8 * 4 + 2, 2, INT16_MAX);

			intAsText = IntToString(buffer, 32, enemyManager.killedEnemies);
			Text::DrawText("Score: ", 2, 10, INT16_MAX);
			Text::DrawText(intAsText, 8 * 4 + 2, 2, INT16_MAX);
			*/
			if(newLevel != level)
			{
				minSpawnTime -=5;
				minSpawnTime = minSpawnTime < 12 ? 12 : minSpawnTime;
				maxSpawnTime -= 24;
				maxSpawnTime = maxSpawnTime < 60 ? 60 : maxSpawnTime;

				if(maxSpawnTime < 100)
				{
					maxSpeed = 2;
				}
				else if(maxSpawnTime < 300)
				{
					maxSpeed = 3;
				}
			}
			
			spawnTimer -= GAME_SPEED;
			if(spawnTimer <= 0)
			{
				SpawnEnemy();
				spawnTimer = (rand() % (maxSpawnTime - minSpawnTime) + minSpawnTime);
			}
			level = newLevel;
		break;
	}
}

void GameManager::SpawnEnemy(ColorType type, int speed)
{
	int y = (rand() % (Hall::SCREEN_HEIGHT - Player::HEIGHT - 5)) + 5;
	enemyManager.SpawnEnemy(y, speed, type);
}

void GameManager::SpawnEnemy()
{
	ColorType type = (ColorType)((rand() % 4) + 1);
	int speed = (rand() % (maxSpeed - minSpeed)) + minSpeed;
	SpawnEnemy(type, -speed);
}