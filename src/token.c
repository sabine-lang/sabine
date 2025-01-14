//
// Created by Orzklv on 28/11/24.
//

#include "token.h"
#include "lexer.h"

bool token_is_keyword(struct token *token, const char *value)
{
  return token->type == TOKEN_TYPE_KEYWORD && S_EQ(token->sval, value);
}
