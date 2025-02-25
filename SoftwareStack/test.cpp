#include <string.h>

int func(volatile int *a, int b) { return *a + b; }

int main() {
  volatile int *a = (int *)0x5;

  char str[15] = "Hallo, Welt";
  char str2[15];
  strncpy(str, str2, 15);

  return func(a, 4);
}
