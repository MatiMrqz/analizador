
%option noinput nounput noyywrap nodefault
%{
#include "sintactico.tab.h"
%}

%%
"ASSIGN"          {return ASSIGN;}
"TO"              {return TO;}
"value_of"        {return VALUE_OF_CLAUSE;}
"data_records"    {return DATA_RECORDS_CLAUSE;}
"linage_clause"   {return LINAGE_CLAUSE;}
"recording_mode"  {return RECORDING_MODE_CLAUSE;}
"assignment_name" {return ASSIGNMENT_NAME;}
"literal"         {return LITERAL;}

\n  {return (NL);}
[[:space:]]+    ;/*Do nothing on spaces*/
.   {return yytext[0];}
%%
