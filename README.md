# tarik-yacc

### Project Group Member
Tarık Fatih PINARCI

### About The Language

In my lexical code, I defined regular expression such as 

```
[0-9][0-9]*                	     {yylval.i = atoi(yytext);return INTEGER;}
\"[a-zA-Z0-9\ ]*\"               {strcpy(yylval.c,yytext);return STRING;}

```

#### Integer Declarations

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}

```

For example;

```
55 is num
9459 is num
aaa is NOT num
```

#### String Declarations

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

##### Moreover, for better and realistic architecture, we have to add semicolon for each calculating statement.

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"+"                               return PLUS;
```

For example;

```
1+2; is acceptable and result is 3
1++2; is NOT acceptable
```

#### Substraction Operator(-)
```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"-"                                return MINUS;
```
 

For example;

```
1-2; is acceptable and result is -1
1-2  is NOT acceptable
1--2 is NOT acceptable
```

#### Multiplication Operator(*)

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"*"                               return STAR;
```

For example;

```
1*2; is acceptable and result is 2
1*2  is NOT acceptable
1**2 is NOT acceptable
```

#### Division Operator(/)

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"/"                               return SLASH;
```

For example;

```
20/2; is acceptable and result is 10
20/2  is NOT acceptable
20//2 is NOT acceptable
```

#### Modulus Operator(%)

```
[0-9][0-9]*                 {yylval.i = atoi(yytext);return INTEGER;}
"%"                              return MOD;
```

For example;

```
20%2; is acceptable and result is 0
20%2 is NOT acceptable
20%%2 is NOT acceptable
```

### Precedence of the language's arithmetic operations

Precedence Order:
1-Multiplication(*)-Division(/)-Modulus(%)
2-Addition(+)-Substraction(-)

For example;

```
50+2*3;  This statement is valid and result is 56 (Use output command in order to see result in cmd)
```


### BNF Notation of Variable Declarations

```
stmts   		: stmt SEMICOLON            		{;}
		| COMMENT stmts					{;}
        		| stmt SEMICOLON stmts	     		{;}
		;

stmt   		 : TYPE_INT IDENT				{saveInt($2,0);}
		| TYPE_INT IDENT ASSIGNMENT exp			{saveInt($2,$4);}
		| TYPE_STR IDENT			   	{saveStr($2,"");}
		| TYPE_STR IDENT ASSIGNMENT STRING		{saveStr($2,$4);}
		| IDENT ASSIGNMENT STRING			{modifyStr($1,$3);}
		| IDENT ASSIGNMENT exp				{modifyInt($1,$3);}

```

### BNF Notation of Arithmetic Operators

```
exp    		: factor                    {$$ = $1;}
       		| exp PLUS factor           {$$ = $1 + $3;}
       		| exp MINUS factor          {$$ = $1 - $3;}
       		;

factor		: term			    {$$ = $1;}
		| factor STAR term	    {$$ = $1 * $3;}
		| factor SLASH term	    {$$ = $1 / $3;}
		| factor MOD term           {$$ = $1 % $3;}
		;

term   		: INTEGER                   {$$ = $1;}
		| IDENT			    {$$ = getIntValue($1);}

```




