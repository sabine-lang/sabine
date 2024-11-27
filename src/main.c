//
// Created by Orzklv on 21/11/24.
//

#include "compiler.h"
#include "errors.h"
#include <sabine/buffer.h>
#include <sabine/vector.h>
#include <stdio.h>

int main()
{
  int res = compile_file("./tests/operator.c", "./tests/output", 0);

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
