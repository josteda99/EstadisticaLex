%{
    #include <math.h>
    #define IF 1 
    #define ELSE 2
    #define ID 3
    #define NUMBER 4
    #define FOR 5
    #define WHILE 6
    #define COM 7
    #define BCOM 8
    #define LT 9
    #define LE 10
    #define EQ 11
    #define NE 12
    #define GT 13
    #define GE 14
    #define PRINT 15
    #define LG 16
    #define RG 17
    #define LR 18
    #define RR 19
    #define AB 20
    #define OB 21
    #define ADD 22
    #define SUB 23
    #define MUL 24
    #define DIV 25
    #define POT 26
    #define FALSE 27
    #define TRUE 28
    #define LF 29
    #define RF 30
    #define ASIG 31
    #define RETURN 32
    #define RELOP 33
    #define GROUP 34
    #define ARRAY 35
    #define BINOP 36
    #define ARITOP 37
    #define FUNCTION 37
    int yylval;
    int pointer = 0; 
    int tableNum[50];
%}

/* regular definitions */
delim       [ \t\n]
ws          {delim}+
letter      [A-Za-z]
digit       [0-9]
id          {letter}({letter}|{digit})*
number      {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
slash       "/"
com         {slash}{slash}(ws|.)*\n
%%

{ws}        {/* no action and no return */} 
if          {return IF;}
else        {return ELSE;}
for         {return FOR;}
while       {return WHILE;}
print       {return PRINT;}
false       {return FALSE;}
true        {return TRUE;}
return      {return RETURN;}
"<"         {yylval = LT; return RELOP;} 
"<="        {yylval = LE; return RELOP;} 
"=="        {yylval = EQ; return RELOP;} 
"<>"        {yylval = NE; return RELOP;} 
">"         {yylval = GT; return RELOP;} 
">="        {yylval = GE; return RELOP;}
"("         {yylval = LG; return GROUP;}
")"         {yylval = RG; return GROUP;}
"["         {yylval = LR; return ARRAY;}
"]"         {yylval = RR; return ARRAY;}
"&"         {yylval = AB; return BINOP;}
"|"         {yylval = OB; return BINOP;}
"+"         {yylval = ADD; return ARITOP;}
"-"         {yylval = SUB; return ARITOP;}
"*"         {yylval = MUL; return ARITOP;}
"/"         {yylval = DIV; return ARITOP;}
"**"        {yylval = POT; return ARITOP;}
"{"         {yylval = LF; return FUNCTION;}
"}"         {yylval = RF; return FUNCTION;}
"="         {return ASIG;}
{com}       {return COM;}
{number}    {tableNum[pointer] = atoi(yytext); yylval = pointer++; return NUMBER;}
                                
"/*"        {register int c;
                for ( ; ; ) {
                    while ( (c = input()) != '*' && c != EOF );    /* eat up text of comment */
                    if ( c == '*' ) {
                        while ( (c = input()) == '*');
                        if ( c == '/' )
                            break;    /* found the end */
                    }
                    if ( c == EOF ) {
                        /*error( "EOF in comment" );*/
                        break;
                    }
                }; return BCOM;
            }
%%

int yywrap() {}

int installID() {
    /* function to install the lexeme, whose first character is pointed to by yytext, and whose length is yyleng, into the symbol table and return a pointer thereto */
}

int installNum() {
    tableNum[pointer] = atoi(yytext); yylval = pointer++;
}

int main(argc,argv)
int argc;
char *argv[];
{
    int val;
    while(val = yylex()){
        printf("value is %d -> lexeme %s, yylval: %d\n",val, yytext, yylval);
    }
}