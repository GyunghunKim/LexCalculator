/* 
 * LEX는 패턴매칭 규칙을 나타낸다.
 *
 */

 /* %{와 %}사이에는 C 코드가 포함되며 항상 수행되어야 하는 코드들이 들어간다.  */
%{
 /* Calc.tab.h에는 Bison이 각 Token에 대해 어떤 일을 수행해야 하는지 들어간다. */
#include "Calc.tab.h" 
#include <math.h>
extern double vbltable[26];
%}

 /* 
  * 아래 부분은 매칭 정보를 나타내는 본문이다. 
  * 각 조건은 정규 표현식을 이용해 표현되고 있다. 
  * 
  * flex에 미리 정의된 변수들은 아래와 같다.
  * int yylex(void) : lexer를 호출하고 토큰을 리턴한다.
  * char *yytext : 매칭된 문자열의 포인터
  * yyleng : 매칭된 문자열의 길이
  * yylval : 토큰에 대한 정보 값
  * int yywrap(void) : 파일의 끝과 관련된 함수 (검색 필요)
  * FILE *yyout, FILE *yyin : 출력, 입력 파일
  * INITAL : 초기 시작 조건
  * BEGIN : condition switch start condition
  * ECHO : 매칭된 문자열 쓰기
  */ 
%%
([0-9]+|([0-9]*\.[0-9]+)?) {
yylval.val = atof(yytext); return NUMBER;
}
[ \t]+ ;	/* 공백과 tab을 무시한다. */
[a-z] {yylval.idno=yytext[0]-'a'; return NAME;}
"$" { return 0; }
\n |
. return yytext[0];
%%
