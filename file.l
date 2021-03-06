%{

#include <stdio.h>
#include <string.h>
#include "sinsem.tab.h"
void showError();
%}


numbers     ([0-9])+
alpha       ([a-zA-Z])+

%%

{alpha}			   {sscanf(yytext, "%s", yylval.name); return (STRING);}
{numbers}      {yylval.number = atoi(yytext); return (NUM);}
";"      		   {return (SEMICOLON);}
.      		     {showError(); return(OTHER);}

%%
void showError(){
    printf("Other input");
}