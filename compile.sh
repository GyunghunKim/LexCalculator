#! /bin/bash

read input

flex ${input}.l
bison -d ${input}.y
gcc -o ${input} ${input}.tab.c lex.yy.c -lfl
