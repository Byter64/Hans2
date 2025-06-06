
int main() {
    volatile int x = 5000;
    volatile int y = 1000;
    volatile int z = 0;
    for(int i = 0; i < 1000; i++) {
        z += x + y;
    }
    for(int i = 0; i < 1000; i++) {
        x += z + y;
    }
    for(int i = 0; i < 1000; i++) {
        y += x + z;
    }
    volatile int *p = (int*)10;
    *p = x;
    *p = y;
    *p = z;

    while (true);
    
    return 0;
}