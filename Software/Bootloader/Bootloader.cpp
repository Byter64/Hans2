extern "C" {
	#include "elfload/elfload.h"
}

#include <stdio.h>
#include <stdlib.h>

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

int main()
{
	//TODO: Include fatfs
	//TODO: Add graphical progress bar
	elfFile = fopen(R"(C:\Users\Yanni\Documents\Hans2\Software\Bootloader\firmware.elf)", "rb");

	
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

}
