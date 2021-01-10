%{
#include <stdio.h>
int yylex();
int func_count = 0;
int exp_count = 0;
int int_count = 0;
int char_count = 0;
int pointer_count = 0;
int array_count = 0;
int select_count = 0;
int loop_count = 0;
int return_count = 0;
int num = 0;
int check_int = 0;
int check_char = 0;
int check_pointer = 0;
int check_array = 0;
%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN AND_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start start_state
%%

primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')' {func_count++;}
	| postfix_expression '(' argument_expression_list ')' {func_count++;}
	| postfix_expression '.' IDENTIFIER
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP {exp_count++;}
	| postfix_expression DEC_OP {exp_count++;}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression {exp_count++;}
	| DEC_OP unary_expression {exp_count++;}
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression {exp_count++;}
	| multiplicative_expression '/' cast_expression {exp_count++;}
	| multiplicative_expression '%' cast_expression {exp_count++;}
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression {exp_count++;}
	| additive_expression '-' multiplicative_expression {exp_count++;}
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression {exp_count++;}
	| shift_expression RIGHT_OP additive_expression {exp_count++;}
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression {exp_count++;}
	| relational_expression '>' shift_expression {exp_count++;}
	| relational_expression LE_OP shift_expression {exp_count++;}
	| relational_expression GE_OP shift_expression {exp_count++;}
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression {exp_count++;}
	| equality_exprsesion NE_OP relational_expression {exp_count++;}
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression {exp_count++;}
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression {exp_count++;}
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression {exp_count++;}
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression {exp_count++;}
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expresion {exp_count++;}
	;

conditional_expression
	: logical_or_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression {exp_count++;}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	{
		if (check_int == 1)
			int count += num;
		if (check_char == 1)
			char_count += num;
		if (check_pointer == 1)
			pointer_count += num;
		if (check_array == 1)
			array_count += num;
		if (check_pointer == 1)
			pointer_count += num;
		check_array = 0;
		check_int = 0;
		check_char = 0;
		check_pointer = 0;
		num = 0;
	}
	;

declarative_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	;

init_declaration_list
	: init_declarator {num++;}
	| init_declarator_list ',' init_declarator {num++;}
	;

init_declarator
	: declarator
	| declarator '=' initializer {exp_count++;}
	;

storage_class_specifier
	: TYPEDEF
	| EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID {check_int = 0; check_char = 0;}
	| CHAR {check_int = 0; check_char = 1;}
	| SHORT {check_int = 0; check_char = 0;}
	| INT {check_int = 1; check_char = 0;}
	| LONG {check_int = 0; check_char = 0;}
	| FLOAT {check_int = 0; check_char = 0;}
	| DOUBLE {check_int = 0; check_char = 0;}
	| SIGNED
	| UNSIGNED
	| struct_or_union_specifier
	| enum_specifier
	| TYPE_NAME
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
	| struct_or_union '{' struct_declaration_list '}'
	| struct_or_union IDENTIFIER
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| ':' constant_expression
	| declarator ':' constant_expression
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM IDENTIFIER
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression {exp_count++;}
	;

type_qualifier
	: CONST
	| VOLATILE
	;

declarator
	: pointer direct_declarator {pointer_count++;}
	| direct_declarator
	;





parameter_declaration
	: declaration_specifiers declarator
	{
		if (check_int == 1)
			int_count++;
		check_int = 0;
		if (check_char == 1)
			char_count++;
		check_char = 0;
	}
	| declaration_specifiers abstract_declarator
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;