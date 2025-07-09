//What comes after start.s? Right, start.c

typedef void (*constructor_t)(void);

extern constructor_t __init_array_start[];
extern constructor_t __init_array_end[];
extern constructor_t __preinit_array_start[];
extern constructor_t __preinit_array_end[];

void __libc_init_array() 
{
	int count = __preinit_array_end - __preinit_array_start;
    for (int i = 0; i < count; i++) 
	{
        __preinit_array_start[i]();
    }

    count = __init_array_end - __init_array_start;
    for (int i = 0; i < count; i++) 
	{
        __init_array_start[i]();
    }
}

int main();

void _main()
{
	__libc_init_array();

	main();

	while(1);
}