%{
#include<stdio.h>
double reg[25];
%}
%union
{
double val;
int idno;
}
%token<idno>NAME
%token<val>NUMBER
%left'+''-'
%left'*''/'
%nonassoc UMINUS
%type<val>expr
%%
program:statement'\n'
	   |program statement'\n'
;
statement:NAME'='expr{reg[$1]=$3;}
		 |expr{printf("=%g\n",$1);}
;
expr:expr'+'expr{$$=$1+$3;}
	|expr'-'expr{$$=$1-$3;}
	|expr'*'expr{$$=$1*$3;}
	|expr'/'expr{$$=$1/$3;}
	|'-'expr %prec UMINUS{$$=-$2;}
	|'('expr')'{$$=$2;}
	|NUMBER
	|NAME{$$=reg[$1];}
;
%%
//extern int yydebug;
//yydebug = 1;
int main (void)
{
return yyparse();
}
yyerror(s)
char *s;
{
printf("%s.\n",s);
}
