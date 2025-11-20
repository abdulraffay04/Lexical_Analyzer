%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *error_log = NULL;
FILE *token_output = NULL;
%}

%option yylineno
%option noyywrap

DIGIT           [0-9]
LETTER          [a-zA-Z_]
IDENTIFIER      {LETTER}({LETTER}|{DIGIT})*
INTEGER         {DIGIT}+
FLOAT           {DIGIT}+\.{DIGIT}+
EXPONENTIAL     ({INTEGER}|{FLOAT})[eE][+-]?{INTEGER}
STRING          \"[^\"\n]*\"
CHAR            \'[^\'\n]\'

%%

"BeginNow"     { printf("Line %d: T_KEYWORD (BEGIN: BeginNow)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (BEGIN: BeginNow)\n", yylineno); }

"StopNow"      { printf("Line %d: T_KEYWORD (END: StopNow)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (END: StopNow)\n", yylineno); }

"Numbo"        { printf("Line %d: T_KEYWORD (INT: Numbo)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (INT: Numbo)\n", yylineno); }

"Wordy"        { printf("Line %d: T_KEYWORD (STRING: Wordy)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (STRING: Wordy)\n", yylineno); }

"Trutho"       { printf("Line %d: T_KEYWORD (BOOLEAN: Trutho)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (BOOLEAN: Trutho)\n", yylineno); }

"Yep"          { printf("Line %d: T_LITERAL (TRUE: Yep)\n", yylineno);
                  fprintf(token_output, "Line %d: T_LITERAL (TRUE: Yep)\n", yylineno); }

"Nope"         { printf("Line %d: T_LITERAL (FALSE: Nope)\n", yylineno);
                  fprintf(token_output, "Line %d: T_LITERAL (FALSE: Nope)\n", yylineno); }

"MaybeIf"      { printf("Line %d: T_KEYWORD (IF: MaybeIf)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (IF: MaybeIf)\n", yylineno); }

"Otherwise"    { printf("Line %d: T_KEYWORD (ELSE: Otherwise)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (ELSE: Otherwise)\n", yylineno); }

"LoopDee"      { printf("Line %d: T_KEYWORD (WHILE: LoopDee)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (WHILE: LoopDee)\n", yylineno); }

"RoundyGo"     { printf("Line %d: T_KEYWORD (FOR: RoundyGo)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (FOR: RoundyGo)\n", yylineno); }

"SayIt"        { printf("Line %d: T_KEYWORD (PRINT: SayIt)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (PRINT: SayIt)\n", yylineno); }

"TellMe"       { printf("Line %d: T_KEYWORD (INPUT: TellMe)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (INPUT: TellMe)\n", yylineno); }

"DoStuff"      { printf("Line %d: T_KEYWORD (FUNCTION: DoStuff)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (FUNCTION: DoStuff)\n", yylineno); }

"DoneStuff"    { printf("Line %d: T_KEYWORD (END FUNCTION: DoneStuff)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (END FUNCTION: DoneStuff)\n", yylineno); }

"KeepGoing"    { printf("Line %d: T_KEYWORD (CONTINUE: KeepGoing)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (CONTINUE: KeepGoing)\n", yylineno); }

"SnapOut"      { printf("Line %d: T_KEYWORD (BREAK: SnapOut)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (BREAK: SnapOut)\n", yylineno); }

"SendBack"     { printf("Line %d: T_KEYWORD (RETURN: SendBack)\n", yylineno);
                  fprintf(token_output, "Line %d: T_KEYWORD (RETURN: SendBack)\n", yylineno); }


"plusy"        { printf("Line %d: T_OP (+: plusy)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (+: plusy)\n", yylineno); }

"minusy"       { printf("Line %d: T_OP (-: minusy)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (-: minusy)\n", yylineno); }

"timesy"       { printf("Line %d: T_OP (*: timesy)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (*: timesy)\n", yylineno); }

"cutsy"        { printf("Line %d: T_OP (/: cutsy)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (/: cutsy)\n", yylineno); }

"leftover"     { printf("Line %d: T_OP (%%: leftover)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (%%: leftover)\n", yylineno); }

"glue"         { printf("Line %d: T_OP (=: glue)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (=: glue)\n", yylineno); }

"sameSame"     { printf("Line %d: T_OP (==: sameSame)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (==: sameSame)\n", yylineno); }

"diffDiff"     { printf("Line %d: T_OP (!=: diffDiff)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (!=: diffDiff)\n", yylineno); }

"biggerish"    { printf("Line %d: T_OP (>: biggerish)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (>: biggerish)\n", yylineno); }

"smallerish"   { printf("Line %d: T_OP (<: smallerish)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (<: smallerish)\n", yylineno); }

"grow\+\+"    { printf("Line %d: T_OP (++: grow++)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (++: grow++)\n", yylineno); }

"shrink--"     { printf("Line %d: T_OP (--: shrink--)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (--: shrink--)\n", yylineno); }

"alsoAlso"     { printf("Line %d: T_OP (&&: alsoAlso)\n", yylineno);
                  fprintf(token_output, "Line %d: T_OP (&&: alsoAlso)\n", yylineno); }


"<<<"          { printf("Line %d: T_PUNC (BLOCK_START: <<<)\n", yylineno);
                  fprintf(token_output, "Line %d: T_PUNC (BLOCK_START: <<<)\n", yylineno); }

">>>"          { printf("Line %d: T_PUNC (BLOCK_END: >>>)\n", yylineno);
                  fprintf(token_output, "Line %d: T_PUNC (BLOCK_END: >>>)\n", yylineno); }

"!"            { printf("Line %d: T_PUNC (END: !)\n", yylineno);
                  fprintf(token_output, "Line %d: T_PUNC (END: !)\n", yylineno); }

"?"            { printf("Line %d: T_PUNC (COMMA/SEP: ?)\n", yylineno);
                  fprintf(token_output, "Line %d: T_PUNC (COMMA/SEP: ?)\n", yylineno); }

"~"            { printf("Line %d: T_PUNC (PARAM_SEP: ~)\n", yylineno);
                  fprintf(token_output, "Line %d: T_PUNC (PARAM_SEP: ~)\n", yylineno); }

{EXPONENTIAL}   { printf("Line %d: T_LITERAL (EXPONENTIAL: %s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_LITERAL (EXPONENTIAL: %s)\n", yylineno, yytext); }

{FLOAT}         { printf("Line %d: T_LITERAL (FLOAT: %s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_LITERAL (FLOAT: %s)\n", yylineno, yytext); }

{INTEGER}       { printf("Line %d: T_LITERAL (INT: %s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_LITERAL (INT: %s)\n", yylineno, yytext); }

{STRING}        { printf("Line %d: T_LITERAL (STRING: %s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_LITERAL (STRING: %s)\n", yylineno, yytext); }

{CHAR}          { printf("Line %d: T_LITERAL (CHAR: %s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_LITERAL (CHAR: %s)\n", yylineno, yytext); }

{IDENTIFIER}    { printf("Line %d: T_IDENTIFIER (%s)\n", yylineno, yytext);
                  fprintf(token_output, "Line %d: T_IDENTIFIER (%s)\n", yylineno, yytext); }

[ \t\r]+        { }

\n              { }

"//".*          { }

.               { fprintf(stderr, "Line %d: Lexical ERROR - Illegal character '%s'\n", yylineno, yytext);
                  fprintf(error_log, "Line %d: Lexical ERROR - Illegal character '%s'\n", yylineno, yytext); }

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
        exit(1);
    }

    token_output = fopen("tokens.txt", "w");
    error_log = fopen("error_log.txt", "w");

    if (token_output == NULL || error_log == NULL) {
        fprintf(stderr, "Error: Cannot create output files\n");
        exit(1);
    }

    fprintf(error_log, "--- Lexical Analysis Error Log ---\n");

    printf("\nLEXICAL ANALYSIS\\n\n");
    yylex();
    printf("\n ANALYSIS COMPLETE \n");

    long error_pos = ftell(error_log);
    if (error_pos == (long)strlen("--- Lexical Analysis Error Log ---\n")) {
        fprintf(error_log, "No lexical errors detected.\n");
    }

    fclose(yyin);
    fclose(token_output);
    fclose(error_log);

    printf("\nTokens saved to: tokens.txt\n");
    printf("Errors saved to: error_log.txt\n\n");

    return 0;
}
