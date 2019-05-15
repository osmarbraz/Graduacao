(*************************************************************************)
(* OSMAR DE OLIVEIRA BRAZ JUNIOR - 8579  TUBARAO - UNISUL - SC  29/11/93 *)
(*************************************************************************)
(*                                                                       *)
(*   ESTE PROGRAMA DETERMINA PARA UMA INDUSTRIA QUE PRODUZ N ARTIGOS     *)
(*   DIFERENTES DURANTE A SEMANA OS SEGUINTES ITENS:                     *)
(*   - PARA A TERCA-FEIRA QUAL O ARTIGO MAIS PRODUZIDO                   *)
(*   - QUAL O DIA DA SEMANA O ARTIGO 1 FOI O MAIS PRODUZIDO              *)
(*   - QUAL O ARTIGO MAIS PRODUZIDO NA SEMANA                            *)
(*                                                                       *)
(*  VARIAVEIS DE ENTRADA :                                               *)
(*  N               -  NUMERO DE ARTIGOS                                 *)
(*  PRODUCAO[X,Y]   -  MATRIZ QUE ARMAZENA A PRODUCAO DE CADA ARTIGO     *)
(*                     EM CADA DIA DA SEMANA                             *)
(*                                                                       *)
(*  VARIAVEIS DE SAIDA :                                                 *)
(*  ARTIGO_3   - NUMERO DO ARTIGO MAIS PRODUZIDO NA TERCA-FEIRA          *)
(*  SEMANA     - O DIA DA SEMANA QUE O ARTIGO 1 FOI O MAIS PRODUZIDO     *)
(*  ARTIGO     - O ARTIGO MAIS PRODUZIDO NA SEMANA                       *)
(*                                                                       *)
(*  VARIAVEIS DE PROCESSAMENTO :                                         *)
(*  MAIOR           - MAIOR PRODUCAO PARA TERCA-FEIRA                    *)
(*  MAIOR_1         - MAIOR PRODUCAO DO ARTIGO 1 NA SEMANA               *)
(*  MAIOR_PRODUCAO  - MAIOR PRODUCAO DO ARTIGO NA SEMANA                 *)
(*  SOMA - ARMAZENA SOMA DA PRODUCAO DOS ARTIGOS NA SEMANA               *)
(*************************************************************************)

PROGRAM INDUSTRIA;
USES CRT;

VAR
    X,Y,N,SEMANA,ARTIGO,ARTIGO_3,MAIOR   : INTEGER;
    MAIOR_1,MAIOR_PRODUCAO,SOMA          : INTEGER;
    PRODUCAO                             : ARRAY[1..7,1..1500] OF INTEGER;

BEGIN
     CLRSCR;

(**************** LEITURA DO NUMERO DE ARTIGO DIFERENTES ******************)

     WRITELN ('QUAL O NUMERO DE ARTIGOS');
     READLN (N);

(******************** GUARDA TODOS OS DADOS NA MEMORIA ********************)

     FOR X:= 1 TO 7 DO
        BEGIN
            WRITELN (X,' § DIA DA SEMANA');
            FOR Y := 1 TO N DO
               BEGIN
                   WRITE ('ARTIGO ',Y,' : ');
                   READLN (PRODUCAO [X,Y]);
               END;
        END;

(******** PARA A TERCA FEIRA DETERMINA QUAL O ARTIGO MAIS PRODUZIDO ********)

     MAIOR :=  -1;
     FOR Y := 1 TO N DO
        IF PRODUCAO [3,Y] > MAIOR THEN
           BEGIN
                MAIOR := PRODUCAO [3,Y];
                ARTIGO_3 := Y;
           END;

(****** DETERMINA QUAL DIA DA SEMANA O ARTIGO 1 FOI O MAIS PRODUZIDO *******)

     MAIOR_1 := -1;
     FOR X:= 1 TO 7 DO
         IF PRODUCAO [X,1] > MAIOR_1 THEN
            BEGIN
                MAIOR_1 := PRODUCAO [X,1];
                SEMANA := X;
            END;

(************* DETERMINA QUAL O ARTIGO MAIS PRODUZIDO NA SEMANA ***********)

     MAIOR_PRODUCAO :=  - 1;
     FOR Y := 1 TO N DO
         BEGIN
            SOMA := 0;
            FOR X := 1 TO 7 DO
               SOMA := SOMA + PRODUCAO [X,Y];
            IF SOMA > MAIOR_PRODUCAO THEN
               BEGIN
                    MAIOR_PRODUCAO := SOMA;
                    ARTIGO := Y;
               END;
         END;

(************************ IMPRESSAO DAS SAIDAS ****************************)

     WRITELN ('NA TERCA FEIRA O ARTIGO MAIS PRODUZIDO FOI O ARTIGO ',ARTIGO_3);
     WRITELN ('NO ',SEMANA,'§ DIA DA SEMANA QUE O ARTIGO 1 FOI MAIS PRODUZIDO');
     WRITELN('O ARTIGO MAIS PRODUZIDO NA SEMANA FOI : ',ARTIGO);
END.