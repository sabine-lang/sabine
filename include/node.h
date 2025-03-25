//
// Created by Orzklv on 15/01/25.
//

#ifndef SABINE_NODE_H
#define SABINE_NODE_H

#include "sabine/vector.h"
#include "token.h"

enum { PARSE_ALL_OK, PARSE_GENERAL_ERROR };

enum {
  NODE_TYPE_EXPRESSION,
  NODE_TYPE_EXPRESSION_PARENTHESES,

  // Literal values
  NODE_TYPE_NUMBER,
  NODE_TYPE_IDENTIFIER,
  NODE_TYPE_STRING,

  NODE_TYPE_VARIABLE,
  NODE_TYPE_VARIABLE_LIST,
  NODE_TYPE_FUNCTION,
  NODE_TYPE_BODY,

  NODE_TYPE_STATEMENT_RETURN,
  NODE_TYPE_STATEMENT_IF,
  NODE_TYPE_STATEMENT_ELSE,
  NODE_TYPE_STATEMENT_WHILE,
  NODE_TYPE_STATEMENT_DO_WHILE,
  NODE_TYPE_STATEMENT_FOR,
  NODE_TYPE_STATEMENT_BREAK,
  NODE_TYPE_STATEMENT_CONTINUE,
  NODE_TYPE_STATEMENT_SWITCH,
  NODE_TYPE_STATEMENT_CASE,
  NODE_TYPE_STATEMENT_DEFAULT,
  NODE_TYPE_STATEMENT_GOTO,

  NODE_TYPE_UNARY,
  NODE_TYPE_TENARY,
  NODE_TYPE_LABEL,
  NODE_TYPE_STRUCT,
  NODE_TYPE_UNION,
  NODE_TYPE_BRACKET,
  NODE_TYPE_CAST,
  NODE_TYPE_BLANK
};

enum { NODE_FLAG_INSIDE_EXPRESSION = 0b00000001 };

struct node {
  int type;
  int flags;

  struct pos pos;

  struct node_binded {
    // Pointer to our body node
    struct node *owner;

    // Pointer to the function this node is in.
    struct node *function;
  } binded;

  union {
    struct exp {
      struct node *left;
      struct node *right;
      const char *op;
    } exp;
  };

  union {
    char cval;
    const char *sval;
    unsigned int inum;
    unsigned long lnum;
    unsigned long long llnum;
  };
};

void node_set_vector(struct vector *vec, struct vector *root_vec);

void node_push(struct node *node);

struct node *node_peek_or_null();

struct node *node_peek();

struct node *node_pop();

struct node *node_create(struct node *_node);

void *make_exp_node(struct node *left_node, struct node *right_node,
                    const char *op);

bool node_is_expressionable(struct node *node);

struct node *node_peek_expressionable_or_null();

#endif // SABINE_NODE_H
