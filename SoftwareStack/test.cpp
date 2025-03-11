#include <math.h>
#include <stdlib.h>
#include <string.h>

int func(volatile int *a, int b) { return abs(*a + b); }

int main() {
  volatile int *a = (int *)0x5;

  char str[15] = "Hallo, Welt";
  char str2[15];
  strncpy(str, str2, 15);

  int *b = (int *)malloc(sizeof(int));

  return func(a, 4);
}
