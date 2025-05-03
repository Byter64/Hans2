#include <math.h>
#include <stdlib.h>
#include <string.h>

int func(volatile int *a, int b) { return abs(*a + b); }

class My_cool_class {
public:
  int a;
  long b;

  My_cool_class(int a, long b) {
    this->a = a;
    this->b = b;
  }
};

int main() {
  volatile int *a = (int *)0x5;

  char str[15] = "Hallo, Welt";
  char str2[15];
  strncpy(str, str2, 15);

  volatile My_cool_class instance{5, 9L};

  int *b = (int *)malloc(sizeof(int));

  return func(a, *b);
}
