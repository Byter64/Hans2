struct Number
{
	int number;
	int number4;
	Number()
	{
		number = -1;
		number4 = 4;
	}

	void Add(int summand) volatile
	{
		number += summand;
	}

	void Add4() volatile
	{
		number4 += 4;
	}
};

volatile Number number;

int main()
{
	while (true)
	{
		number.Add(3);
		number.Add4();
	}
    return 0;
}