extern "C" {
	#include "elfload/elfload.h"
}

#include <stdio.h>
#include <stdlib.h>
#include "fatfs/ff.h"

FILE* elfFile;
void* loadAddress = 0;

static bool fileRead(el_ctx* ctx, void* dest, size_t nb, size_t offset)
{
	if (fseek(elfFile, offset, SEEK_SET))
		return false;

	if (fread(dest, nb, 1, elfFile) != 1)
		return false;

	return true;
}

static void* memoryAllocation(el_ctx* ctx, Elf_Addr physicalAddress, Elf_Addr virtualAddress, Elf_Addr size)
{
	//This is what the example does, but I don't know why one can just return the virtual address
	return (void*)virtualAddress;
}

static void check(el_status stat, const char* expln)
{
#ifdef DEBUG
	if (stat)
	{
		fprintf(stderr, "%s: error %d\n", expln, stat);
		exit(1);
	}
	else
	{
		printf("%s\n", expln);
	}
#endif // DEBUG
}

volatile char* GPU_BLOCK = (char*)0x02000000;
volatile uint16_t** GPU_IMAGE_START = (volatile uint16_t**)(GPU_BLOCK + 0);
volatile int* GPU_IMAGE_X = (int*)(GPU_BLOCK + 4);
volatile int* GPU_IMAGE_Y = (int*)(GPU_BLOCK + 8);
volatile int* GPU_IMAGE_WIDTH = (int*)(GPU_BLOCK + 12);
volatile int* GPU_EXCERPT_WIDTH = (int*)(GPU_BLOCK + 16);
volatile int* GPU_EXCERPT_HEIGHT = (int*)(GPU_BLOCK + 20);
volatile int* GPU_SCREEN_X = (int*)(GPU_BLOCK + 24);
volatile int* GPU_SCREEN_Y = (int*)(GPU_BLOCK + 28);
volatile int* GPU_CLEAR_COLOR = (int*)(GPU_BLOCK + 32);
volatile bool* GPU_COMMAND_DRAW = (bool*)(GPU_BLOCK + 36);
volatile bool* GPU_COMMAND_CLEAR = (bool*)(GPU_BLOCK + 40);
volatile int* GPU_IS_BUSY = (int*)(GPU_BLOCK + 44);

volatile bool* GPU_VSYNC = (bool*)(GPU_BLOCK + 48);
volatile bool* GPU_HSYNC = (bool*)(GPU_BLOCK + 52);

volatile bool* GPU_COMMAND_SWAP_BUFFERS = (bool*)(GPU_BLOCK + 56);
volatile bool* VSYNC_BUFFER_SWAP = (bool*)(GPU_BLOCK + 60);

uint16_t black = 0b0000000000000001;

volatile int* fickDich = 0;
int main()
{	//TODO: Include fatfs
	//TODO: Add graphical progress bar

	DIR directory;
	FILINFO fileInfo;
	while(true) (*fickDich)++;
	//Find main program to load
	FRESULT fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");
	
	if(fatfsResult != FR_OK) while(true);
	char elfFilePath[16] = "/";
	int i;
	for(i = 0; fileInfo.fname[i] != '\0'; i++)
		elfFilePath[i + 1] = fileInfo.fname[i];
	elfFilePath[i + 1] = '\0';
	
	elfFile = fopen(elfFilePath, "rb");
	
#ifdef DEBUG
	loadAddress = malloc(32768);
	if (!elfFile)
	{
		perror("File could not be opened");
		return -1;
	}
#endif

	el_ctx ctx;
	ctx.pread = fileRead;

	el_status result = el_init(&ctx);
	check(result, "Initialising");
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	result = el_load(&ctx, memoryAllocation);
	check(result, "Loading data");
	

	result = el_relocate(&ctx);
	check(result, "Resolving relocations");
	
	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;

#ifdef DEBUG
	printf("Entry point within the program is address %p; Program is loaded at address %p\n", (uintptr_t)ctx.ehdr.e_entry, (uintptr_t)entryPoint);
	printf("Jumping into loaded program. (This will not work on OSes)");
#endif // DEBUG

	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();

	while (true);
	return 0;
}
