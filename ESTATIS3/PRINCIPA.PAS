PROGRAM PRINCIPAL;
USES CRT,MY_WAY;
TYPE
    VETDOIS = ARRAY [1..2] OF REAL;
VAR
   CERTEZA,OPCAO : CHAR;

(***************************************************************************)

PROCEDURE ENTRADA_DADOS (VAR  ENTRADA : STRING);
VAR
   TAM,X,Y : BYTE;
BEGIN
     TAM := LENGTH(ENTRADA);
     FOR X:=1 TO TAM DO
         ENTRADA[X] := UPCASE (ENTRADA[X]);
     Y := 0;
     REPEAT
           INC(Y);
     UNTIL ENTRADA[Y] <>' ';
     DELETE (ENTRADA,1,Y-1);
END;

(***************************************************************************)

PROCEDURE TESTERND;
VAR
   I,VALOR,NUM     : INTEGER;
   ESP,QUI_Q       : REAL;
   FREQ            : ARRAY [0..9] OF INTEGER;
BEGIN
     CLRSCR;
     WRITE('DIGITE O NUMERO DE VALORES A SEREM GERADOS = ');
     READLN(NUM);

     (**** INICIALIZA OS VALORES DE FREQ E QUI_Q ****)

     FOR I := 0 TO 9 DO
        FREQ[I]:= 0;
     QUI_Q := 0;

     (**** GERA OS VALORES E CONTA AS FREQUENCIAS *****)

     FOR I := 1 TO NUM DO
         BEGIN
              VALOR := TRUNC (RANDOM * 10);
              FREQ[VALOR] := FREQ[VALOR] + 1;
         END;

     (************* CALCULA O QUI-QUADRADO ************)

     ESP := NUM / 10;
     FOR I := 0 TO 9 DO
         QUI_Q := QUI_Q + (FREQ[I]-ESP)*(FREQ[I]-ESP)/ESP;

     (*********** APRESENTA OS RESULTADOS *************)

     WRITELN;
     FOR I := 0 TO 9 DO
         WRITELN('DIG : ',I,'  FREQUENCIA : ',FREQ[I]:5);
     WRITELN;
     WRITELN ('QUI-QUADRADO : ',QUI_Q:7:2);
     WRITELN;
     WRITELN('>>>>PARA RETORNAR AO MENU PRINCIPAL PRESSIONE <ESC> <<<<');
     REPEAT UNTIL KEYPRESSED;
END;


(**************************************************************************)
(*     PROGRAMA PARA GERAR NUMERO DADO DE VALORES DE EXPONENCIAL (a)      *)
(*        USA A FUNCAO EXPON QUE GERA UM VALOR DE EXPONENCIAL (a)         *)
(**************************************************************************)

PROCEDURE EXPONENC;
VAR
   I,NUMERO     : INTEGER;
   PARAM,VALOR  : REAL;

FUNCTION EXPON (ALFA : REAL) : REAL;
BEGIN
     IF ALFA <= 0 THEN
        BEGIN
             CLRSCR;
             WRITELN('O PARAMETRO DA EXPONENCIAL');
             WRITELN('     DEVE SER POSITIVO    ');
             HALT;
        END
     ELSE
         EXPON := - ALFA * LN (RANDOM);
END;

BEGIN
     CLRSCR;
     REPEAT
         WRITE ('NUMERO DE GERACOES : ');
         READLN (NUMERO);
         IF NUMERO <= 0 THEN
            BEGIN
                CLRSCR;
                WRITELN('O NUMERO DE GERACOES DEVE');
                WRITELN(' SER MAIOR DO QUE ZERO   ');
            END;
     UNTIL NUMERO > 0;
     WRITE ('         PARAMETRO : ');
     READLN (PARAM);
     WRITELN;
     WRITELN ('VALORES GERADOS :');
     WRITELN;
     FOR I := 1 TO NUMERO DO
         BEGIN
              VALOR := EXPON (PARAM);
              WRITE (VALOR:12:4);
              IF (I MOD 5) = 0 THEN
                 WRITELN;
         END;
      WRITELN;
      WRITELN('>>>>PARA RETORNAR AO MENU PRINCIPAL PRESSIONE <ESC> <<<<');
      REPEAT UNTIL KEYPRESSED;
END;

(**************************************************************************)
(*    PROGRAMA PARA GERAR UM NUMERO DADO DE VALORES DE UMA DISTRIBUICAO   *)
(*            DISCRETA COM NO MAXIMO 50 VALORES DIFERENTES                *)
(**************************************************************************)

PROCEDURE GERADISC;
CONST
     MAX_GER = 1000;
     MAX_VAL = 50;
TYPE
    VETOR_REAL = ARRAY [1..MAX_VAL] OF REAL;
VAR
   I,NUM_GER      : INTEGER;
   NUM_VAL        : BYTE;
   TUDO_OK        : BOOLEAN;
   XIS,PROB       : VETOR_REAL;
   PROB_TOT       : REAL;


FUNCTION ENTRA_NUM (NUM_MIN,NUM_MAX : INTEGER) : INTEGER;
VAR
   NUM_DADO : INTEGER;
BEGIN
     REPEAT
           READLN (NUM_DADO);
           IF (NUM_DADO < NUM_MIN) OR (NUM_DADO > NUM_MAX) THEN
              BEGIN
                   WRITE ('O NUMERO DEVE SER');
                   IF NUM_DADO < NUM_MIN THEN
                      WRITELN ('MAIOR OU IGUAL A ',NUM_MIN)
                   ELSE
                       WRITELN ('MENOR OU IGUAL A ',NUM_MAX);
                   DELAY (50);
              END;
     UNTIL (NUM_DADO >= NUM_MIN) AND (NUM_DADO <= NUM_MAX);
     ENTRA_NUM := NUM_DADO;
END;

FUNCTION DISCRETA (NUMERO : BYTE; X,P : VETOR_REAL ): REAL;
VAR
   K        : BYTE;
   GERADO   : REAL;
   PROB_CUM : ARRAY [0..50] OF REAL;
BEGIN
     PROB_CUM[0] := 0;
     FOR K := 1 TO NUMERO DO
         PROB_CUM[K] := PROB_CUM[K-1] + P[K];
     GERADO := RANDOM;
     K := 0;
     WHILE GERADO > PROB_CUM[K] DO
           K := K + 1;
     DISCRETA := X[K];
END;


BEGIN
     CLRSCR;
     WRITE ('DE O NUMERO DE VALORES DIFERENTES DE X : ');
     NUM_VAL := ENTRA_NUM (1,MAX_VAL);
     WRITE ('DE O NUMERO DE GERACOES A SEREM FEITAS : ');
     NUM_GER := ENTRA_NUM (1,MAX_GER);
     PROB_TOT := 0;
     WRITELN ('DE OS VALORES DE X E P(X) : ');
     FOR I := 1 TO NUM_VAL DO
         REPEAT
               TUDO_OK := TRUE;
               WRITE ('X(',I,'): ');
               READ (XIS[I]);
               WRITE ('        P(X) : ');
               READLN (PROB[I]);
               PROB_TOT := PROB_TOT + PROB[I];
               IF (PROB[I] < 0) OR (PROB[I] > 1) OR (PROB_TOT > 1) THEN
                  BEGIN
                       WRITELN ('ERRO, REPITA.');
                       PROB_TOT := PROB_TOT - PROB[I];
                       TUDO_OK := FALSE;
                       DELAY (50);
                  END;
         UNTIL TUDO_OK;
         WRITELN ('VALORES GERADOS : ');
         FOR I := 1 TO NUM_GER DO
             WRITELN (DISCRETA (NUM_VAL,XIS,PROB):0:0);

      WRITELN;
      WRITELN('>>>>PARA RETORNAR AO MENU PRINCIPAL PRESSIONE <ESC> <<<<');
      REPEAT UNTIL KEYPRESSED;

END;

(*************************************************************************)
(*        FUNCAO PARA GERAR UM VALOR DE BERNOLLI COM PARAMETRO P         *)
(*************************************************************************)

FUNCTION BERNOULLI ( PE : REAL ) : INTEGER;
BEGIN
     IF (PE <= 0) OR (PE >= 1) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O PARAMETRO DA BERNOULLI');
             WRITELN ('     DEVE  ESTAR EM (0,1).');
             HALT;
        END
     ELSE
         IF RANDOM <= PE THEN
            BERNOULLI := 1
         ELSE
             BERNOULLI := 0;
END;

(*************************************************************************)
(*        FUNCAO PARA GERAR UM VALOR DE BINOMIAL  (ENE, PE)              *)
(*************************************************************************)
FUNCTION BINOMIAL (ENE : INTEGER; PE : REAL) : INTEGER;
VAR
   I,VALOR  :INTEGER;
BEGIN
     IF ( ENE <= 0) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O NUMERO DE TENTATIVAS DA ');
             WRITELN ('  BINOMIAL DEVE SER > 0 .');
             HALT;
        END
     ELSE
         BEGIN
              VALOR := 0;
              FOR I :=1 TO ENE DO
                  VALOR := VALOR + BERNOULLI (PE);
         END;
     BINOMIAL := VALOR;
END;


(*************************************************************************)
(*    FUNCAO PARA GERAR UM VALOR DE POISSON COM PARAMETRO LAMBDA         *)
(*************************************************************************)

FUNCTION POISSON ( LAMBDA : REAL ) : INTEGER;
VAR
   SOMA              : INTEGER;
   PRODUTO,COMPARA   : REAL;
BEGIN
     IF (LAMBDA <= 0) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O PARAMETRO DA POISSON ');
             WRITELN ('DEVE SER MAIOR DO QUE 0');
             HALT;
        END
     ELSE
         BEGIN
              COMPARA := EXP ( - LAMBDA);
              PRODUTO := 1;
              SOMA := -1;
              REPEAT
                    PRODUTO := PRODUTO * RANDOM;
                    SOMA := SOMA + 1;
              UNTIL PRODUTO <= COMPARA;
              POISSON := SOMA;
         END;
END;

(*************************************************************************)
(*    FUNCAO PARA GERAR NORMAL  (0,1) A PARTIR DE 12 UNIFORMES           *)
(*************************************************************************)
FUNCTION NORM_12U : REAL;
VAR
   VALOR   : REAL;
   I       : BYTE;
BEGIN
     VALOR := 0;
     FOR I := 1 TO 12 DO
         VALOR := VALOR + RANDOM;
     NORM_12U := VALOR - 6;
END;



(**************************************************************************)
(*      PROCEDIMENTO PARA GERAR NORMAL (0,1) - BOX MULLER MARSAGLIA       *)
(**************************************************************************)

PROCEDURE NORM_B_M ( VAR NORM_2 : VETDOIS);
VAR
   V_UM, V_DOIS, RAIZ, ESSE  : REAL;
BEGIN
     REPEAT
           V_UM := 2 * RANDOM -1;
           V_DOIS := 2 * RANDOM -1;
           ESSE := V_UM * V_UM + V_DOIS *V_DOIS;
     UNTIL ESSE < 1;
     RAIZ := SQRT ( - 2 * LN (ESSE) / ESSE);
     NORM_2[1] := V_UM * RAIZ;
     NORM_2[2] := V_DOIS * RAIZ;
END;


(**************************************************************************)
(*                         PROGRAMA PRINCIPAL                             *)
(**************************************************************************)

BEGIN
     OPCAO := '0';
     REPEAT
        BEGIN
           CLRSCR;
           WRITELN ('  1 - TESTE DO GERADOR DO GERADOR ALEATORIO DO TURBO PASCAL');
           WRITELN ('  2 - GERAR UM NUMERO DADO DE VALORES DE  UMA  DISTRIBUICAO');
           WRITELN ('     EXPONENCIAL NEGATIVA COM PARAMETRO QUALQUER');
           WRITELN ('  3 - GERAR UM NUMERO DADO DE VALORES PARA UMA DISTRIBUICAO');
           WRITELN ('     DISCRETA COM NO MAXIMO 50 VALORES DIFERENTES');
           WRITELN ('  4 - FIM');
           WRITELN;
           WRITELN('   ESCOLHA A OPCAO : ');
           READLN (OPCAO);
           CASE OPCAO OF
                      '1'      : TESTERND;
                      '2'      : EXPONENC;
                      '3'      : GERADISC;
                      '4'      : BEGIN
                                   WRITELN ('VOCE TEM CERTEZA (S/N) ?');
                                   READLN (CERTEZA);
                                   IF (CERTEZA = 'N') OR (CERTEZA ='n') THEN
                                      OPCAO :='1'
                                   ELSE
                                       IF (CERTEZA='S') OR (CERTEZA='s') THEN
                                          OPCAO :='4'
                                       ELSE
                                           OPCAO := '1';


                                 END;
                      ELSE
                          IF (OPCAO<>'1') OR (OPCAO<>'2') OR (OPCAO<>'3') OR
                           (OPCAO <>'4') OR (OPCAO <>' ') THEN
                               BEGIN
                                    WRITELN ('>>>>> ESTA OPCAO NAO EXISTE TENTE NOVAMENTE !!!!<<<<');
                                    DELAY(2000);
                               END;
                      END;
        END;
      UNTIL OPCAO='4'
END.