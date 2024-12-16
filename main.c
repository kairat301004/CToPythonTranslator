#include <stdio.h>
#include <stdlib.h>

// Объявления внешних переменных и функций из lexer.l и parser.y
extern FILE *yyin, *yyout;
extern int yyparse();

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <input file> <output file>\n", argv[0]);
        return 1;
    }

    // Открываем входной и выходной файлы
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    yyout = fopen(argv[2], "w");
    if (!yyout) {
        perror("Error opening output file");
        fclose(yyin);
        return 1;
    }

    // Запуск парсинга
    if (yyparse() != 0) {
        fprintf(stderr, "Parsing failed.\n");
    }

    // Закрываем файлы
    fclose(yyin);
    fclose(yyout);

    return 0;
}
