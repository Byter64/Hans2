// MinigameCollection.cpp: Definiert den Einstiegspunkt für die Anwendung.
//
/*
volatile int* GPU_IMAGE_START		= (int*)(GPU_BLOCK + 0);
volatile int* GPU_IMAGE_X			= (int*)(GPU_BLOCK + 4);
volatile int* GPU_IMAGE_Y			= (int*)(GPU_BLOCK + 8);
volatile int* GPU_IMAGE_WIDTH		= (int*)(GPU_BLOCK + 12);
volatile int* GPU_EXCERPT_WIDTH		= (int*)(GPU_BLOCK + 16);
volatile int* GPU_EXCERPT_HEIGHT	= (int*)(GPU_BLOCK + 20);
volatile int* GPU_SCREEN_X			= (int*)(GPU_BLOCK + 24);
volatile int* GPU_SCREEN_Y			= (int*)(GPU_BLOCK + 28);
volatile int* GPU_COMMAND_DRAW		= (int*)(GPU_BLOCK + 32);
volatile int* GPU_IS_BUSY			= (int*)(GPU_BLOCK + 44);

volatile int* GPU_SWAP_BUFFERS		= (int*)(GPU_BLOCK + 256);
volatile int* GPU_IS_V_SYNCED		= (int*)(GPU_BLOCK + 260);

*/
volatile char* GPU_BLOCK 			= (char*)57344;
volatile int* GPU_COMMAND_CLEAR		= (int*)(GPU_BLOCK + 40);
volatile int* GPU_CLEAR_COLOR		= (int*)(GPU_BLOCK + 36);

int main()
{
	*GPU_CLEAR_COLOR = 0b0000011111111111;
	*GPU_COMMAND_CLEAR = true;
    return 0;
}