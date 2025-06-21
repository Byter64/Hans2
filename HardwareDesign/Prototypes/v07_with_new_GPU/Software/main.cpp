volatile unsigned int* low  = (unsigned int*) 0x02000300;
volatile unsigned int* high = (unsigned int*) 0x02000310;

volatile int* p = (int*) 0x2016000;
int main() {
    for(int i = 0; i < 2048; i++)
    {
        *(p -  2 * i) = *low;
        *(p - (2 * i) - 1) = *high;
    }
    return 0;
}