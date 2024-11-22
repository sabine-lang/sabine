//
// Created by Orzklv on 22/11/24.
//

#include "../include/compiler.h"
#include "../include/errors.h"
#include "../include/process.h"

int compile_file(const char *filename, const char *out_filename, int flags)
{
  struct compile_process *process =
    compile_process_create(filename, out_filename, flags);

  if (!process)
    return COMPILER_FAILED_WITH_ERRORS;

  // TODO: Implement lexical analysis

  // TOOD: Implement parsing

  // TODO: Implement code generation

  return COMPILER_FILE_COMPILED_OK;
}
