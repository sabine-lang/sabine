//
// Created by Orzklv on 21/11/24.
//

#include "../include/compiler.h"
#include "../include/errors.h"
#include <stdio.h>

int main()
{
  int res = compile_file("./tests/basic.c", "./tests/basic", 0);

  if (res == COMPILER_FILE_COMPILED_OK) {
    printf("trace: compiled successfully\n");
  }
  else if (res == COMPILER_FAILED_WITH_ERRORS) {
    printf("error: known error while compiling\n");
  }
  else {
    printf("error: unknown error while compiling\n");
  };

  return 0;
}
