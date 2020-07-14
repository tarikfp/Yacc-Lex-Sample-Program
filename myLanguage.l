%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    #include <string.h>
    int yylineno = 1;

%}

%%

"int"                       return TYPE_INT;
"str"                       return TYPE_STR;
\=                          return ASSIGNMENT;
\/\/.*                      return COMMENT;

[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
\"[a-zA-Z0-9\ ]*\"          {strcpy(yylval.c,yytext);return STRING;}

"exit"                      return EXIT;

;                           return SEMICOLON;
:                           return COLON;

"+"                         return PLUS;
"-"                         return MINUS;
"*"                         return STAR;
"/"                         return SLASH;
"%"                         return MOD;

"if"                        return IF;
"while"                     return WHILE;
"else"                      return ELSE;
"{"                         return OPEN_SCOPE;
"}"                         return CLOSE_SCOPE;

"output"                    return OUTPUT;
"outputc"                   return OUTPUTC;
"input"                     return INPUT;
"inputc"                    return INPUTC;

"<"                         return ST;
">"                         return GT;
"=="                        return EQUAL;
"!="                        return NEQUAL;
"<="                        return SEQUAL;
">="                        return GEQUAL;

[a-zA-Z][a-zA-Z0-9_]*       {strcpy(yylval.c,yytext);return IDENT;}

[ \t]                       ;
\n                          yylineno++;
.                           printf("ERROR: Invalid token at line %d\n",yylineno);

%%

int yywrap(void)
{
    return 1;
}

