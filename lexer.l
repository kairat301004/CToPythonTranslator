%{
#include "parser.tab.h"
#include <string.h>
%}

%%

"int"               { return INT; }
"double"            { return DOUBLE; }
"char"              { return CHAR; }
"float"             { return FLOAT; }
"if"                { return IF; }
"else"              { return ELSE; }
"printf"            { return PRINT; }
"switch"            { return SWITCH; }
"case"              { return CASE; }
"default"           { return DEFAULT; }
"while"             { return WHILE; }
"break"             { return BREAK; }
"continue"          { return CONTINUE; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
";"                 { return SEMICOLON; }
":"                 { return COLON; }
"="                 { return ASSIGN; }
">"                 { return GREATER; }
"<"                 { return LESS; }
"=="                { return EQUALS; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return TIMES; }
"/"                 { return DIVIDE; }
\"([^\\"]|\\.)*\"   { yylval.str = strdup(yytext); return STRING; }
[0-9]+              { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }
[ \t\n]+            { /* Игнорируем пробелы и новые строки */ }
.                   { fprintf(stderr, "Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
