%{
/*
B711222	컴퓨터공학전공	박조은
Counting the number of letters with LEX
*/
#include<stdio.h>
int count_word = 0;
int count_equal = 0;
int count_Lbracket = 0;
int count_Rbracket = 0;
int count_mark = 0;
int count_number = 0;
%}

%%
[a-zA-Z]+	{count_word++;}
"="		{count_equal++;}
"{"		{count_Lbracket++;}
"}"		{count_Rbracket++;}
"."|"<"|">"|"`"|"~"|"!"|"@"|"#"|"$"|"%"|"^"|"&"|"*"|"("|")"|"-"|"_"|"="|"+"|"'"|";"|":"|","|"/"|"?"|"\\"|"\""	{count_mark++;}
[\n\t ]	;
[0-9]+		{count_number++;}
[0-9]+"."[0-9]+	{count_number++;}
%%

int main()
{
	yylex();
	printf("word = %d\n",count_word);
	printf("'=' = %d\n",count_equal);
	printf("'{' = %d\n",count_Lbracket);
	printf("'}' = %d\n",count_Rbracket);
	printf("mark = %d\n",count_mark);
	printf("number = %d\n",count_number);
	return 0;
}

int yywrap()
{
	return 1;
}
