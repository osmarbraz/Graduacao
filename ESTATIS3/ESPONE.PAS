(**************************************************************************)
(*     PROGRAMA PARA GERAR NUMERO DADO DE VALORES DE EXPONENCIAL (a)      *)
(*        USA A FUNCAO EXPON QUE GERA UM VALOR DE EXPONENCIAL (a)         *)
(**************************************************************************)

PROGRAM EXPONENC;
USES CRT;
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
END.