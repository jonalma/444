/*Team members: Jon Almazan*/
%{
#include <stdlib.h> 	/* qsort */
#include <string.h>
#include <stdio.h>

#include "eg.h"
#include "project.tab.h"
%}

%%


[0-9]+\.[0-9]+|\.[0-9]+  {	
				yylval.theReal = atof(yytext);
                         	return(REAL);
			}
[0-9]+          	{  
				yylval.theInt = atoi(yytext); 
                 		return(INTEGER);
			}

\'[a-zA-Z]\'       { 
			strcpy(yylval.theOperator, yytext);	
			return(CHARACTER);
		}

\"[^\"]*\" 	     { 
			strcpy(yylval.theOperator, yytext);	
			return(STRING);
		     }

(if|IF) 	{
			strcpy(yylval.theOperator, yytext);	
			return(IF) ;
		}

(then|THEN)$	 {
			strcpy(yylval.theOperator, yytext);	
			return(THEN);
		}

(fi|FI)$ 	{
			strcpy(yylval.theOperator, yytext);	
			return(FI) ;
		}

^(print|PRINT)	{
			strcpy(yylval.theOperator, yytext);	
			return(PRINT) ;
		}

^(dsymtab|DSYMTAB)	{
			strcpy(yylval.theOperator, yytext);	
			return(DSYMTAB) ;
		}


":="		      {
			 strcpy(yylval.theOperator, yytext);
		      	 return(ASSIGNMENT);
		      }

"+"		      {  strcpy(yylval.theOperator, yytext);
                         return(ADD); 
                      }

"-"		      {  strcpy(yylval.theOperator, yytext);
                         return(SUBTRACT); 
                      }
"*"		      {  strcpy(yylval.theOperator, yytext);
                         return(MULTIPLY); 
                      }
"/"		      {  strcpy(yylval.theOperator, yytext);
                         return(DIVIDE); 
                      }
"<"		      {  strcpy(yylval.theOperator, yytext);
                         return(LT); 
                      }
"<="		      {  strcpy(yylval.theOperator, yytext);
                         return(LTE); 
                      }
">"		      {  strcpy(yylval.theOperator, yytext);
                         return(GT); 
                      }
">="		      {  strcpy(yylval.theOperator, yytext);
                         return(GTE); 
                      }
"=="                  {  strcpy(yylval.theOperator, yytext);
                         return(EQ); 
                      }
"!="                  {  strcpy(yylval.theOperator, yytext);
                         return(NEQ); 
                      }
"&&"		      {  strcpy(yylval.theOperator, yytext);
                         return(AND); 
                      }
"||"		      {  strcpy(yylval.theOperator, yytext);
                         return(OR); 
                      }

[ \t]+                { ; }
[\r\n]		      { return NL; }

[a-zA-Z]+[0-9]*		{ 
			strcpy(yylval.theOperator, yytext);
			return VARIABLE;
			}

.				

%%

