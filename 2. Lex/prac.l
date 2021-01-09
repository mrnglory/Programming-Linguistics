%{
	unsigned int count=0;
%}

%%
[\t]+	;
love|Love|LOVE	{count++;}
.|\n	;
%%

main()
{
	yylex();
	printf("number of love=%d\n",count);
}

int yywrap()
{
	return 1;
}
