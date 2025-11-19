%{
#include <stdio.h>
#include <string.h>

FILE *tokens;
FILE *errors;
int line = 1;

void tok(const char* t, const char* v) {
    printf("Line %d: %s -> %s\n", line, t, v);
    fprintf(tokens, "Line %d: %s -> %s\n", line, t, v);
}

void err(const char* v) {
    fprintf(errors, "Line %d: ERROR -> %s\n", line, v);
}
%}

%option noyywrap
%option yylineno

DIGIT      [0-9]
LETTER     [A-Za-z_]
IDENT      {LETTER}({LETTER}|{DIGIT})*
INT        {DIGIT}+
FLOAT      {DIGIT}+\.{DIGIT}+
EXP        ({INT}|{FLOAT})[eE][+-]?{INT}
STRING     \"([^\"\\\n]|\\.)*\"
CHAR       \'([^\'\\\n]|\\.)\'
SPACE      [ \t\r]+
NL         \n

%%

"BeginNow" {tok("KEYWORD","BeginNow");}
"StopNow" {tok("KEYWORD","StopNow");}
"Numbo" {tok("KEYWORD","Numbo");}
"Wordy" {tok("KEYWORD","Wordy");}
"Trutho" {tok("KEYWORD","Trutho");}
"Yep" {tok("BOOL","Yep");}
"Nope" {tok("BOOL","Nope");}
"SayIt" {tok("PRINT","SayIt");}
"TellMe" {tok("INPUT","TellMe");}
"MaybeIf" {tok("IF","MaybeIf");}
"Otherwise" {tok("ELSE","Otherwise");}
"LoopDee" {tok("WHILE","LoopDee");}
"RoundyGo" {tok("FOR","RoundyGo");}
"SnapOut" {tok("BREAK","SnapOut");}
"KeepGoing" {tok("CONTINUE","KeepGoing");}
"SendBack" {tok("RETURN","SendBack");}
"DoStuff" {tok("FUNC","DoStuff");}
"DoneStuff" {tok("END","DoneStuff");}

"plusy" {tok("OP","+");}
"minusy" {tok("OP","-");}
"timesy" {tok("OP","*");}
"cutsy" {tok("OP","/");}
"leftover" {tok("OP","%");}
"glue" {tok("OP","=");}
"sameSame" {tok("OP","==");}
"diffDiff" {tok("OP","!=");}
"biggerish" {tok("OP",">");}
"smallerish" {tok("OP","<");}
"grow\\+\\+" {tok("INC","++");}
"shrink--" {tok("DEC","--");}
"alsoAlso" {tok("LOGIC","&&");}
"maybeMaybe" {tok("LOGIC","||");}

"<<<" {tok("PUNC","<<<");}
">>>" {tok("PUNC",">>>");}
"!"   {tok("PUNC","!");}
"?"   {tok("PUNC","?");}
"~"   {tok("PUNC","~");}

{EXP} {tok("NUMBER",yytext);}
{FLOAT} {tok("NUMBER",yytext);}
{INT} {tok("NUMBER",yytext);}
{STRING} {tok("STRING",yytext);}
{CHAR} {tok("CHAR",yytext);}
{IDENT} {tok("IDENT",yytext);}

{SPACE} {}
{NL} {line++;}

. {err(yytext);}

%%

int main(int argc, char** argv) {

    if (argc < 2) {
        printf("Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");

    tokens = fopen("tokens.txt", "w");
    errors = fopen("errors.txt", "w");

    yylex();

    fclose(tokens);
    fclose(errors);

    return 0;
}
