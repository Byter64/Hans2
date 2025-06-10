#include <Hall/Hall.h>
#include "Player.h"
#include "Defines.h"
#include "Text.h"
#include "Bullet.h"
#include "BulletManager.h"
#include "EnemyManager.h"
#include "GameManager.h"
#include "Grass_Tile_Layers.h"
#include <stdlib.h>

Player player1{22, 100, 0};
Player player2{22, 100, 1};
BulletManager bulletManager;
EnemyManager enemyManager;
GameManager gameManager;

char tileIDs[400 * 240];

int main() {
	player1 = Player(22, 100, 0);
	player2 = Player(22, -60, 1);
	bulletManager = BulletManager();
	enemyManager = EnemyManager();
	gameManager = GameManager();

	for(int y = 0; y < 240; y += 16)
		for(int x = 0; x < 400; x += 16)
		{
			tileIDs[x + y * 400] = rand() % 13;
		}

	Text::Init();
	while(true)
	{  
		for(int y = 0; y < 240; y += 16)
			for(int x = 0; x < 400; x += 16)
			{
				while(Hall::GetIsGPUBusy());
				Hall::Draw(Grass_Tile_Layers, tileIDs[x + y * 400] * 16, 0, x, y, 16, 16, GRASS_TILE_LAYERS_WIDTH);
			}
		
		gameManager.Update();
		bulletManager.Update();
		enemyManager.Update();
		player1.Update();
		player2.Update();

		
		
		bulletManager.Draw();
		enemyManager.Draw();
		player1.Draw();
		player2.Draw();
		
		while(Hall::GetIsGPUBusy());
		
		bool isVsync = Hall::GetVSync();
		bool newIsVsync = Hall::GetVSync();
		while(!(!isVsync && newIsVsync))
		{
			isVsync = newIsVsync;
			newIsVsync = Hall::GetVSync();
		}
		Hall::SetCommandSwapBuffers();
	}
	return 0;
}
