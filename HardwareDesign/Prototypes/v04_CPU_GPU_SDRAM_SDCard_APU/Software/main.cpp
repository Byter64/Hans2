﻿#include "Assets/include/sprites/SproutLands/Tilesets/ground_tiles/water_frames/Water.h"
#include "Assets/include/sprites/SproutLands/Objects/Piknik basket.h"
#include "Hapi.h"
#include "Assets/include/sprites/SproutLands/Objects/Boats.h"
#include "printf/printf.h"

#ifndef _DEBUG
#pragma comment(linker, "/SUBSYSTEM:windows /ENTRY:mainCRTStartup")
#endif

void updateAnimation(int& ticks, int& frame_x, int frame_width, int max_frame);

volatile int* sdCard = (int*)0x80000000;
int main() {
    /*int water_ticks = 20, water_frame_x = 0;
    int left_boat_x = 10, left_boat_y = 100;
    int right_boat_x = 350, right_boat_y = 100;
    int boat_speed = 2;
	int boat_pos = 0;
    bool paused = false;
    
    Hapi::Init();
    Hapi::SetTargetFPS(60);
    Hapi::Image water = Hapi::LoadImage((char*)SproutLands::Water, 16, 16);
    Hapi::Image boat = Hapi::LoadImage((char*)SproutLands::Boats, 48, 32);
    */
    
    *(sdCard + 0) = 0x33221100;
    *(sdCard + 129) = 0x77665544;
    *(sdCard + 258) = 0xBBAA9988;
    while (true) {
        /*
        Hapi::StartDrawing();
        
        for (int y = 0; y < 240; y += 16) {
            for (int x = 0; x < 400; x += 16) {
                //Hapi::Draw(water, water_frame_x, 0, x, y, 16, 16, 48);
            }
        }
        Hapi::Clear((Hapi::Color(128, 255, 255, 1)));

        Hapi::Draw(boat, 0, 0, left_boat_x, left_boat_y, 48, 32, 48);
		boat_pos += boat_speed;
		left_boat_x = 50 + (boat_pos % 200);
        */
		char text[64]; 
        text[0] = '\0';
        //Hapi::DrawText("SDRAM:", 5, 5, INT32_MAX);
        sprintf_(text, "0x00: %x", *(sdCard + 0));
        //Hapi::DrawText(text, 5, 10, INT32_MAX);
        sprintf_(text, "0x04: %x", *(sdCard + 129));
        //Hapi::DrawText(text, 5, 15, INT32_MAX);
        sprintf_(text, "0x08: %x", *(sdCard + 258));
        //Hapi::DrawText(text, 5, 20, INT32_MAX);
        
        for(int i = 0; i < 12; i++)
        {
            //sprintf_(text, "0x%x: %x", i, *(sdCard + i));
            //Hapi::DrawText(text, 5, 60 + i * 5, INT32_MAX);
        }

        //Hapi::Draw((Hapi::Image)Hapi::defaultFont.fontSheet, 0, 0, 250, 10, 120, 15, 120);
        //updateAnimation(water_ticks, water_frame_x, 16, 48);
        //Hapi::EndDrawing();
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