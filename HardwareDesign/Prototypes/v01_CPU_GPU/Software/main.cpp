#include "Assets/include/sprites/SproutLands/Tilesets/ground_tiles/water_frames/Water.h"
#include "Assets/include/sprites/SproutLands/Objects/Piknik basket.h"
#include "Hapi.h"
#include "Assets/include/sprites/SproutLands/Objects/Boats.h"

#ifndef _DEBUG
#pragma comment(linker, "/SUBSYSTEM:windows /ENTRY:mainCRTStartup")
#endif


volatile char* MEMORY_ADDRESS 		= (char*)24576;

volatile int* GET_BUTTON_F1			= (int*)(MEMORY_ADDRESS + 512);
volatile int* GET_BUTTON_F2			= (int*)(MEMORY_ADDRESS + 512 + 4);
volatile int* GET_BUTTON_UP			= (int*)(MEMORY_ADDRESS + 512 + 8);
volatile int* GET_BUTTON_DOWN		= (int*)(MEMORY_ADDRESS + 512 + 12);
volatile int* GET_BUTTON_LEFT		= (int*)(MEMORY_ADDRESS + 512 + 16);
volatile int* GET_BUTTON_RIGHT		= (int*)(MEMORY_ADDRESS + 512 + 20);

volatile int* GET_NES_B				= (int*)(MEMORY_ADDRESS + 1024);
volatile int* GET_NES_Y				= (int*)(MEMORY_ADDRESS + 1024 + 4);	
volatile int* GET_NES_SELECT		= (int*)(MEMORY_ADDRESS + 1024 + 8);
volatile int* GET_NES_START			= (int*)(MEMORY_ADDRESS + 1024 + 12);
volatile int* GET_NES_UP			= (int*)(MEMORY_ADDRESS + 1024 + 16);
volatile int* GET_NES_DOWN			= (int*)(MEMORY_ADDRESS + 1024 + 20);
volatile int* GET_NES_LEFT			= (int*)(MEMORY_ADDRESS + 1024 + 24);
volatile int* GET_NES_RIGHT			= (int*)(MEMORY_ADDRESS + 1024 + 28);
volatile int* GET_NES_A				= (int*)(MEMORY_ADDRESS + 1024 + 32);
volatile int* GET_NES_X				= (int*)(MEMORY_ADDRESS + 1024 + 36);
volatile int* GET_NES_L				= (int*)(MEMORY_ADDRESS + 1024 + 40);
volatile int* GET_NES_R				= (int*)(MEMORY_ADDRESS + 1024 + 44);


struct Basket {
    int x, y, vx;
    bool active;
};

Basket baskets[2];

void updateAnimation(int& ticks, int& frame_x, int frame_width, int max_frame);
void moveBoat(int& x, int& y, int speed, bool up, bool down, bool left, bool right);
void fireBasket(int x, int y, int direction);
void updateBaskets();

int main() {
    int water_ticks = 20, water_frame_x = 0;
    int left_boat_x = 10, left_boat_y = 100;
    int right_boat_x = 350, right_boat_y = 100;
    int boat_speed = 2;
	int boat_pos = 0;
    bool paused = false;

    Hapi::Init();
    Hapi::SetTargetFPS(60);
    Hapi::Image water = Hapi::LoadImage((char*)SproutLands::Water, 16, 16);
    Hapi::Image boat = Hapi::LoadImage((char*)SproutLands::Boats, 48, 32);

    while (true) {

        Hapi::StartDrawing();
        Hapi::Clear(Hapi::Color(255, 127, 127, 1));

        for (int y = 0; y < 240; y += 16) {
            for (int x = 0; x < 400; x += 16) {
                Hapi::Draw(water, water_frame_x, 0, x, y, 16, 16, 48);
            }
        }
        Hapi::Draw(boat, 0, 0, left_boat_x, left_boat_y, 48, 32, 48);
		boat_pos += boat_speed;
		left_boat_x = 50 + (boat_pos % 200);

        updateAnimation(water_ticks, water_frame_x, 16, 48);
        Hapi::EndDrawing();
    }
    Hapi::Terminate();
    return 0;
}

void updateAnimation(int& ticks, int& frame_x, int frame_width, int max_frame) {
    if (--ticks == 0) {
        frame_x = (frame_x + frame_width) % max_frame;
        ticks = 20;
    }
}

void moveBoat(int& x, int& y, int speed, bool up, bool down, bool left, bool right) {
    if (up) y -= speed;
    if (down) y += speed;
    if (left) x -= speed;
    if (right) x += speed;
    if (y < 0) y = 0;
    if (y > 200) y = 200;
    if (x < 0) x = 0;
    if (x > 352) x = 352;
}

void fireBasket(int x, int y, int direction) {
    for (auto& b : baskets) {
        if (!b.active) {
            b = { x, y, direction, true };
            break;
        }
    }
}

void updateBaskets() {
    for (auto& b : baskets) {
        if (b.active) {
            b.x += b.vx;
            if (b.x < 0 || b.x > 400) b.active = false;
        }
    }
}
