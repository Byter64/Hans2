volatile int* number = (int *)34;
volatile char test[23] = "Hallo Welt!";

int main()
{
	while (true)
	{
		*number = *number + 3;
	}
    return 0;
}