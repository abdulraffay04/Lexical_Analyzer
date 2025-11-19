%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
FILE *tokens_fp=NULL;
FILE *errors_fp=NULL;
void emit_token(const char *t,const char *l){printf("Line %d: %s -> %s\n",yylineno,t,l);if(tokens_fp)fprintf(tokens_fp,"Line %d: %s -> %s\n",yylineno,t,l);}
void emit_error(const char *l){if(errors_fp)fprintf(errors_fp,"Line %d: ERROR -> %s\n",yylineno,l);}
%}
%option noyywrap
%option yylineno

DIGIT [0-9]
LETTER [A-Za-z_]
IDENT {LETTER}({LETTER}|{DIGIT})*
INT {DIGIT}+
FLOAT {DIGIT}+\.{DIGIT}+
EXP ({INT}|{FLOAT})[eE][+-]?{INT}
ESCSEQ \\([ntr"\'\\])
STRING \"([^\"\\\n]|\\{ESCSEQ})*\"
CHAR \'([^\'\\\n]|\\{ESCSEQ})\'
WS [ \t\r]+
NL \n
%%

"//".*                             {}
"/*"([^*]|\*+[^/*])*\*+"/"         {}

"<<<"                              { emit_token("PUNC_BLOCK_START",yytext); }
">>>"                              { emit_token("PUNC_BLOCK_END",yytext); }
"!"                                { emit_token("PUNC_ENDST",yytext); }
"?"                                { emit_token("PUNC_COMMA",yytext); }
"~"                                { emit_token("PUNC_TILDE",yytext); }
";"                                { emit_token("PUNC_SEMICOLON",yytext); }
"("                                { emit_token("PUNC_LPAREN",yytext); }
")"                                { emit_token("PUNC_RPAREN",yytext); }
"{"                                { emit_token("PUNC_LBRACE",yytext); }
"}"                                { emit_token("PUNC_RBRACE",yytext); }

"grow\\+\\+"                       { emit_token("OP_INC","grow++"); }
"shrink--"                         { emit_token("OP_DEC","shrink--"); }
"grow\\+\\+{DIGIT}*"               { emit_error(yytext); } /* catch grow++123 style if needed */

"plusy"                            { emit_token("OP_PLUS",yytext); }
"minusy"                           { emit_token("OP_MINUS",yytext); }
"timesy"                           { emit_token("OP_MUL",yytext); }
"cutsy"                            { emit_token("OP_DIV",yytext); }
"leftover"                         { emit_token("OP_MOD",yytext); }
"glue"                             { emit_token("OP_ASSIGN",yytext); }
"sameSame"                         { emit_token("OP_EQ",yytext); }
"diffDiff"                         { emit_token("OP_NEQ",yytext); }
"biggerish"                        { emit_token("OP_GT",yytext); }
"smallerish"                       { emit_token("OP_LT",yytext); }
"alsoAlso"                         { emit_token("LOGICAL_AND",yytext); }
"maybeMaybe"                       { emit_token("LOGICAL_OR",yytext); }

"BeginNow"                         { emit_token("KEYWORD",yytext); }
"StopNow"                          { emit_token("KEYWORD",yytext); }
"Numbo"                            { emit_token("KEYWORD",yytext); }
"Wordy"                            { emit_token("KEYWORD",yytext); }
"Trutho"                           { emit_token("KEYWORD",yytext); }
"SayIt"                            { emit_token("KEYWORD",yytext); }
"TellMe"                           { emit_token("KEYWORD",yytext); }
"MaybeIf"                          { emit_token("KEYWORD",yytext); }
"Otherwise"                        { emit_token("KEYWORD",yytext); }
"LoopDee"                          { emit_token("KEYWORD",yytext); }
"RoundyGo"                         { emit_token("KEYWORD",yytext); }
"SnapOut"                          { emit_token("KEYWORD",yytext); }
"KeepGoing"                        { emit_token("KEYWORD",yytext); }
"SendBack"                         { emit_token("KEYWORD",yytext); }
"DoStuff"                          { emit_token("KEYWORD",yytext); }
"DoneStuff"                        { emit_token("KEYWORD",yytext); }
"Yep"                              { emit_token("BOOL_TRUE",yytext); }
"Nope"                             { emit_token("BOOL_FALSE",yytext); }

{EXP}                              { emit_token("NUMBER_EXP",yytext); }
{FLOAT}                            { emit_token("NUMBER_FLOAT",yytext); }
{INT}                              { emit_token("NUMBER_INT",yytext); }
{STRING}                           { emit_token("STRING_LITERAL",yytext); }
{CHAR}                             { emit_token("CHAR_LITERAL",yytext); }

{IDENT}                            { emit_token("IDENTIFIER",yytext); }

{WS}                               {}
{NL}                               {}

.                                  { emit_error(yytext); }
%%

int main(int argc,char **argv){
if(argc<2){fprintf(stderr,"Usage: %s <input>\n",argv[0]);return 1;}
yyin=fopen(argv[1],"r");if(!yyin){perror("open input");return 1;}
tokens_fp=fopen("tokens.txt","w");if(!tokens_fp){perror("open tokens");return 1;}
errors_fp=fopen("errors.txt","w");if(!errors_fp){perror("open errors");return 1;}
yylex();
long p=ftell(errors_fp);
if(p<40)fprintf(errors_fp,"No lexical errors detected.\n");
fclose(yyin);fclose(tokens_fp);fclose(errors_fp);
return 0;
}
