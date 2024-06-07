
%{
#include "sintactico.tab.h"
int CargarSubCadenas(char* NomToken);
extern char *Lexema[100], *Token[100];
extern int SubIndice, SubIndiceMax, NumLineas;
%}
space ([ \t])+
eq "="
b_var "block_var"
wrapped_bvar "|"{space}*{b_var}?{space}*"|"
c_stmt "compstmt"
lhs "lhs"
c_args "call_args"
op "operation"
cmd ({op}{space}*{c_args}|"super"{space}*{c_args})
%%

{space} {/*no hace nada*/}

"do" {
  CargarSubCadenas("do");
  return (DO);
}
"end" {
  CargarSubCadenas("end");
  return (END);
}
{lhs} {
  CargarSubCadenas("LHS");
  return (LHS);
}
{eq} {
  CargarSubCadenas("=");
  return (EQ);
}
{cmd} {
  CargarSubCadenas("COMMAND");
  return (COMMAND);
}
{wrapped_bvar} {
  CargarSubCadenas("|[BLOCK_VAR]|");
  return (BLOCK_VAR);
}
{c_stmt} {
  CargarSubCadenas("COMPSTMT");
  return (C_STMT);
}

\n  {
  SubIndiceMax = SubIndice;
  SubIndice=0;
  NumLineas++;
  return(NL);
  }
.   {
  return yytext[0];
  }
%%
int CargarSubCadenas(char* NomToken){
	Lexema[SubIndice]=(char*)malloc((strlen(yytext)+1)*sizeof(char));
	strcpy(Lexema[SubIndice],yytext);
	Token[SubIndice]=(char*)malloc((strlen(NomToken)+1)*sizeof(char));
	strcpy(Token[SubIndice],NomToken);
	SubIndice++;
	return 0;
}