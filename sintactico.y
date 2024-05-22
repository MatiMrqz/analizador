%{
#include <stdio.h>
extern char* yytext;
extern FILE *yyin;
int yyerror(char *msg);
int yylex(void);
%}

%token ASSIGN TO VALUE_OF_CLAUSE DATA_RECORDS_CLAUSE LINAGE_CLAUSE RECORDING_MODE_CLAUSE ASSIGNMENT_NAME LITERAL NL
%%

FILE_AND_SORT : VALUE_OF_CLAUSE         { printf("VALUE_OF_CLAUSE\nFILE_AND_SORT\n*** La cadena ingresada es valida. ***\n"); return 1; }
               | DATA_RECORDS_CLAUSE    { printf("DATA_RECORDS_CLAUSE\nFILE_AND_SORT\n*** La cadena ingresada es valida. ***\n"); return 1; }
               | LINAGE_CLAUSE          { printf("LINAGE_CLAUSE\nFILE_AND_SORT\n*** La cadena ingresada es valida. ***\n"); return 1; }
               | RECORDING_MODE_CLAUSE  { printf("RECORDING_MODE_CLAUSE\nFILE_AND_SORT\n*** La cadena ingresada es valida. ***\n"); return 1; }
               | ASSIGN_CLAUSE          { printf("ASSIGN_CLAUSE\nFILE_AND_SORT\n*** La cadena ingresada es valida. ***\n"); return 1; }
               |
               ;
ASSIGN_CLAUSE :  ASSIGN ASSIGN_SUBLIST            { printf("ASSIGN_SUBLIST\nASSIGN\n") ; }
               | ASSIGN TO ASSIGN_SUBLIST         { printf("ASSIGN_SUBLIST\nTO\nASSIGN\n") ; }
               ;

ASSIGN_SUBLIST: ASSIGNMENT_NAME                   { printf("ASSIGNMENT_NAME\n") ; }
               | LITERAL                          { printf("LITERAL\n") ; }
               | ASSIGNMENT_NAME ASSIGN_SUBLIST   { printf("ASSIGN_SUBLIST\nASSIGNMENT_NAME\n") ; }
               | LITERAL ASSIGN_SUBLIST           { printf("ASSIGN_SUBLIST\nLITERAL\n") ; }
               ;

%%
int yyerror(char *msg) {
     printf("*** La cadena ingresada es invalida: %s ***\n ", msg);
     return 1;
}
int main() {
     yyin = fopen("input.txt","rt");
     yyparse();
}

