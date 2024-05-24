%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char* yytext;
extern FILE *yyin;
int yyerror(char *);
int yylex(void);
int DibujarTablaDeTokens();

int Dibujar=0, Recursion=0,MaxRecursion;
char *Lexema[100], *Token[100];
int SubIndice=0, SubIndiceMax, NumLineas=1, EstadoScanner=0;
%}

%token ASSIGN TO VALUE_OF_CLAUSE DATA_RECORDS_CLAUSE LINAGE_CLAUSE RECORDING_MODE_CLAUSE ASSIGN_CLAUSE_SUBLIST NL
%%
/* REGLAS DE PRODUCCION */

/*AXIOMA*/
FILE_AND_SORT : VALUE_OF_CLAUSE NL        { DibujarTablaDeTokens(); } 
               | VALUE_OF_CLAUSE error NL    { yyerrok; printf("Detalle del error: No se esperaba valor luego del token VALUE_OF_CLAUSE"); DibujarTablaDeTokens(); } 
               | DATA_RECORDS_CLAUSE NL    { DibujarTablaDeTokens(); }
               | DATA_RECORDS_CLAUSE error NL    { yyerrok; printf("Detalle del error: No se esperaba valor luego del token DATA_RECORDS_CLAUSE"); DibujarTablaDeTokens(); } 
               | LINAGE_CLAUSE NL         { DibujarTablaDeTokens(); }
               | LINAGE_CLAUSE error NL    { yyerrok; printf("Detalle del error: No se esperaba valor luego del token LINAGE_CLAUSE"); DibujarTablaDeTokens(); } 
               | RECORDING_MODE_CLAUSE NL { DibujarTablaDeTokens(); }
               | RECORDING_MODE_CLAUSE error NL    { yyerrok; printf("Detalle del error: No se esperaba valor luego del token RECORDING_MODE_CLAUSE"); DibujarTablaDeTokens(); } 
               | ASSIGN_CLAUSE NL        { DibujarTablaDeTokens(); }
               | ASSIGN_CLAUSE error NL    { yyerrok; printf("Detalle del error: Se detectó un error en la sentencia ASSIGN_CLAUSE"); DibujarTablaDeTokens(); } 
               | error NL {
                    yyerrok;
	               printf("Detalle del error: No se encontró un token válido\n");
               }
               ;

ASSIGN_CLAUSE :  ASSIGN ASSIGN_CLAUSE_SUBLIST
               | ASSIGN TO ASSIGN_CLAUSE_SUBLIST
               | ASSIGN TO error {
	               printf("Detalle del error: Se esperaba un token tipo ASSIGNMENT-NAME | LITERAL\n");
               }
               | ASSIGN error {
	               printf("Detalle del error: Se esperaba un token tipo TO | ASSIGNMENT-NAME | LITERAL\n");
               }
               ;

%%
/* La llamada a la rutina de error */
int yyerror (char *s) {
	printf("\nError en la linea %d\n",NumLineas);
     EstadoScanner = 2;
     return 1;
}
/* La llamada a la accion principal */
extern FILE *yyin;
int main(argc, argv)
int argc;
char **argv;
{
	FILE *ArchEnt;
	if (argc == 2)
	{
		ArchEnt=fopen(argv[1], "r");
		if (!ArchEnt) {
			fprintf(stderr, "No se encuentra el archivo %s\n", argv[1]);
			exit(1);
		}
		yyin=ArchEnt;
		EstadoScanner=1;
	}
	yyparse();
}
/* La llamada a la finalizacion del analizador */
int yywrap() {
     if(EstadoScanner<2){
          printf("\n**La cadena ingresada es válida** \n");
     }
	EstadoScanner=2;
	printf("El analisis ha concluido\n");
	return 1;
}
int DibujarTablaDeTokens(){
	int ContAuxT,ContAuxK;
	int LargoToken,LargoIzq,LargoDer;

	printf("\n\n===========================TABLA DE SIMBOLOS VALIDOS===========================\n");
	printf("|                LEXEMAS               |                 TOKENS               |\n");
	printf("---------------------------------------+---------------------------------------\n");

	for (ContAuxK=0;ContAuxK<SubIndiceMax;ContAuxK++){
		LargoToken=38-strlen(Lexema[ContAuxK]);
		if ((LargoToken & 1)==0){
			LargoIzq=LargoToken/2;
		}else{
			LargoIzq=(LargoToken+1)/2;
		}
		LargoDer=LargoToken-LargoIzq;
		printf("|");
		for (ContAuxT=0;ContAuxT<LargoIzq;ContAuxT++){
			printf(" ");
		}
		printf("%s",Lexema[ContAuxK]);
		for (ContAuxT=0;ContAuxT<LargoDer;ContAuxT++){
			printf(" ");
		}
		printf("|");
	
		LargoToken=38-strlen(Token[ContAuxK]);
		if ((LargoToken & 1)==0){
			LargoIzq=LargoToken/2;
		}else{
			LargoIzq=(LargoToken+1)/2;
		}
		LargoDer=LargoToken-LargoIzq;
		for (ContAuxT=0;ContAuxT<LargoIzq;ContAuxT++){
			printf(" ");
		}
		printf("%s",Token[ContAuxK]);
		for (ContAuxT=0;ContAuxT<LargoDer;ContAuxT++){
			printf(" ");
		}
		printf("|\n");
	}
	printf("===============================================================================\n\n");
	return 0;
}

