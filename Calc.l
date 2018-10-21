%{
#include "Calc.tab.h"
#include <math.h>
extern double vbltable[26];
%}
%%
([0-9]+|([0-9]*\.[0-9]+)?) {
yylval.val = atof(yytext); return NUMBER;
}
[\t] ;
[a-z] {yylval.idno=yytext[0]-'a'; return NAME;}
"$" { return 0; }
\n |
. return yytext[0];
%%
