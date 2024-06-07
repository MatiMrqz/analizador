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
int SubIndice=0, SubIndiceMax, NumLineas=1, EstadoScanner=0,x;
%}

%token DO END LHS EQ COMMAND BLOCK_VAR C_STMT NL
%%
/* REGLAS DE PRODUCCION */

/*AXIOMA*/
STMT : LHS EQ COMMAND DO BLOCK_VAR C_STMT END NL        { DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND DO C_STMT END NL  { DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND NL  { DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND DO BLOCK_VAR C_STMT error NL    { yyerrok; printf("Detalle del error: Se esperaba el terminal 'end'"); DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND DO C_STMT error NL    { yyerrok; printf("Detalle del error: Se esperaba el terminal 'end'"); DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND DO BLOCK_VAR error NL    { yyerrok; printf("Detalle del error: Se esperaba un token del tipo COMPSTMT"); DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND DO error NL    { yyerrok; printf("Detalle del error: Se esperaba un token del tipo COMPSTMT"); DibujarTablaDeTokens(); } 
			| LHS EQ COMMAND error NL    { yyerrok; printf("Detalle del error: Se esperaba un terminal 'do'"); DibujarTablaDeTokens(); } 
			| LHS EQ error NL    { yyerrok; printf("Detalle del error: Se esperaba un token del tipo COMMAND"); DibujarTablaDeTokens(); } 
			| LHS error NL    { yyerrok; printf("Detalle del error: Token inválido. Quizas debió colocar '='"); DibujarTablaDeTokens(); } 
			| error NL {
					yyerrok;
				printf("Detalle del error: No se encontró un token válido\n");
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
int main(int argc,char **argv){
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
          printf("\n**La cadena ingresada es valida** \n");
     }
	EstadoScanner=2;
	printf("El analisis ha concluido\nIngrese 0 para salir");
	scanf("%d",&x);
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

