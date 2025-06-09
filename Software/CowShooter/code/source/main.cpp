#include <Hall/Hall.h>
#include "Player.h"
#include "Defines.h"
#include "Text.h"
#include "Bullet.h"
#include "BulletManager.h"
#include "EnemyManager.h"
#include "GameManager.h"

Player player1{22, 100, 0};
Player player2{22, 100, 1};
BulletManager bulletManager;
EnemyManager enemyManager;
GameManager gameManager;

int main() {
	player1 = Player(22, 100, 0);
	player2 = Player(22, -60, 1);
	bulletManager = BulletManager();
	enemyManager = EnemyManager();
	gameManager = GameManager();

	Text::Init();
	while(true)
	{
		Hall::Clear(0b0000001000010001);
		
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
