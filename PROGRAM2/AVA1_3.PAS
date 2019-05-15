(***********************************************************************)
(*  ACADEMICO : OSMAR DE OLIVEIRA BRAZ JUNIOR - CCP 8579   19/05/94    *)
(*  CURSO DE CIENCIAS DA COMPUTACAO                                    *)
(*  DISCIPLINA DE PROGRAMACAO DE COMPUTADORES II                       *)
(*  PROFESSOR : CLAYTON BONELLI                                        *)
(*  EMPLEMETACAO DA 3 QUESTAO DA PROVA DE PRIMEIRA AVALIACAO           *)
(***********************************************************************)

PROGRAM AVALIACAO1_3_QUESTAO;
USES CRT;
CONST
     MAXIMO = 1000;
TYPE
    REGISTRO = RECORD
                     NOME    : STRING[15];
                     PROXIMO : WORD;
               END;
    VETOR = ARRAY[1..MAXIMO] OF REGISTRO;
VAR
   VET      : VETOR;
   PRIMEIRO : WORD;
   TECLA    : CHAR;


(***** FUNCAO QUE PROCURA O INDICE DA PROXIMA PALAVRA A SER ORDENADA ****)

FUNCTION INDICE_MENOR_PALAVRA (VET : VETOR ; ATUAL : WORD) : WORD;
VAR
   I,INDICE : WORD;
   MENOR    : STRING;
BEGIN
     MENOR := 'ZZZZ';
     INDICE := 0;
     FOR I := 1 TO MAXIMO DO
         IF ( I <> ATUAL ) AND ( VET[I].PROXIMO = 0 ) THEN
            IF VET[I].NOME < MENOR THEN
               BEGIN
                    MENOR := VET[I].NOME;
                    INDICE := I;
               END;
     INDICE_MENOR_PALAVRA := INDICE;
END;


(***** PROCEDURE QUE ORDENA O CAMPO PROXIMO DO VETOR VET PELO CAMPO *****)
(***** NOME ATRIBUINDO AO CAMPO PROXIMO O INDICE DA PROXIMA PALAVRA *****)
(***** A SER ORDENADA                                               *****)

PROCEDURE ORDENA_VETOR (VAR VET : VETOR ; VAR PRIMEIRO : WORD);
VAR
   ATUAL : WORD;
BEGIN
     PRIMEIRO := INDICE_MENOR_PALAVRA ( VET , 0 );
     ATUAL := PRIMEIRO;
     WHILE ATUAL > 0 DO
           BEGIN
                VET[ATUAL].PROXIMO := INDICE_MENOR_PALAVRA (VET , ATUAL);
                ATUAL := VET[ATUAL].PROXIMO;
           END;
END;


(******************* PROCEDURE QUE LE OS DADOS  *************************)

PROCEDURE LE_DADOS (VAR VET : VETOR);
VAR
   X : WORD;
BEGIN
     FOR X:= 1 TO MAXIMO DO
         BEGIN
              WRITE (X ,' - NOME : ');
              READLN (VET[X].NOME);
              VET[X].PROXIMO := 0;
         END;
     WRITELN;
END;


(********** PROCEDURE QUE ESCREVE OS NOME E OS INDICE ORDENADOS *********)

PROCEDURE ESCREVE_DADOS (VAR VET : VETOR ; VAR PRIMEIRO : WORD);
VAR
   X : WORD;
BEGIN
     WRITELN ('------ RELATORIO DOS NOMES E DOS INDICES ORDENADOS ------');
     WRITELN;
     WRITELN ('PRIMEIRO : ',PRIMEIRO);
     WRITELN;
     FOR X := 1 TO MAXIMO DO
         WRITELN (VET[X].NOME,' INDICE ' ,VET[X].PROXIMO);
     WRITELN;
END;


(******************* PROCEDURE QUE EXCLUI UM NOME ***********************)

PROCEDURE EXCLUSAO_DADO (VAR  VET : VETOR; VAR PRIMEIRO : WORD);
VAR
   X,INDICE,INDICE_PROXIMO,CHAVE : WORD;
   NOME                          : STRING[15];
BEGIN
     CHAVE := 0;
     WRITELN ('------- EXCLUSAO DE NOME --------');
     WRITELN;
     WRITE ('DIGITE O NOME PARA EXCLUSAO : ');
     READLN (NOME);
     WRITELN;
     FOR X:= 1 TO MAXIMO DO
         IF VET[X].NOME = NOME THEN
            BEGIN
                 INDICE := X;
                 INDICE_PROXIMO := VET[X].PROXIMO;
                 CHAVE := 1;
            END;
     IF CHAVE = 1 THEN
        BEGIN
            IF INDICE = PRIMEIRO THEN
               PRIMEIRO := INDICE_PROXIMO
            ELSE
               FOR X := 1 TO MAXIMO DO
                  IF VET[X].PROXIMO = INDICE THEN
                     VET[X].PROXIMO := INDICE_PROXIMO;
        END
      ELSE
         BEGIN
              WRITELN (' O NOME NAO EXISTE !!! ');
              WRITELN;
         END;
END;



(************PROCEDURE DE IMPRESSAO DOS DADOS ORDENADAMENTE *************)

PROCEDURE RELATORIO_DADOS ( VET : VETOR ; PRIMEIRO : WORD );
VAR
   SEGUINTE , I : WORD;
BEGIN
     I := 1;
     SEGUINTE := PRIMEIRO;
     WRITELN ('------ RELATORIO DOS NOMES ORDENAMENTE -------');
     WRITELN;
     WHILE SEGUINTE <> 0 DO
           BEGIN
                WRITELN (I,' - ',VET[SEGUINTE].NOME);
                SEGUINTE := VET[SEGUINTE].PROXIMO;
                I := I + 1;
           END;
END;


(************************** PROGRAMA PRINCIPAL **************************)

BEGIN
     CLRSCR;
     LE_DADOS (VET);
     ORDENA_VETOR (VET,PRIMEIRO);
     ESCREVE_DADOS (VET,PRIMEIRO);
     EXCLUSAO_DADO (VET,PRIMEIRO);
     RELATORIO_DADOS (VET,PRIMEIRO);
     TECLA := READKEY;
END.
