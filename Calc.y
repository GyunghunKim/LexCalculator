/*
 * YACC는 문법규칙을 위한 파일이다.
 * 
 * lexx.yy.c와 Calc.tab.c를 컴파일하면 컴파일러가 만들어진다.
 * 
 * 작성된 컴파일러는 main 함수에서 yyparse()를 호출한다.
 * 이는 자동적으로 yylex를 호출하여 토큰을 얻어낸다.
 *
 * bison 코드는 크게 세 가지 부분으로 이루어진다.
 * Definitions %% Rules %% Subroutines
 */

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
