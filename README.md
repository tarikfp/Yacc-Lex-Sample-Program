# tarik-yacc

### Project Group Member
Tarık Fatih PINARCI

### About The Language

In my lexical code, I defined regular expression such as 

```
[0-9][0-9]*                	     {yylval.i = atoi(yytext);return INTEGER;}
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

### String Declarations

```
\"[a-zA-Z0-9\ ]*\"          {strcpy(yylval.c,yytext);return STRING;}
```

As we can understand, user must define a char form of “[a-zA-Z]+”

For example;

```
"AAbb" is a string
9459 is NOT a string
0,734734 is NOT a string
```

### Rules of Arithmetic Operators and Their Precedence
#### Addition Operator(+)

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"+"                               return PLUS;
```

For example;

```
1+2; is acceptable and result is 3
1++2; is NOT acceptable
```

