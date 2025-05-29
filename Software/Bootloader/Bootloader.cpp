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
#endif // DEBUG
}

uint16_t black = 0b0000000000000001;

const char* FRESULTToString(FRESULT fResult)
{
	switch (fResult)
	{
	case FR_OK:
		return "FR_OK";
	break;
	case FR_DISK_ERR:
		return"FR_DISK_ERR";
	break;
	case FR_INT_ERR:
		return"FR_INT_ERR";
	break;
	case FR_NOT_READY:
		return"FR_NOT_READY";
	break;
	case FR_NO_FILE:
		return"FR_NO_FILE";
	break;
	case FR_NO_PATH:
		return"FR_NO_PATH";
	break;
	case FR_INVALID_NAME:
		return"FR_INVALID_NAME";
	break;
	case FR_DENIED:
		return"FR_DENIED";
	break;
	case FR_EXIST:
		return"FR_EXIST";
	break;
	case FR_INVALID_OBJECT:
		return"FR_INVALID_OBJECT";
	break;
	case FR_WRITE_PROTECTED:
		return"FR_WRITE_PROTECTED";
	break;
	case FR_INVALID_DRIVE:
		return"FR_INVALID_DRIVE";
	break;
	case FR_NOT_ENABLED:
		return"FR_NOT_ENABLED";
	break;
	case FR_NO_FILESYSTEM:
		return"FR_NO_FILESYSTEM";
	break;
	case FR_MKFS_ABORTED:
		return"FR_MKFS_ABORTED";
	break;
	case FR_TIMEOUT:
		return"FR_TIMEOUT";
	break;
	case FR_LOCKED:
		return"FR_LOCKED";
	break;
	case FR_NOT_ENOUGH_CORE:
		return"FR_NOT_ENOUGH_CORE";
	break;
	case FR_TOO_MANY_OPEN_FILES:
		return"FR_TOO_MANY_OPEN_FILES";
	break;
	case FR_INVALID_PARAMETER:
		return"FR_INVALID_PARAMETER";
	break;
	default:
		return"Invalid result";
	break;
	}
}

const char* ByteToHex(unsigned char byte, char* buffer)
{
	unsigned char nibble0 = byte & 0x0F;
	unsigned char nibble1 = (byte & 0xF0) >> 4;

	if(nibble0 < 10) buffer[1] = '0' + nibble0;
	else 			 buffer[1] = 'A' + nibble0 - 10;

	if(nibble1 < 10) buffer[0] = '0' + nibble1;
	else 			 buffer[0] = 'A' + nibble1 - 10;
	
	buffer[2] = '\0';
	return buffer;
}

void ScreenPrint(const char* text)
{
	static int x = 5;
	static int y = 5;
	//if(x >= 400) return;
	Hapi::DrawText(">", x - 4, y, 100);
	Hapi::DrawText(text, x, y, 1000000);
	Hapi::EndDrawing();

	Hapi::DrawText(">", x - 4, y, 100);
	Hapi::DrawText(text, x, y, 1000000);
	Hapi::EndDrawing();

	y += 5;
	if (y == 240)
	{
		y = 5;
		x += 25;
	}
}

void DrawResult(FRESULT fatfsResult, int x, int y)
{
	ScreenPrint(FRESULTToString(fatfsResult));
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
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;
	DrawResult(fatfsResult, 10, 50);
	
	
	//Find main program to load
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");
	DrawResult(fatfsResult, 10, 60);
	
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
