%%
[\t]+	;
rain|rose	{printf("%s!! That is my favorite.\n",yytext);}
love|story	{printf("%s!! I like a love story. ^_~\n",yytext);}
"potato chip"|potato|chip	{printf("%s.....!! now and then, I have a potato chip.\n",yytext);}
[A-Za-z]+	{printf("%s....What is that?\n",yytext);}
.|\n ;
%%

int yywrap()	{return 1;}
int main()	{yylex();}
