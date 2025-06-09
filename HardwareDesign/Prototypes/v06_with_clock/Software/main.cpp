volatile int* p = (int*) 0x2016000;
int main() {
    for(int i = 0; i < 256; i++)
    {
        *(p + i) = i;
    }
    return 0;
}