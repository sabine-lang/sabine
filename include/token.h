//
// Created by Orzklv on 22/11/24.
//

#ifndef SABINE_TOKEN_H
#define SABINE_TOKEN_H

#include <stdbool.h>

struct pos {
  /* Which */
  int line;
  /* What */
  int col;
  /* Where */
  const char *filename;
};

/* Token Types */
enum {
  TOKEN_TYPE_IDENTIFIER,
  TOKEN_TYPE_KEYWORD,
  TOKEN_TYPE_OPERATOR,
  TOKEN_TYPE_SYMBOL,
  TOKEN_TYPE_NUMBER,
  TOKEN_TYPE_STRING,
  TOKEN_TYPE_COMMENT,
  TOKEN_TYPE_NEWLINE
};

enum {
  NUMBER_TYPE_NORMAL,
  NUMBER_TYPE_LONG,
  NUMBER_TYPE_FLOAT,
  NUMBER_TYPE_DOUBLE
};

/* A Token */
struct token {
  int type;
  int flags;
  struct pos pos;

  union {
    char cval;
    const char *sval;
    unsigned int inum;
    unsigned long lnum;
    unsigned long long llnum;
    void *any;
  };

  struct token_number {
    int type;
  } num;

  /* Whether between token and next token */
  bool whitespace;

  /* For debugging purposes */
  const char *between_brackets;
};

bool token_is_keyword(struct token *token, const char *value);
bool token_is_symbol(struct token *token, char c);

bool token_is_nl_or_comment_or_newline_seperator(struct token *token);

#endif // SABINE_TOKEN_H
