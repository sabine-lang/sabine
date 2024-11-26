//
// Created by Orzklv on 22/11/24.
//

#ifndef SABINE_COMPILER_H
#define SABINE_COMPILER_H

#include "lexer.h"

int compile_file(const char *filename, const char *out_filename, int flags);

char compile_process_next_char(struct lex_process *lex_process);
char compile_process_peek_char(struct lex_process *lex_process);
void compile_process_push_char(struct lex_process *lex_process, char c);

void compiler_error(struct compile_process *compiler, const char *msg, ...);
void compiler_warning(struct compile_process *compiler, const char *msg, ...);

#endif // SABINE_COMPILER_H
