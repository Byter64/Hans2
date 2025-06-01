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
		//SetStatus(text, -1, 20);
		while(true);
	}
}

extern FATFS FatFs;
extern BYTE is_mounted;

int (*function)() = (int (*)())0;

volatile int* x = (int*)0x2010000;
int main()
{
	for(int i = 0; i < 10; i++) *x += i;
	function();

	Hapi::Init();
	FRESULT fatfsResult;
	WaitFrame(120);
	
	SetStatus("Mounting SD-Card...", 0, 20);
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;

	if(fatfsResult)
	{
		ScreenPrint("Error:");
		ScreenPrint(FRESULTToString(fatfsResult));
		while(true);
	}
	SetStatus(FRESULTToString(fatfsResult), 10, 10);

	//Find main program to load
	SetStatus("Searching *.elf...", 15, 15);
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
	
	SetStatus(debugMessage, 25, 10);
	fatfsResult = f_open(&elfFile, elfFilePath, FA_READ);

	if(fatfsResult)
	{
		ScreenPrint("Error:");
		ScreenPrint(FRESULTToString(fatfsResult));
		SetStatus("Open failed", 20, 0);
		while(true);
	}
	SetStatus("Open succeeded", 30, 20);
	
	el_ctx ctx;
	ctx.pread = fileRead;
	
	SetStatus("Initialising elfloader...", 35, 20);
	el_status result = el_init(&ctx);
	check(result, "Init FAILED!");
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	SetStatus("Loading .elf file...", 40, 120);
	result = el_load(&ctx, memoryAllocation);
	check(result, "Load FAILED!");
	

	SetStatus("Resolving relocations...", 80, 120);
	result = el_relocate(&ctx);
	check(result, "Relocs FAILED!");
	
	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;

	SetStatus("Succeeded. What a journey man, Have fun :)", 100, 120);
	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();

	while (true);
	
	return 0;
}
