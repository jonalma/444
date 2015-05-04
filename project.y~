%{
#include "eg.h"

char **vars; /*hold variable names*/
double varVals[20]; /*hold values of corresponding variables*/
int c = 0;
int i = 0;
extern FILE *yyin;
char *tempVar;
double tempVal;
int ifbool=0;

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
   printf("%s %s %.0f\n",rel_op, var, op2);
 
   int index;
   /*Find index of variable in var array*/
   for(index = 0; index < sizeof(vars); index++) {
	printf("%.0f ",varVals[index]);
	if (strcmp(vars[index], var) == 0) {
        	break;
   	}
   }
   double op1 = varVals[index];
   printf("Variable %s VAL %.0f\n",vars[index],op1);
    
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



/*returns the double literal of variable, op1*/
double assignEval(char *ass_op, char *op1, double op2){	
    int index;
    /*printf("The temp var is %s\n",tempVar);
    printf("The temp val is %.0f\n",tempVal);*/
    unsigned int exists = 1;
    /*If variable already exists in the array, replace with new literal*/
    for(index = 0; index < sizeof(vars); index++) {
       if (strcmp(vars[index], op1) == 0) {
           varVals[index] = op2;
	   exists = 0;
	   printf("EXISTS: %.0f\n",varVals[index]);   
	   return varVals[index];
       }
    }/*end for*/

     if(exists == 1){
	 strcpy(vars[c], op1);
	 varVals[c] = op2;
	 /*printf("NEW VAR: %.0f, ARRAY SIZE: %d\n",varVals[c],c);*/
	 return varVals[c++];
     }
     
		
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
   printf("\n\n");
}

void printEval(char *str, char *var){
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
	sprintf(value,"%.0f\n",varVals[index]);
	tempVal = varVals[index];
	printf("%s\n",strcat(str,value));
}

/*Returns the literal depending on condition, boolVal*/
double ifEval(unsigned int boolVal, double literal)
{
printf("ifbool is %d\n",ifbool);
   /*Find index of variable in 'vars' array*/
   int index;
   for(index = 0; index < sizeof(vars); index++) {
       if (strcmp(vars[index], tempVar) == 0) {
           break;
       }
   }

   if(boolVal == 1){ /*if if_stmt evaluates to true*/ 	
	/*replace existing literal with new literal in varVals array*/
	varVals[index]=literal;
	/*printf("CONDITION IS TRUE: %.0f\n",varVals[index]);*/
	return varVals[index];	
   }/*end if*/
   else if (boolVal == 0){
	/*printf("CONDITION IS FALSE: %.0f\n",varVals[index]);*/
	return varVals[index];
   }
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
%token <theOperator> THEN
%token <theOperator> FI
%token <theOperator> VARIABLE
%token <theOperator> DSYMTAB		/*Symbol Table*/
%token LEFTPARA
%token RIGHTPARA
%token COMMA

%type <theOperator> symtab		
%type <theOperator> arith_op
%type <theOperator> bool_op
%type <theOperator> rel_op
%type <theReal> number
%type <theReal> num_expr
%type <theBoolean> bool_expr

%type <theOperator> vari
%type <theOperator> ass_op		/*Assignment Operator*/
%type <theOperator> prnt_expr		/*print expression*/
%type <theReal> ass_expr
%type <theReal> var_expr
%type <theReal> if_stmt
%type <theReal> then_stmt

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
vari: VARIABLE			{ strcpy($$, $1); }
symtab: DSYMTAB			{ strcpy($$, $1); }

prnt_expr : PRINT STRING COMMA vari	{printEval($2,$4);}
	  | PRINT STRING COMMA num_expr	{printf("%s%.0f ",$2,$4);}
	  | prnt_expr COMMA STRING COMMA num_expr    {printf("%s%.0f",$3,$5);}
	  | prnt_expr COMMA STRING COMMA bool_expr	{printf("%s%s",$3,getBoolWord($5));}

num_expr : number		{ $$ = $1; }
num_expr : num_expr arith_op num_expr  { $$ = numEval($2, $1, $3); }
num_expr : LEFTPARA num_expr RIGHTPARA    { $$ = $2; }

var_expr : vari arith_op vari		{$$ = varEval($2, $1, $3);}
var_expr : vari arith_op num_expr	{$$ = varNumEval($2,$1,$3);}
var_expr : num_expr arith_op vari	{$$ = varNumEval($2,$3,$1);}

ass_expr : vari ass_op num_expr		{ $$ = assignEval($2, $1, $3);} 
ass_expr : vari ass_op var_expr		{$$ = assignEval($2, $1, $3); }

bool_expr : num_expr rel_op num_expr   { $$ = relEval($2, $1, $3); }
bool_expr : vari rel_op num_expr	{ $$ = relVarEval($2, $1, $3); printf("Outside ifbool %d\n",$$);}
bool_expr : bool_expr bool_op bool_expr { $$ = boolEval($2, $1, $3); }
bool_expr : LEFTPARA bool_expr RIGHTPARA           { $$ = $2; }

if_stmt : IF bool_expr 			{$$ = $2; ifbool = $2; printf("Now ifbool %d\n",ifbool);}
then_stmt : THEN NLS vari ass_op num_expr NLS FI	{if(ifbool==1){ assignEval($4,$3,$5); } }


NLS:
	NLS NL
	| NL;
			
 
program : 
        | statement_list NLS
        ;

statement_list : 
               | statement_list statement
               ;
                  
statement : NLS
	  | num_expr NLS { printf("num Evaluates to: %.0f\n", $1); }
          | bool_expr NLS { printf("bool Evaluates to %s\n", getBoolWord($1)); }
	  | ass_expr NLS {  }
	  | var_expr NLS {  }
	  | prnt_expr NLS { }
	  | symtab NLS { printf("SYMBOL TABLE\n"); symbolTab();}
 	  | if_stmt NLS { /*printf("\nAfter if statement, unsigned bool is: %.0f\n",$1);*/ }
	  | then_stmt NLS { /*printf("\nAfter then statement, assignment val is: %.0f\n",$1); */}
          ;
%%

int main(int argc, char **argv)
{
   int i;
   vars = malloc(sizeof(char*)*20);
   for(i=0;i<20; i++) 
   	vars[i] = malloc(sizeof(char)*10);  /*10 letter words*/

   if(argc == 1)
	yyparse();

   if(argc == 2){
     yyin = fopen(argv[1],"r");
     yyparse();
   }

   return 0;
}
