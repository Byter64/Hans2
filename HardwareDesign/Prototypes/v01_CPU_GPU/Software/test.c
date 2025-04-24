volatile const char* test = "Hallo Welt adwadaw!";
volatile char testa[20];

int main()
{
    for (int i = 0; test[i] != '\0'; i++)
    {
        testa[i] = test[i] + 1;
    }
    return 0;
}