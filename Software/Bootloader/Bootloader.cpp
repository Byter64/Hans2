extern "C" {
	#include "elfload/elfload.h"
	#include "DebugHelper.h"
}

#include "ff.h"
#include "Hapi.h"

FIL elfFile;
void* loadAddress = 0;

static bool fileRead(el_ctx* ctx, void* dest, size_t nb, size_t offset)
{
	if (f_lseek(&elfFile, offset))
		return false;

	unsigned int bytesRead;
	if (f_read(&elfFile, dest, nb, &bytesRead))
		return false;

	return true;
}

static void* memoryAllocation(el_ctx* ctx, Elf_Addr physicalAddress, Elf_Addr virtualAddress, Elf_Addr size)
{
	//This is what the example does, but I don't know why one can just return the virtual address
	return (void*)physicalAddress;
}

static void check(el_status stat, const char* text)
{
	if(stat)
	{
		ScreenPrint("Error:");
		ScreenPrintByte(stat);
		SetStatus(text, -1, 20);
		while(true);
	}
}

extern FATFS FatFs;
extern BYTE is_mounted;

int main()
{

	Hapi::Init();
	
	ScreenPrint("Can you read?");
	
	FRESULT fatfsResult;
	#ifndef SIMULATION
	WaitFrame(120);
	#endif
	
	#ifndef SIMULATION
	SetStatus("Mounting SD-Card...", 0, 15);
	#endif
	
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;
	
	if(fatfsResult)
	{
		ScreenPrint("Error:");
		ScreenPrint(FRESULTToString(fatfsResult));
		while(true);
	}
	#ifndef SIMULATION
	SetStatus(FRESULTToString(fatfsResult), 10, 10);
	#endif

	//Find main program to load
	#ifndef SIMULATION
	SetStatus("Searching *.elf...", 15, 15);
	#endif
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");

	if(fileInfo.fname[0] == '\0' || fatfsResult)
	{
		ScreenPrint("Error:");
		ScreenPrint(FRESULTToString(fatfsResult));
		SetStatus("No .elf found", 20, 0);
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
	

	#ifndef SIMULATION
	SetStatus(debugMessage, 25, 10);
	#endif

	fatfsResult = f_open(&elfFile, elfFilePath, FA_READ);

	if(fatfsResult)
	{
		ScreenPrint("Error:");
		ScreenPrint(FRESULTToString(fatfsResult));
		SetStatus("Open failed", 20, 0);
		while(true);
	}
	#ifndef SIMULATION
	SetStatus("Open succeeded", 30, 20);
	#endif
	
	el_ctx ctx;
	ctx.pread = fileRead;
	
	#ifndef SIMULATION
	SetStatus("Initialising elfloader...", 35, 20);
	#endif
	el_status result = el_init(&ctx);
	check(result, "Init FAILED!");
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	#ifndef SIMULATION
	SetStatus("Loading .elf file...", 40, 55);
	#endif
	result = el_load(&ctx, memoryAllocation);
	check(result, "Load FAILED!");

	#ifndef SIMULATION
	SetStatus("Resolving relocations...", 80, 15);
	#endif
	result = el_relocate(&ctx);
	check(result, "Relocs FAILED!");

	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;

	#ifndef SIMULATION
	SetStatus("Succeeded. What a journey man, Have fun :)", 100, 40);
	#endif
	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();

	while (true);
	
	return 0;
}
