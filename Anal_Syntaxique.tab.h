/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ANAL_SYNTAXIQUE_TAB_H_INCLUDED
# define YY_YY_ANAL_SYNTAXIQUE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    END = 258,                     /* END  */
    SELECT = 259,                  /* SELECT  */
    DELETE = 260,                  /* DELETE  */
    UPDATE = 261,                  /* UPDATE  */
    INSERT = 262,                  /* INSERT  */
    CREATE = 263,                  /* CREATE  */
    ALTER = 264,                   /* ALTER  */
    INTO = 265,                    /* INTO  */
    VALUES = 266,                  /* VALUES  */
    FROM = 267,                    /* FROM  */
    WHERE = 268,                   /* WHERE  */
    AND = 269,                     /* AND  */
    LIKE = 270,                    /* LIKE  */
    SET = 271,                     /* SET  */
    IN = 272,                      /* IN  */
    TABLE = 273,                   /* TABLE  */
    COLUMN = 274,                  /* COLUMN  */
    ADD = 275,                     /* ADD  */
    DROP = 276,                    /* DROP  */
    MODIFY = 277,                  /* MODIFY  */
    DATATYPE = 278,                /* DATATYPE  */
    number = 279,                  /* number  */
    pattren = 280,                 /* pattren  */
    attribute = 281,               /* attribute  */
    comma = 282,                   /* comma  */
    semicolon = 283,               /* semicolon  */
    dot = 284,                     /* dot  */
    equals_sign = 285,             /* equals_sign  */
    open_parenthesis = 286,        /* open_parenthesis  */
    close_parenthesis = 287,       /* close_parenthesis  */
    all_columns = 288,             /* all_columns  */
    incompleted_pattren = 289      /* incompleted_pattren  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 66 "Anal_Syntaxique.y"

    char* string;
    int number;

#line 103 "Anal_Syntaxique.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ANAL_SYNTAXIQUE_TAB_H_INCLUDED  */
