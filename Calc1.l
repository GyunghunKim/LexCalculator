%{
#include <stdlib.h>
void yyerror(char *);
#include "Calc1.tab.h"
%}

%%
 /* 변수명을 위한 VARIABLE 토큰 */
[a-z] {
	yylval = *yytext - 'a';
	return VARIABLE;
}

[0-9]+ {
	yylval = atoi(yytext);
	return INTEGER;
}

[-+()=/*\n] {return *yytext;}

[ \t]	;

.	yyerror("invalid character");
%%

int yywrap(void)
{
	return 1;
}
