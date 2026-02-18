//I have to check, that .data and .bss is properly initialised.
//If any changes made to the linker script, they must be also added to the software template
#include <Hall/Hall.h>
#include "Helper.h"

extern "C" 
{
	#include "elfload/elfload.h"
}
#include "ff.h"


FIL elfFile;
void* loadAddress = 0;


/// @brief 
/// @param number 
/// @param buffer 
/// @param bufferSize 
/// @return A pointer to the first valid char within the given buffer
static char* ToString(int number, char* buffer, int bufferSize)
{
	buffer[bufferSize - 1] = '\0';
	bufferSize--;

	bool isNegative = false;
	if(number < 0)
	{
		number = -number;
		isNegative = true;
	}

	char chars[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	do
	{
		int digit = number % 10;
		buffer[bufferSize - 1] = chars[digit];
		bufferSize--;

		number = number / 10;
	} while(number != 0 && bufferSize > 0);
	
	if(isNegative && bufferSize > 0)
	{
		buffer[bufferSize - 1] = '-';
		bufferSize--;
	}

	return buffer + bufferSize;
}

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

int testNumber;
int testNumber2 = 313445;

extern FATFS FatFs;
extern BYTE is_mounted;

int main()
{
	Hall::Init();
	InitGlyphs();
	static const int BUFFER_SIZE = 64;
	char buffer[BUFFER_SIZE];

	Print("Kannst du mich lesen?");

	//###################################
	//Finding the elf
	//###################################

	FRESULT fatfsResult;
	
	Print("Mounting SD-Card...");
	fatfsResult = f_mount(&FatFs, "", 0);
    is_mounted = 1;
	Print("Finished Mounting SD-Card");
	
	if(fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		while(true);
	}
	Print(ToString(fatfsResult, buffer, BUFFER_SIZE));

	Print("Searching *.elf...");
	DIR directory;
	FILINFO fileInfo;
	fatfsResult = f_findfirst(&directory, &fileInfo, "/", "*.elf");
	Print("Finished searching *.elf");

	if(fileInfo.fname[0] == '\0' || fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		Print("No .elf found");
		Print("Entering loop of eternal nothing");
		while(true);
	}

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
	Print(debugMessage);

	fatfsResult = f_open(&elfFile, elfFilePath, FA_READ);
	if(fatfsResult)
	{
		Print("Error:");
		Print(ToString(fatfsResult, buffer, BUFFER_SIZE));
		Print("Open failed");
		while(true);
	}
	Print("Open succeeded");

	//################################
	//Loading the elf
	//################################
	el_ctx ctx;
	ctx.pread = fileRead;
	
	Print("Initialising elfloader...");
	el_status result = el_init(&ctx);
	if(result)
	{
		Print("Init FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}
	
	ctx.base_load_vaddr = (uintptr_t)loadAddress;
	ctx.base_load_paddr = (uintptr_t)loadAddress;
	
	Print("Loading .elf file...");
	result = el_load(&ctx, memoryAllocation);
	if(result)
	{
		Print("Load FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}

	Print("Resolving relocations...");
	result = el_relocate(&ctx);
	if(result)
	{
		Print("Relocs FAILED:");
		Print(ToString(result, buffer, BUFFER_SIZE));
		while(true);
	}

	uintptr_t entryPoint = ctx.ehdr.e_entry + (uintptr_t)loadAddress;

	Print("Succeeded. What a journey man, Have fun :)");
	int (*loadedMain)() = (int (*)())entryPoint;
	loadedMain();
	Print("This should not be readable!");

	while(true);
	return 0;
}