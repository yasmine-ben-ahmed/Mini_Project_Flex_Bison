%option caseless
%option yylineno

pattren (\"[^"]+\")|('[^']+')
attribute (_?[a-z]+([a-z_]+)?)
datatype (int|smallint|tinyint|mediumint|bigint|decimal|float|double|real|date|datetime|timestamp|char|varchar)
erreur (\"[^"\n]+)|('[^'\n]+)|(_?[a-z]+([a-z_]+)?)(\"|')

%{
    #include "Anal_Syntaxique.tab.h"

    static int next_column = 1;
    int column = 1;

    #define HANDLE_COLUMN column = next_column; next_column += strlen(yytext)
%}

%%
(SELECT)         { HANDLE_COLUMN; yylval.string=yytext; return SELECT; }
(DELETE)         { HANDLE_COLUMN; yylval.string=yytext; return DELETE; }
(UPDATE)         { HANDLE_COLUMN; yylval.string=yytext; return UPDATE; }
(INSERT)         { HANDLE_COLUMN; yylval.string=yytext; return INSERT; }
(CREATE)         { HANDLE_COLUMN; yylval.string=yytext; return CREATE; }
(ALTER)          { HANDLE_COLUMN; yylval.string=yytext; return ALTER; }
(TABLE)          { HANDLE_COLUMN; yylval.string=yytext; return TABLE; }
(COLUMN)         { HANDLE_COLUMN; yylval.string=yytext; return COLUMN; }
(ADD)            { HANDLE_COLUMN; yylval.string=yytext; return ADD; }
(DROP)           { HANDLE_COLUMN; yylval.string=yytext; return DROP; }
(MODIFY)         { HANDLE_COLUMN; yylval.string=yytext; return MODIFY; }
(INTO)           { HANDLE_COLUMN; yylval.string=yytext; return INTO; }
(VALUES)         { HANDLE_COLUMN; yylval.string=yytext; return VALUES; }
(FROM)           { HANDLE_COLUMN; yylval.string=yytext; return FROM; }
(WHERE)          { HANDLE_COLUMN; yylval.string=yytext; return WHERE; }
(SET)            { HANDLE_COLUMN; yylval.string=yytext; return SET; }
(AND)            { HANDLE_COLUMN; yylval.string=yytext; return AND; }
(LIKE)           { HANDLE_COLUMN; yylval.string=yytext; return LIKE; }
(IN)             { HANDLE_COLUMN; yylval.string=yytext; return IN; }
[0-9]+           { HANDLE_COLUMN; yylval.string=yytext; return number; }
{datatype}       { HANDLE_COLUMN; yylval.string=yytext; return DATATYPE; }
{attribute}      { HANDLE_COLUMN; yylval.string=yytext; return attribute; }
{pattren}        { HANDLE_COLUMN; yylval.string=yytext; return pattren; }
,                { HANDLE_COLUMN; yylval.string=yytext; return comma; }
;                { HANDLE_COLUMN; yylval.string=yytext; return semicolon;}
\.               { HANDLE_COLUMN; yylval.string=yytext; return dot; }
\(               { HANDLE_COLUMN; yylval.string=yytext; return open_parenthesis; }
\)               { HANDLE_COLUMN; yylval.string=yytext; return close_parenthesis; }
\*               { HANDLE_COLUMN; yylval.string=yytext; return all_columns; }
=                { HANDLE_COLUMN; yylval.string=yytext; return equals_sign; }
\n               { HANDLE_COLUMN; return END; }
[ \t]            { HANDLE_COLUMN; }
{erreur}         { HANDLE_COLUMN; return incompleted_pattren; }
%%

int yywrap(){ return 1; }
