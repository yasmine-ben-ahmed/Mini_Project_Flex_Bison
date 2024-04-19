default:
	clear
	flex -l Anal_Lexical.l
	bison -dv Anal_Syntaxique.y 
	gcc -o interpreteur Anal_Syntaxique.tab.c lex.yy.c -lfl
