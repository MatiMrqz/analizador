
%{
#include "sintactico.tab.h"
int CargarSubCadenas(char* NomToken);
extern char *Lexema[100], *Token[100];
extern int SubIndice, SubIndiceMax, NumLineas;
%}
separador ([ \t])+
literal "literal"
assignment_name "assignment_name"
linage_clause "linage_clause"
assign_clause_sublist ({separador}*{literal}|{separador}*{assignment_name})+
%%

{separador} {/*no hace nada*/}

"ASSIGN" { 
  CargarSubCadenas("ASSIGN");
  return (ASSIGN);}
"TO" { 
  CargarSubCadenas("TO");
  return (TO);}
"value_of" { 
  CargarSubCadenas("VALUE_OF_CLAUSE");
  return (VALUE_OF_CLAUSE);}
"data_records" { 
  CargarSubCadenas("DATA_RECORDS_CLAUSE");
  return (DATA_RECORDS_CLAUSE);}
{linage_clause} { 
  CargarSubCadenas("LINAGE_CLAUSE");
  return (LINAGE_CLAUSE);}
"recording_mode" { 
  CargarSubCadenas("RECORDING_MODE_CLAUSE");
  return (RECORDING_MODE_CLAUSE);}
{assign_clause_sublist} {
  CargarSubCadenas("ASSIGN_CLAUSE_SUBLIST");
  return (ASSIGN_CLAUSE_SUBLIST);}
\n  {
  SubIndiceMax = SubIndice;
  SubIndice=0;
  NumLineas++;
  return (NL);}
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