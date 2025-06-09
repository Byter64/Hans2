
volatile unsigned int* low = (unsigned int*) 0x2003000;
volatile unsigned int* high = (unsigned int*) 0x2003010;

volatile int* p = (int*) 0x2016000;
int main() {
    for(int i = 0; i < 2048; i++)
    {
        *(p -  2 * i) = *low;
        *(p - (2 * i) - 1) = *high;
    }
    return 0;
}