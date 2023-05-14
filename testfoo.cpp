// testfoo.cpp
extern "C" {
#include "foo.h"
}
#include <stdio.h>

int main()
{
  printf("%d\n", FooGetVal(1));
}
