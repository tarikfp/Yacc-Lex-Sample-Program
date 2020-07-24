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


stmts   : stmt SEMICOLON            		{;}
		| COMMENT stmts						{;}
        | stmt SEMICOLON stmts	     		{;}
		;

stmt    : TYPE_INT IDENT					{saveInt($2,0);}
		| TYPE_INT IDENT ASSIGNMENT exp		{saveInt($2,$4);}
		| TYPE_STR IDENT					{saveStr($2,"");}
		| TYPE_STR IDENT ASSIGNMENT STRING	{saveStr($2,$4);}
		| IDENT ASSIGNMENT STRING			{modifyStr($1,$3);}
		| IDENT ASSIGNMENT exp				{modifyInt($1,$3);}
		| io								{;}
        | EXIT			  					{exit(EXIT_SUCCESS);}
        | exp								{;}
		| SEMICOLON							{;}
		| IF condt scope					{;}	
		| WHILE condt scope					{;}
		;

scope	: OPEN_SCOPE stmts CLOSE_SCOPE		;
		| stmt								;
		;

condt	: exp GT condt						
		| exp ST condt 						
		| exp EQUAL condt					
		| exp NEQUAL condt					
		| exp SEQUAL condt					
		| exp GEQUAL condt					
		| exp								
		;									


io		: OUTPUT exp						{printf("%d\n",$2);}
		| OUTPUT STRING						{yyerror("ERROR - Value is not an integer");}
		| OUTPUTC STRING					{printf("%s\n",$2);}
		| OUTPUTC IDENT						{printf("%s\n",getStrValue($2));}
		| OUTPUTC INTEGER					{yyerror("ERROR - Value is not a string");}
		| INPUT IDENT						{scanf("%d",&mem[findIdent($2)].intValue);}
		| INPUTC IDENT						{char s[100];scanf("%s",s); modifyStr($1,s);} 
		;

exp    	: factor                  			{$$ = $1;}
       	| exp PLUS factor          			{$$ = $1 + $3;}
       	| exp MINUS factor          		{$$ = $1 - $3;}
       	;

factor	: term								{$$ = $1;}
		| factor STAR term					{$$ = $1 * $3;}
		| factor SLASH term					{$$ = $1 / $3;}
		| factor MOD term					{$$ = $1 % $3;}
		;

term   	: INTEGER                			{$$ = $1;}
		| IDENT								{$$ = getIntValue($1);}
        ;

%%

int findIdent(char * name)
{
	int i;
	for(i=0; i< 100; i++)
	{
		if(strcmp(mem[i].name,name) == 0) return i;
	}
	fprintf (stderr, "Variable \"%s\" is not declared\n", name);
	exit(1);
}

int checkIdent(char * name)
{
	int i;
	for(i=0; i< 100; i++)
	{
		if(strcmp(mem[i].name,name) == 0) return 1;
	}
	return 0;
}

int getIntValue(char * name)
{
	int position = findIdent(name);
	if(mem[position].isInt == 0) 
	{
		fprintf(stderr, "ERROR: %s is not an integer\n", name);
		exit(1);
	}
	
	return mem[position].intValue;
}

char * getStrValue(char * name)
{
	int position = findIdent(name);
	if(mem[position].isInt == 1) 
	{
		fprintf(stderr, "ERROR: %s is not a string\n", name);
		exit(1);
	}
	
	return mem[position].strValue;
}

void modifyInt (char * name, int value)
{
	int position = findIdent(name);
	if(mem[position].isInt == 0) 
	{
		fprintf(stderr, "ERROR: %s is not an integer\n", name);
		exit(1);
	}
	mem[position].intValue = value;
}

void modifyStr(char * name, char * value)
{
	int position = findIdent(name);
	if(mem[position].isInt == 1) 
	{
		fprintf(stderr, "ERROR: %s is not a string\n", name);
		exit(1);
	}
	strcpy(mem[findIdent(name)].strValue,value);
}

void saveInt(char * name, int value)
{
	if(checkIdent(name))
	{
		fprintf(stderr, "ERROR: %s has already been declared\n", name);
		exit(1);
	}

	strcpy(mem[position].name,name);
	mem[position].isInt = 1;
	mem[position].intValue = value;
	position++;
}


void saveStr(char * name, char * value)
{
	if(checkIdent(name))
	{
		fprintf(stderr, "ERROR: %s has already been declared\n", name);
		exit(1);
	}

	strcpy(mem[position].name,name);
	strcpy(mem[position].strValue,value);
	mem[position].isInt = 0;
	position++;
}

int main (void) 
{
	int i;
	for(i=0; i<100; i++) {
		strcpy(mem[i].name,"");
	}
	return yyparse ( );
}

void yyerror (char *s)
{
	fprintf (stderr, "%s at line %d ( %s )\n", s, yylineno, yytext);
	exit(1);
} 
