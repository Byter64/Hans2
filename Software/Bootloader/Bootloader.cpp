extern "C" {
	#include "elfload/elfload.h"
	#include "DebugHelper.h"
}

#include <stdlib.h>
#include <stdio.h>
#include "ff.h"
#include "Hapi.h"

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
#else
	ScreenPrint(expln);
	if(stat) 
	{
		ScreenPrint("Caused error:");
		ScreenPrintByte(stat);
	}
	#endif // DEBUG
}

extern FATFS FatFs;
extern BYTE is_mounted;
int main()
{
	//TODO: Add graphical progress bar
	Hapi::Init();
	Hapi::Clear(Hapi::Color(0, 128, 128, 1));
	Hapi::EndDrawing();
	Hapi::Clear(Hapi::Color(0, 128, 128, 1));
	Hapi::EndDrawing();

	FRESULT fatfsResult;

	ScreenPrint("Mounting SD-Card...");
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;
	ScreenPrintResult(fatfsResult);
	
	
	//Find main program to load
	ScreenPrint("Searching *.elf...");
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");
	ScreenPrintResult(fatfsResult);
	if(fileInfo.fname[0] == '\0')
	{
		ScreenPrint("No .elf found");
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
	
	ScreenPrint(elfFilePath);
	ScreenPrint(debugMessage);
	elfFile = fopen(elfFilePath, "rb");
	ScreenPrint(elfFile ? "Success" : "Failed");
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
	
	el_status result = el_init(&ctx);
	check(result, "Initialising elfloader...");
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	result = el_load(&ctx, memoryAllocation);
	check(result, "Loading elf file...");
	
	
	result = el_relocate(&ctx);
	check(result, "Resolving relocations...");
	
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
