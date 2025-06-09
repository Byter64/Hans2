#include "Player.h"
#include <Hall/Hall.h>
#include "Tree.h"
#include "Bullet.h"
#include "BulletManager.h"
#include "Defines.h"
#include "ColorType.h"

Player::Player(int startX, int startY, int controllerID) : Object(Tree, TREE_WIDTH, 0, 0, startX, startY, TREE_WIDTH, TREE_HEIGHT)
{
    this->controllerID = controllerID;
}

void Player::Update()
{
	UpdateController();
    UpdateMovement();
    UpdateBullet();
}

void Player::UpdateController()
{
	unsigned short newController = Hall::GetController(controllerID);

	wasPressed = ~controller & newController;
	wasReleased = controller & ~newController;
	controller = newController;
}

void Player::UpdateMovement()
{
    int xMovement = 0;
    int yMovement = 0;
    if(Hall::GetUp(controller))
        yMovement--;
    if(Hall::GetDown(controller))
        yMovement++;
    if(Hall::GetLeft(controller))
        xMovement--;
    if(Hall::GetRight(controller))
        xMovement++;
    
    if(xMovement == 0 && yMovement == 0) return;
    x += xMovement * GAME_SPEED;
    y += yMovement * GAME_SPEED;
    
    if(x < 0) x = 0;
    if(x > Hall::SCREEN_WIDTH - TREE_WIDTH) x = Hall::SCREEN_WIDTH - TREE_WIDTH;
    if(y < 0) y = 0;
    if(y > Hall::SCREEN_HEIGHT - TREE_HEIGHT) y = Hall::SCREEN_HEIGHT - TREE_HEIGHT;

}

void Player::UpdateBullet()
{
	ColorType bulletType = ColorType::NONE;
	if (Hall::GetA(wasPressed))
		bulletType = ColorType::RED;
	if (Hall::GetB(wasPressed))
		bulletType = ColorType::YELLOW;
	if (Hall::GetY(wasPressed))
		bulletType = ColorType::GREEN;
	if (Hall::GetX(wasPressed))
		bulletType = ColorType::BLUE;

	if (bulletType != ColorType::NONE)
		bulletManager.SpawnBullet(x + 10, y, 3, bulletType);
}