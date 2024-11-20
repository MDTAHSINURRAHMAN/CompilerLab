%{
#include <stdio.h>

int keyword = 0;
int identifier = 0;
int number = 0;
int operator = 0;
FILE *outputFile;
%}

%option noyywrap
               
LOOP explore
BREAK halt
END closure
IF verify
THEN proceed
ELSE fallback
PRINT display
READ input
VARIABLE entity
RETURN deliver
FUNCTION task

IDENTIFIER [a-zA-Z_][a-zA-Z_0-9]*
NUMBER [0-9]+
OPERATOR [+\-*/=<>!]+
WHITESPACE [ \t\n]+

%%

\"[^\"]*\"  { }
explore        { keyword++; }
halt           { keyword++; }
closure        { keyword++; }
verify         { keyword++; }
proceed        { keyword++; }
fallback       { keyword++; }
display        { keyword++; }
input          { keyword++; }
entity         { keyword++; }
deliver        { keyword++; }
task           { keyword++; }

{IDENTIFIER}   { identifier++; }
{NUMBER}       { number++; }
{OPERATOR}     { operator++; }

{WHITESPACE}   { }

. {}

%%

int main() {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    if (!yyin) {
        fprintf(stderr, "Error opening input file\n");
        return 1;
    }

    if (!yyout) {
        fprintf(stderr, "Error opening output file\n");
        return 1;
    }

    yylex();

    // Console Output
    printf("===== Lexical Analysis Summary =====\n");
    printf("Category          Count\n");
    printf("------------------------------------\n");
    printf("Keywords:         %d\n", keyword);
    printf("Identifiers:      %d\n", identifier);
    printf("Numbers:          %d\n", number);
    printf("Operators:        %d\n", operator);
    printf("====================================\n");

    // File Output
    fprintf(yyout, "===== Lexical Analysis Summary =====\n");
    fprintf(yyout, "Category          Count\n");
    fprintf(yyout, "------------------------------------\n");
    fprintf(yyout, "Keywords:         %d\n", keyword);
    fprintf(yyout, "Identifiers:      %d\n", identifier);
    fprintf(yyout, "Numbers:          %d\n", number);
    fprintf(yyout, "Operators:        %d\n", operator);
    fprintf(yyout, "====================================\n");

    fclose(yyin);
    fclose(yyout);

    return 0;
}
