//
// Created by Orzklv on 22/11/24.
//

#ifndef SABINE_PROCESS_H
#define SABINE_PROCESS_H

#include <stdio.h>

struct compile_process
{
  // Extra params for compilation
  int flags;

  struct compile_process_input_file
  {
    FILE* fp;
    const char* abs_path;
  } cfile;

  FILE* ofile;
};

struct compile_process *compile_process_create(const char *filename,
                                               const char *filename_out,
                                               int flags);


#endif // SABINE_PROCESS_H
