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

### Functions that implemented on language

```
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
```

```
int checkIdent(char * name)
{
	int i;
	for(i=0; i< 100; i++)
	{
		if(strcmp(mem[i].name,name) == 0) return 1;
	}
	return 0;
}
```

```
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
```


```
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
```

```
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
```

```
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
```

```
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
```


```
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

```










### BNF Notation of Variable Declarations

```
stmts   	: stmt SEMICOLON            		
		| COMMENT stmts				
        	| stmt SEMICOLON stmts	     		
		;

stmt   		 : TYPE_INT IDENT			
		| TYPE_INT IDENT ASSIGNMENT exp		
		| TYPE_STR IDENT			
		| TYPE_STR IDENT ASSIGNMENT STRING	
		| IDENT ASSIGNMENT STRING		
		| IDENT ASSIGNMENT exp			

```

### BNF Notation of Arithmetic Operators

```
exp    		: factor                   
       		| exp PLUS factor       
       		| exp MINUS factor         
       		;

factor		: term			    
		| factor STAR term	    
		| factor SLASH term	    
		| factor MOD term           
		;

term   		: INTEGER                   
		| IDENT			    

```

### BNF Notation of Logical Operators and Loops 

```
stmt    	: IF condt scope		{;}	
		| WHILE condt scope		{;}
		;

condt		: exp GT condt						
		| exp ST condt 						
		| exp EQUAL condt					
		| exp NEQUAL condt					
		| exp SEQUAL condt					
		| exp GEQUAL condt					
		| exp								
		;

```


