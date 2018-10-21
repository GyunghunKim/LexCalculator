%{
#include <stdio.h>
#include "heat.tab.h"
%}
%%
[0-9]+	yylval = atoi(yytext); return NUMBER;
heat	return TOKHEAT;
on|off	return yylval = !strcmp(yytext, "on");	return STATE;
target	return TOKTARGET;
temperature	return TOKTEMPERATURE;
\n		;
[ \t]+	;
%%