#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <vector>
#include <iostream>
#include <memory>

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
  volatile My_cool_class * instance_heap = new My_cool_class(5, 9L);

  std::vector<int> veeectoooor{};
  veeectoooor.push_back(42);
  veeectoooor.push_back(1337);

  std::cout << veeectoooor[0] + veeectoooor[1] << std::endl;

  std::unique_ptr<My_cool_class> zeiger = std::make_unique<My_cool_class>(400, 100L);
  std::cout << zeiger->a + zeiger->b << std::endl;

  int *b = (int *)malloc(sizeof(int));

  return func(a, *b);
}
