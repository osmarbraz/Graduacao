PROGRAM GERADISC;
USES CRT;
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
END.