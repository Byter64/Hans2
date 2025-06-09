#pragma once

struct BulletManager;
struct EnemyManager;
struct GameManager;

const int GAME_SPEED = 2; //1 == 60 fps, 2 == 30 fps
const int TICKS_PER_SEC = 60;

extern BulletManager bulletManager;
extern EnemyManager enemyManager;
extern GameManager gameManager;