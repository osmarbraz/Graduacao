(* ESTE PROGRAMA  DETERMINA  PARA N ALUNOS DE UMA TURMA QUE FIZERAM UM  *)
(* TESTE DE 10 QUESTOES , QUE ADMITE RESPOSTAS A,B,C,D,E : *)
(* - RELACAO CONTENDO O NOME E O NUMERO DE ACERTOS *)
(* - O NUMERO DE ALUNOS QUE ACERTARAO AS QUESTOES 1 E 2 E TIVERAM 7 ACERTOS*)
(* - A MELHOR NOTA E O NOME ALUNO *)

PROGRAM TESTE;
USES CRT;
VAR
     NOME,NOME_MELHOR                         : STRING;
     GABARITO,RESPOSTA                        : ARRAY [1..10] OF STRING;
     ALUNOS                                   : ARRAY [1..150] OF STRING;
     ACERTOS                                  : ARRAY [1..150] OF INTEGER;
     QUESTOES,MELHOR,CERTOS,X,CONT            : INTEGER;

BEGIN
     CLRSCR;
     CONT := 0;
     MELHOR := 0;
     QUESTOES := 0;
     NOME_MELHOR := 'A';

   (*** LEITURA DO GABARITO ***)

     WRITELN ('DIGITE O GABARITO DO TESTE');
     FOR X:= 1 TO 10 DO
        BEGIN
            WRITE ( X,'- QUESTAO : ');
            READLN (GABARITO [X]);
        END;

   (*** LEITURA DO NOME ***)

   WRITELN;
   WRITE(' DIGITE O NOME DO ALUNO : ');
   READLN(NOME);
   WHILE NOME <> '*' DO
        BEGIN

        (*** LEITURA DAS RESPOSTAS DO ALUNO ***)

        FOR X := 1 TO 10 DO
            BEGIN
               WRITE( X,' QUESTAO - ');
               READLN(RESPOSTA[X]);
            END;

        (*** NUMERO DE ACERTOS DO ALUNO ***)

        CERTOS := 0;
        FOR X:= 1 TO 10 DO
            IF RESPOSTA[X] = GABARITO[X] THEN
               CERTOS := CERTOS + 1;

        (*** ARMAZENA O NOME E O NUMERO DE ACERTOS DOS ALUNOS ***)

        CONT  := CONT + 1;
        ALUNOS[CONT] := NOME;
        ACERTOS[CONT] := CERTOS;

        (*** NUMERO DE ALUNOS QUE ACERTARAM AS QUESTOES 1 E 2 E - 7 ACERTOS***);

        IF(GABARITO[1] = RESPOSTA[1])AND(RESPOSTA[2]=GABARITO[2])AND(CERTOS<7) THEN
            QUESTOES := QUESTOES + 1;

        (*** ARMAZENA MAIOR NUMERO DE ACERTOS E O NOME DO ALUNO ***)

        IF CERTOS > MELHOR THEN
           BEGIN
               MELHOR := CERTOS;
               NOME_MELHOR := NOME;
           END;

        (*** CARTAO BANDEIRA E "*" '***);
        (*** LEITURA DO NOME DO ALUNO ***);

        WRITELN (' PARA SAIR DIGITE NOME "*" ');
        WRITE (' DIGITE O NOME DO ALUNO : ');
        READLN(NOME);
        END;

        (*** IMPRESSAO DAS SAIDAS ***);

        FOR X:= 1 TO CONT DO
           WRITELN(' ALUNO : ',ALUNOS[X],' ---  ACERTOS  : ',ACERTOS[X]);
        WRITELN(' NUMERO DE ALUNOS QUE ACERTARAO AS QUESTOES 1 E 2 E ');
        WRITELN(' E FIZERAM MENOS DE 7 ACERTOS FOI : ',QUESTOES);
        WRITELN(' O MELHOR ALUNO FOI : ',NOME_MELHOR,' COM ',MELHOR,' ACERTOS');
END.


