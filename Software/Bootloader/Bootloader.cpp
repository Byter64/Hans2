extern "C" {
	#include "elfload/elfload.h"
	#include "DebugHelper.h"
}

#include <stdlib.h>
#include <stdio.h>
#include "ff.h"
#include "Hapi.h"
#include <errno.h>
#include <string.h>

FILE* elfFile;
void* loadAddress = 0;

static bool fileRead(el_ctx* ctx, void* dest, size_t nb, size_t offset)
{
	if (fseek(elfFile, offset, SEEK_SET))
		return false;

	int temp = fread(dest, nb, 1, elfFile);
	ScreenPrint("fread");
	if (temp != 1)
		return false;

	return true;
}

static void* memoryAllocation(el_ctx* ctx, Elf_Addr physicalAddress, Elf_Addr virtualAddress, Elf_Addr size)
{
	//This is what the example does, but I don't know why one can just return the virtual address
	return (void*)virtualAddress;
}

static void check(el_status stat, const char* text)
{
	if(stat)
	{
		ScreenPrint("Error:");
		ScreenPrintByte(stat);
		//SetStatus(text, -1, 20);
		while(true);
	}
}

extern FATFS FatFs;
extern BYTE is_mounted;

int main()
{
	char buffer[3];
	//TODO: Add graphical progress bar
	Hapi::Init();
	FRESULT fatfsResult;
	WaitFrame(120);
	
#ifndef USE_STARTUP_SCREEN
	Hapi::Clear(Hapi::Color(0, 128, 128, 1));
	Hapi::EndDrawing();
	Hapi::Clear(Hapi::Color(0, 128, 128, 1));
	Hapi::EndDrawing();
#endif
	const char* string1 = "Hallo Welt! Dies ist ein langer String";
	ScreenPrint(string1);
	for(int i = 0; i < 20; i++)
	{
		char* string2 = (char*)malloc(39);
		strcpy(string2, string1);
		ScreenPrint(string2);
	}


	//SetStatus("Mounting SD-Card...", 0, 20);
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;

	//SetStatus(ByteToHex(fatfsResult, buffer), 10, 10);

	//Find main program to load
	//SetStatus("Searching *.elf...", 15, 15);
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");

	//SetStatus(ByteToHex(fatfsResult, buffer), 20, 20);
	if(fileInfo.fname[0] == '\0')
	{
		//SetStatus("No .elf found", 20, 0);
		while(true);
	}
	
	if(fatfsResult != FR_OK) while(true);

	char elfFilePath[16] = "/";
	char debugMessage[32] = "Opening ";
	int i;
	for(i = 0; fileInfo.fname[i] != '\0'; i++)
	{
		elfFilePath[i + 1] = fileInfo.fname[i];
		debugMessage[i + 8] = fileInfo.fname[i];
	}
	elfFilePath[i + 1] = '\0';
	debugMessage[i + 8] = '.';
	debugMessage[i + 9] = '.';
	debugMessage[i + 10] = '.';
	debugMessage[i + 11] = '\0';
	
	//SetStatus(debugMessage, 25, 10);
	elfFile = fopen(elfFilePath, "r");
	setvbuf(elfFile, NULL, _IONBF, 0);
	//SetStatus(elfFile ? "Open succeeded" : "Open failed", 30, 20);
	if(!elfFile) while(true);

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
	
	//SetStatus("Initialising elfloader...", 35, 20);
	el_status result = el_init(&ctx);
	check(result, "Init FAILED!");
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	//SetStatus("Loading .elf file...", 40, 60);
	result = el_load(&ctx, memoryAllocation);
	check(result, "Load FAILED!");
	
	
	//SetStatus("Resolving relocations...", 80, 10);
	result = el_relocate(&ctx);
	check(result, "Relocs FAILED!");
	
	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;
	
	#ifdef DEBUG
	printf("Entry point within the program is address %p; Program is loaded at address %p\n", (uintptr_t)ctx.ehdr.e_entry, (uintptr_t)entryPoint);
	printf("Jumping into loaded program. (This will not work on OSes)");
	#endif // DEBUG
	
	//SetStatus("Have fun :)", 100, 30);
	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();
	
	while (true);
	
	return 0;
}
