//
// Created by Orzklv on 22/11/24.
//

#ifndef SABINE_PROCESS_H
#define SABINE_PROCESS_H

#include "token.h"
#include <stdio.h>

struct compile_process {
  // Extra params for compilation
  int flags;

  struct pos pos;
  struct compile_process_input_file {
    FILE *fp;
    const char *abs_path;
  } cfile;

  // Vector of tokens from lexical analysis
  struct vector *token_vec;

  // Node vectors
  struct vector *node_vec;
  struct vector *node_tree_vec;

  FILE *ofile;
};

struct compile_process *compile_process_create(const char *filename,
                                               const char *filename_out,
                                               int flags);

#endif // SABINE_PROCESS_H
