%{
#include "eg.h"

char **vars; /*hold variable names*/
double varVals[20]; /*hold values of corresponding variables*/
int c = 0;
int i = 0;

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

char* getBoolWord(unsigned int value)
{
	return (value == 1) ? "true" : "false";
}

double numEval(char* operator, double operand1, double operand2)
{
   if(strcmp(operator, "+") == 0) return operand1 + operand2;
   else if(strcmp(operator, "-") == 0) return operand1 - operand2;
   else if(strcmp(operator, "*") == 0) return operand1 * operand2;
   else if(strcmp(operator, "/") == 0)
   {
      if(operand2 == 0.0)
      {
         printf("\nError: Divide by zero: %g/%g\n", operand1, operand2);
         return 0.0;
      }
      else
      {
         return operand1 / operand2;
      }
   }
   else
   {
         printf("\nError: Unknown operator: %s\n", operator);
         return 0.0;
   }
}

unsigned int relEval(char *rel_op, double op1, double op2)
{
   if(strcmp(rel_op, "<") == 0) return (op1 < op2 ? 1 : 0);
   else if(strcmp(rel_op, "<=") == 0) return (op1 <= op2 ? 1 : 0);
   else if(strcmp(rel_op, ">") == 0) return (op1 > op2 ? 1 : 0);
   else if(strcmp(rel_op, ">=") == 0) return (op1 >= op2 ? 1 : 0);
   else if(strcmp(rel_op, "==") == 0) return (op1 == op2 ? 1 : 0);
   else if(strcmp(rel_op, "!=") == 0) return (op1 != op2 ? 1 : 0);
   else
   {
      printf("ERROR: Unknown relational operator: %s\n", rel_op);
      return 0;
   }
}

/*When a variable is compared to a numeric operand*/
unsigned int relVarEval(char *rel_op, char* var, double op2)
{    
   int index;
   /*Find index of variable in var array*/
   for(index = 0; index < sizeof(vars); index++) {
	if (strcmp(vars[index], var) == 0) {
        	break;
   	}
   }
   double op1 = varVals[index];

   if(strcmp(rel_op, "<") == 0) return (op1 < op2 ? 1 : 0);
   else if(strcmp(rel_op, "<=") == 0) return (op1 <= op2 ? 1 : 0);
   else if(strcmp(rel_op, ">") == 0) return (op1 > op2 ? 1 : 0);
   else if(strcmp(rel_op, ">=") == 0) return (op1 >= op2 ? 1 : 0);
   else if(strcmp(rel_op, "==") == 0) return (op1 == op2 ? 1 : 0);
   else if(strcmp(rel_op, "!=") == 0) return (op1 != op2 ? 1 : 0);
   else
   {
      printf("ERROR: Unknown relational operator: %s\n", rel_op);
      return 0;
   }
}
   
unsigned int boolEval(char *bool_op, unsigned int op1, unsigned int op2)
{
   if(strcmp(bool_op, "&&") == 0) return op1 && op2;
   if(strcmp(bool_op, "||") == 0) return op1 || op2;
   else
   {
      printf("ERROR: Unknown boolean operator: %s\n", bool_op);
      return 0;
   }
}

double assignEval(char *ass_op, char *op1, double op2){	
     if(strcmp(ass_op, ":=") == 0){
	 strcpy(vars[c], op1);
	 varVals[c] = op2;
	 c++;
     }
     return op2;
		
}

/*Does arithmetic eval if both variables exist*/
double varEval(char *operator, char *op1, char *op2){	
     int i;
     double operand1;
     double operand2;
     for(i = 0; i<c; i++){
     	if(strcmp(op1, vars[i]) == 0){
	 	operand1 = varVals[i];
     	}
	if(strcmp(op2, vars[i]) == 0){
		operand2 = varVals[i];
	}
     }
     
     return numEval(operator,operand1,operand2);	
}

/*Does arithmetic eval with one num and one variable*/
double varNumEval(char *operator, char *op1, double op2){	
     int i;
     double operand1;
     double operand2;
     for(i = 0; i<c; i++){
     	if(strcmp(op1, vars[i]) == 0){
	 	operand1 = varVals[i];
     	}
     }
     operand2 = op2;
     return numEval(operator,operand1,operand2);	
}

void symbolTab(){
   for(i=0;i<c; i++){
       printf("Variable name: %s, Value: %g\n", vars[i], varVals[i]);	
   }
}

char* printEval(char *str, char *var){
	char* value; int index;
	/*Find index of variable in var array*/
	for(index = 0; index < sizeof(vars); index++) {
    	  if (strcmp(vars[index], var) == 0) {
        	break;
   	  }
	}
	
	/*use index to find value of variable*/
	value = (char*) &varVals[index];
	/*Concatenate the string and int value*/	
	sprintf(value,"%f",varVals[index]);
	return strcat(str,value);
}


%}

%union
{
	int  theInt;
        double theReal;
	char theOperator[MAX_STRING_LEN + 1];
	unsigned int theBoolean;
}

%token NL
%token <theOperator> LT
%token <theOperator> LTE
%token <theOperator> GT
%token <theOperator> GTE
%token <theOperator> EQ
%token <theOperator> NEQ
%token <theOperator> ADD
%token <theOperator> SUBTRACT
%token <theOperator> MULTIPLY
%token <theOperator> DIVIDE
%token <theOperator> AND
%token <theOperator> OR
%token <theInt> INTEGER
%token <theReal> REAL
%token <theOperator> PRINT
%token <theOperator> ASSIGNMENT
%token <theOperator> CHARACTER
%token <theOperator> STRING
%token <theOperator> IF
%token <theOperator> FI
%token <theOperator> THEN
%token <theOperator> VARIABLE
%token <theOperator> DSYMTAB		/*Symbol Table*/

%type <theOperator> symtab		
%type <theOperator> arith_op
%type <theOperator> bool_op
%type <theOperator> rel_op
%type <theReal> number
%type <theReal> num_expr
%type <theBoolean> bool_expr

%type <theOperator> str			/*String*/
%type <theOperator> str_expr		/*String expression*/
%type <theOperator> vari
%type <theOperator> ass_op		/*Assignment Operator*/
%type <theOperator> prnt		/*PRINT*/
%type <theOperator> prnt_expr		/*print expression*/
%type <theReal> ass_expr
%type <theReal> var_expr
%type <theBoolean> if_stmt
%type <theBoolean> then_stmt

%left AND OR
%left LT LTE GT GTE EQ NEQ
%left '+' '-'
%left '*' '/'

%start program

%%

arith_op : ADD | SUBTRACT | MULTIPLY | DIVIDE  { strcpy($$, $1); }
rel_op : LT | LTE | GT | GTE | EQ | NEQ        { strcpy($$, $1); }
bool_op : AND | OR                             { strcpy($$, $1); }
ass_op : ASSIGNMENT			       { strcpy($$, $1); }
number : INTEGER    		{ $$ = $1; }
number : REAL			{ $$ = $1; }
str: STRING			{ strcpy($$, $1); }
vari: VARIABLE			{ strcpy($$, $1); }
prnt: PRINT			{ strcpy($$, $1); }
symtab: DSYMTAB			{ strcpy($$, $1); }
if : IF
then : THEN
fi : FI

ass_expr : vari ass_op num_expr		{$$ = assignEval($2, $1, $3); }
str_expr : str				{ strcpy($$, $1); }

prnt_expr : prnt str_expr  		{strcpy($$,$2);}
prnt_expr : prnt_expr ',' 		{strcpy($$,$1);}
prnt_expr : prnt_expr vari 		{strcpy($$,printEval($1,$2));}

num_expr : number		{ $$ = $1; }
num_expr : num_expr arith_op num_expr  { $$ = numEval($2, $1, $3); }
num_expr : '(' num_expr ')'    { $$ = $2; }

var_expr : vari arith_op vari		{$$ = varEval($2, $1, $3);}
var_expr : vari arith_op num_expr	{$$ = varNumEval($2,$1,$3);}
var_expr : num_expr arith_op vari	{$$ = varNumEval($2,$3,$1);}

bool_expr : num_expr rel_op num_expr  { $$ = relEval($2, $1, $3); }
bool_expr : vari rel_op num_expr	{ $$ = relVarEval($2, $1, $3); }
bool_expr : bool_expr bool_op bool_expr { $$ = boolEval($2, $1, $3); }
bool_expr : '(' bool_expr ')'           { $$ = $2; }

if_stmt: if '(' bool_expr ')'			{$$ = $3;} 			

program : 
        | statement_list NL
        ;

statement_list : 
               | statement_list statement
               ;
                  
statement : num_expr NL { printf("Evaluates to: %f\n", $1); }
          | bool_expr NL { printf("Evaluates to %s\n", getBoolWord($1)); }
	  | ass_expr NL {  }
	  | var_expr NL {  }
	  | str_expr NL {  }
	  | prnt_expr NL { printf("%s\n", $1); }
	  | symtab NL { printf("SYMBOL TABLE\n"); symbolTab(); }
 	  | if_stmt NL { printf("Evaluates to %s\n", getBoolWord($1)); }
	 
          ;
%%

int main(int argc, char **argv)
{
   int i;
   vars = malloc(sizeof(char*)*20);
   for(i=0;i<20; i++) 
   	vars[i] = malloc(sizeof(char)*10);  /*10 letter words*/

   yyparse();

   return 0;
}
