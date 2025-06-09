#pragma once
#include "ColorType.h"

struct GameManager
{
	enum State : unsigned char
	{
		INIT,
		SPAWN_FIRST_ENEMY,
		SPAWN_SECOND_ENEMY,
		WAIT_FOR_SECOND_KILL,
		ENDLESS,
	};

	static const short ENEMIES_PER_LEVEL = 6;

	int level;
	int minSpeed;
	int maxSpeed;
	int minSpawnTime; //In ticks
	int maxSpawnTime; //In ticks

	int spawnTimer;  //In ticks
	State state;

	GameManager();
	GameManager(int minSpeed, int maxSpeed, int minSpawnTime, int maxSpawnTime);

	void Update();

private:
	void SpawnEnemy();
	void SpawnEnemy(ColorType type);
	void SpawnEnemy(ColorType type, int speed = 1);
};