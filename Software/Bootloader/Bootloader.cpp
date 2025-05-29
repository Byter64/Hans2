extern "C" {
	#include "elfload/elfload.h"
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
#endif // DEBUG
}

uint16_t black = 0b0000000000000001;

void FRESULTToString(FRESULT fResult, char* buffer)
{
	switch (fResult)
	{
	case FR_OK:
		strcpy(buffer, "FR_OK");
	break;
	case FR_DISK_ERR:
		strcpy(buffer, "FR_DISK_ERR");
	break;
	case FR_INT_ERR:
		strcpy(buffer, "FR_INT_ERR");
	break;
	case FR_NOT_READY:
		strcpy(buffer, "FR_NOT_READY");
	break;
	case FR_NO_FILE:
		strcpy(buffer, "FR_NO_FILE");
	break;
	case FR_NO_PATH:
		strcpy(buffer, "FR_NO_PATH");
	break;
	case FR_INVALID_NAME:
		strcpy(buffer, "FR_INVALID_NAME");
	break;
	case FR_DENIED:
		strcpy(buffer, "FR_DENIED");
	break;
	case FR_EXIST:
		strcpy(buffer, "FR_EXIST");
	break;
	case FR_INVALID_OBJECT:
		strcpy(buffer, "FR_INVALID_OBJECT");
	break;
	case FR_WRITE_PROTECTED:
		strcpy(buffer, "FR_WRITE_PROTECTED");
	break;
	case FR_INVALID_DRIVE:
		strcpy(buffer, "FR_INVALID_DRIVE");
	break;
	case FR_NOT_ENABLED:
		strcpy(buffer, "FR_NOT_ENABLED");
	break;
	case FR_NO_FILESYSTEM:
		strcpy(buffer, "FR_NO_FILESYSTEM");
	break;
	case FR_MKFS_ABORTED:
		strcpy(buffer, "FR_MKFS_ABORTED");
	break;
	case FR_TIMEOUT:
		strcpy(buffer, "FR_TIMEOUT");
	break;
	case FR_LOCKED:
		strcpy(buffer, "FR_LOCKED");
	break;
	case FR_NOT_ENOUGH_CORE:
		strcpy(buffer, "FR_NOT_ENOUGH_CORE");
	break;
	case FR_TOO_MANY_OPEN_FILES:
		strcpy(buffer, "FR_TOO_MANY_OPEN_FILES");
	break;
	case FR_INVALID_PARAMETER:
		strcpy(buffer, "FR_INVALID_PARAMETER");
	break;
	}
}

int main()
{
	//TODO: Add graphical progress bar

	DIR directory;
	FILINFO fileInfo;
	//Find main program to load
	FRESULT fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");
	while(true)
	{
	Hapi::StartDrawing();
	Hapi::Clear(Hapi::Color(0, 128, 128, 1));

	char resultString[32];
	FRESULTToString(fatfsResult, resultString);
	Hapi::DrawText("HALLO", 10, 50, 1000000);
	Hapi::Draw((Hapi::Image)Hapi::defaultFont.fontSheet, 0, 0, 250, 10, 120, 15, 120);
	
	Hapi::EndDrawing();
	}
	
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
