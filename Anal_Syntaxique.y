%{
#include <string.h>
#include <stdio.h>

int yylex();

extern int yylineno;
extern int column;

int fieldsCount        = 0;
int allFields          = 0;
int tablesCount        = 0;
int updatedFields      = 0;
int insertToFields     = 0;
int createdFields      = 0;
int insertValuesFields = 0;

char* queryType;
char *operationType;

void afficherStats(){
    if((insertToFields != insertValuesFields) && (queryType == "INSERT")){
        printf("\033[0;31mErreur Semantique! le nombre des valeurs a inserer est superieur a celle de columns\033[0m\n");
        return;
    }

    printf("\033[032m***___Requete Valide___***\033[0m\n");
    printf("\033[032m***____________________***\033[0m\n");
    printf("C'est une requete de type: %s\n", queryType);
    if(queryType == "SELECT"){
        if(allFields == 1){
            printf("Tous les champs seront selectionner\n");
        } else {
            printf("Nombre de champs a selectionner est: %d\n", fieldsCount);
        }
        
        printf("A partir de %d table(s)\n", tablesCount);
    }

    if(queryType == "UPDATE"){
        if(allFields == 1){
            printf("%d column(s) ser(a|ont) mis a jour dans tous les lignes.\n", updatedFields);
        } else {
            printf("%d column(s) ser(a|ont) mis a jour.\n", updatedFields);
        }
    }

    if(queryType == "INSERT"){
        printf("%d valeur(s) ser(a|ont) inserer.\n", insertToFields);
    }

    if(queryType == "ALTER"){
        printf("Cette une operation de %s.\n", operationType);
    }

    if(queryType == "CREATE"){
        printf("Une table avec %d column(s) sera créer.\n", createdFields);
    }

    printf("\033[032m____********************___\033[0m\n");
}

%}

%define parse.error verbose

%union {
    char* string;
    int number;
}

%token END
%token<string> SELECT
%token<string> DELETE
%token<string> UPDATE
%token<string> INSERT
%token<string> CREATE
%token<string> ALTER
%token<string> INTO
%token<string> VALUES
%token<string> FROM
%token<string> WHERE
%token<string> AND
%token<string> LIKE
%token<string> SET
%token<string> IN
%token<string> TABLE
%token<string> COLUMN
%token<string> ADD
%token<string> DROP
%token<string> MODIFY
%token<string> DATATYPE
%token<number> number
%token<string> pattren
%token<string> attribute
%token<string> comma
%token<string> semicolon
%token<string> dot
%token<string> equals_sign
%token<string> open_parenthesis
%token<string> close_parenthesis
%token<string> all_columns
%token<string> incompleted_pattren
%type <string> queries

%%
input:
|   line input
;

line: 
    queries semicolon END { afficherStats(); return 0; }
|   END
;

queries:
    SELECT columns FROM tables { queryType="SELECT"; }
|   SELECT columns FROM tables WHERE condition { queryType="SELECT"; }

|   DELETE FROM attribute { queryType="DELETE"; }
|   DELETE FROM attribute WHERE condition { queryType="DELETE"; }

|   UPDATE attribute SET column_value_list { queryType="UPDATE"; allFields = 1; }
|   UPDATE attribute SET column_value_list WHERE condition { queryType="UPDATE"; }

|   INSERT INTO attribute VALUES insert_values { queryType = "INSERT"; }
|   INSERT INTO attribute insert_columns VALUES insert_values { queryType = "INSERT"; }

|   CREATE TABLE attribute open_parenthesis create_list close_parenthesis { queryType = "CREATE"; }

|   ALTER TABLE attribute alter_option { queryType = "ALTER"; }
;

columns:
    all_columns { allFields = 1; }
|   attribute { fieldsCount++;}
|   attribute comma columns { fieldsCount++;}
;

tables:
    attribute { tablesCount++; }
|   attribute comma tables { tablesCount++; }
;

condition:
    condition AND condition
|   attribute IN open_parenthesis queries close_parenthesis
|   attribute IN open_parenthesis pattren_list close_parenthesis
|   equals_list equals_sign equals_list
|   attribute LIKE pattren
;

equals_list:
    attribute
|   number
|   pattren
|   attribute dot attribute
;

pattren_list:
    pattren
|   pattren comma pattren_list
;

column_value_list:
    attribute equals_sign pattren { updatedFields++; }
|   attribute equals_sign pattren comma column_value_list { updatedFields++; } 
|   attribute equals_sign number { updatedFields++; }
|   attribute equals_sign number comma column_value_list { updatedFields++; }
;

insert_columns:
    open_parenthesis insert_columns_list close_parenthesis
;

insert_values:
    open_parenthesis insert_values_list close_parenthesis
;

insert_columns_list:
    attribute { insertToFields++; }
|   attribute comma insert_columns_list { insertToFields++; }
;

insert_values_list:
    pattren { insertValuesFields++; }
|   number { insertValuesFields++; }
|   pattren comma insert_values_list { insertValuesFields++; }
|   number comma insert_values_list { insertValuesFields++; }
;

create_list:
    attribute DATATYPE { createdFields++; }
|   attribute DATATYPE comma create_list { createdFields++; }
;

alter_option:
    ADD attribute DATATYPE { operationType = "Ajout"; }
|   DROP COLUMN attribute { operationType = "Suppression"; }
|   MODIFY COLUMN attribute DATATYPE { operationType = "Modification"; }
;

%%

int yyerror(char *s)
{
    printf("\033[0;31m");
    for(int i = 0; i < column - 1; i++)
        printf("_");

    printf("^\n");
    printf("%s in line %d, column %d\n\033[0m", s, yylineno, column);

    return (0);
}

int main(){
    yyparse();
    return 0;
}
