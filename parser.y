%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

extern FILE *yyin, *yyout;
extern int yylex();
extern void yyerror(const char *s);

void write_indent(int level);
int indent_level = 0;

void write_indent(int level) {
    for (int i = 0; i < level; i++) {
        fprintf(yyout, "    ");
    }
}

// Реализуем asprintf для Windows
int asprintf(char **strp, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int size = vsnprintf(NULL, 0, fmt, args);
    va_end(args);

    if (size < 0) return size;
    *strp = (char *)malloc(size + 1);
    if (!*strp) return -1;

    va_start(args, fmt);
    vsnprintf(*strp, size + 1, fmt, args);
    va_end(args);
    return size;
}
%}

%union {
    char *str;
}

%token <str> IF ELSE PRINT IDENTIFIER NUMBER ASSIGN GREATER LESS EQUALS STRING
%token <str> INT DOUBLE CHAR FLOAT 
%token SWITCH CASE DEFAULT WHILE BREAK CONTINUE COLON PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON 
%type <str> program statement_list statement if_statement print_statement assignment declaration expression
%type <str> switch_statement case_list case while_statement

%start program

// Указание приоритетов для операций
%left PLUS MINUS
%left TIMES DIVIDE
%left GREATER LESS EQUALS
%right ASSIGN

%%

program:
    statement_list
    {
        fprintf(yyout, "%s", $1);
    }
    ;

statement_list:
    statement
    {
        $$ = strdup($1);
    }
    | statement_list statement
    {
        asprintf(&$$, "%s%s", $1, $2);
    }
    ;

statement:
    if_statement
    | print_statement
    | assignment
    | declaration
    | switch_statement
    | while_statement
    | BREAK SEMICOLON
    {
        $$ = strdup("");
    }
    | CONTINUE SEMICOLON
    {
        $$ = strdup("    continue\n");
    }
    ;

if_statement:
    IF LPAREN expression RPAREN LBRACE statement_list RBRACE
    {
        asprintf(&$$, "if %s:\n%s", $3, $6);
    }
    | IF LPAREN expression RPAREN LBRACE statement_list RBRACE ELSE LBRACE statement_list RBRACE
    {
        asprintf(&$$, "if %s:\n%selse:\n%s", $3, $6, $10);
    }
    ;

print_statement:
    PRINT LPAREN expression RPAREN SEMICOLON
    {
        asprintf(&$$, "print(%s)\n", $3);
    }
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    {
        asprintf(&$$, "%s = %s\n", $1, $3);
    }
    ;

declaration:
    INT IDENTIFIER SEMICOLON
    {
        asprintf(&$$, "%s = None\n", $2);
    }
    | INT IDENTIFIER ASSIGN expression SEMICOLON
    {
        asprintf(&$$, "%s = %s\n", $2, $4);
    }
    | DOUBLE IDENTIFIER SEMICOLON
    {
        asprintf(&$$, "%s = None\n", $2);
    }
    | CHAR IDENTIFIER SEMICOLON
    {
        asprintf(&$$, "%s = ''\n", $2);
    }
    | FLOAT IDENTIFIER SEMICOLON
    {
        asprintf(&$$, "%s = None\n", $2);
    }
    ;

switch_statement:
    SWITCH LPAREN expression RPAREN LBRACE case_list RBRACE
    {
        asprintf(&$$, "match %s:\n%s", $3, $6);
    }
    ;

case_list:
    case_list case
    {
        asprintf(&$$, "%s%s", $1, $2);
    }
    | case
    {
        $$ = strdup($1);
    }
    ;

case:
    CASE expression COLON statement_list
    {
        asprintf(&$$, "    case %s:\n%s", $2, $4);
    }
    | DEFAULT COLON statement_list
    {
        asprintf(&$$, "    case _:\n%s", $3);
    }
    ;

while_statement:
    WHILE LPAREN expression RPAREN LBRACE statement_list RBRACE
    {
        asprintf(&$$, "while %s:\n%s", $3, $6);
    }
    ;

expression:
    NUMBER
    {
        $$ = strdup($1);
    }
    | IDENTIFIER
    {
        $$ = strdup($1);
    }
    | STRING
    {
        $$ = strdup($1);
    }
    | expression GREATER expression
    {
        asprintf(&$$, "%s > %s", $1, $3);
    }
    | expression LESS expression
    {
        asprintf(&$$, "%s < %s", $1, $3);
    }
    | expression EQUALS expression
    {
        asprintf(&$$, "%s == %s", $1, $3);
    }
    | expression PLUS expression
    {
        asprintf(&$$, "%s + %s", $1, $3);
    }
    | expression MINUS expression
    {
        asprintf(&$$, "%s - %s", $1, $3);
    }
    | expression TIMES expression
    {
        asprintf(&$$, "%s * %s", $1, $3);
    }
    | expression DIVIDE expression
    {
        asprintf(&$$, "%s / %s", $1, $3);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
