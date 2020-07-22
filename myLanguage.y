%{

extern int yylex();
extern int yylineno;
extern char * yytext;
void yyerror (char *s);

#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

int findIdent(char * name);
void saveStr(char * name, char * value);
void saveInt(char * name, int value);
void modifyStr(char * name, char * value);
void modifyInt (char * name, int value);
int checkIdent(char * name);
int getIntValue(char * name);
char * getStrValue(char * name);

typedef struct
{
	char name[31];
	int isInt;
	char strValue[100];
	int intValue;
}ident;

ident mem[100];
int position = 0;

%}

%union {int i; char c[30];}

%start stmts

%token TYPE_INT
%token TYPE_STR
%token COMMENT
%token ASSIGNMENT
%token <i> INTEGER
%token <c> STRING
%token EXIT
%token SEMICOLON
%token COLON
%token INCLUDE 
%token <c> IDENT 
%token PLUS 
%token MINUS 
%token STAR 
%token SLASH 
%token MOD
%token IF
%token WHILE
%token ELSE
%token OPEN_SCOPE
%token CLOSE_SCOPE
%token OUTPUT
%token OUTPUTC
%token <i> INPUT
%token <c> INPUTC
%token ST;
%token GT;
%token EQUAL;
%token NEQUAL;
%token SEQUAL;
%token GEQUAL;

%type <i> exp
%type <i> factor
%type <i> term

%%