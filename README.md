# tarik-yacc

### Project Group Member
Tarık Fatih PINARCI

### About The Language

In my lexical code, I defined regular expression such as 

```
[0-9][0-9]*                	        {yylval.i = atoi(yytext);return INTEGER;}
\"[a-zA-Z0-9\ ]*\"               {strcpy(yylval.c,yytext);return STRING;}

```

### Integer Declarations

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}

```

For example;

```
55 is num
9459 is num
aaa is NOT num
```



