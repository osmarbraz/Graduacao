PROGRAM CRIA_ARQUIVO;
USES CRT;
CONST
     NUM_REG = 20;
     NOME_ARQ = 'AMOSTRA.DAT';
TYPE
    REGISTRO = RECORD
                     VARIAVEL  : REAL;
                     RESTANTE  : STRING[5];
               END;
VAR
   I,J          : INTEGER;
   CARACTER     : CHAR;
   ARQUIVO      : FILE OF REGISTRO;
   REG_TRAB     : REGISTRO;

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
     ASSIGN (ARQUIVO,NOME_ARQ);
     {$I-} RESET (ARQUIVO) ;{$I+}
     IF IORESULT = 0 THEN
        BEGIN
             WRITELN;
             WRITELN(' O ARQUIVO ',NOME_ARQ,' JA EXISTE.');
             WRITELN('   ACIONE ESC PARA INTERROMPER.');
             WRITELN('QUALQUER OUTRA TECLA PARA DELETAR');
             WRITELN('      O ARQUIVO E CONTINUAR.');
             CARACTER := READKEY;
             IF CARACTER = #27 THEN
                HALT;
        END;
     REWRITE (ARQUIVO);
     FOR I := 1 TO NUM_REG DO
         BEGIN
              WITH REG_TRAB DO
                   BEGIN
                        VARIAVEL := EXPON (3.5);
                        RESTANTE [1] := $4;
                        FOR J := 1 TO 5 DO
                            RESTANTE[J] := CHR (TRUNC(RANDOM*26)+65);
                   END;
              WRITE(ARQUIVO,REG_TRAB);
         END;
     CLOSE (ARQUIVO);
END.