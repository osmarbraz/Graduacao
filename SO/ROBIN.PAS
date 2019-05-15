PROGRAM ROUND_ROBIN;
USES CRT;
TYPE
    PROCESSOS = RECORD
                     ENTRADA : INTEGER;
                     CPU     : INTEGER;
                     INDICE  : INTEGER;
                     NOME    : STRING[5];
                END;
   PROCESSO = ARRAY[1..100] OF PROCESSOS;

VAR
    NUMERO_PROCESSOS, X, Y, QUANTUN, PRIMEIRO : INTEGER;
    CONT,AUX1                                 : INTEGER;
    FEITO                                     : BOOLEAN;
    PROC                                      : PROCESSO;
    AUX                                       : PROCESSOS;
BEGIN
     CLRSCR;
(*     WRITE('Qual o Numero de Processos ?');
     READLN(NUMERO_PROCESSOS);
     FOR X := 1 TO NUMERO_PROCESSOS DO
         BEGIN
              WRITE('QUAL O TEMPO DE ENTRADA DO PROCESSO ',X,' = ');
              READLN(ENTRADA[X]);
              WRITE('QUAL O TEMPO DE CPU NECESSARIA PARA O PROCESSO ',X,' = ');
              READLN(CPU[X]);
         END;
     WRITE('QUAL O QUANTUN DE TEMPO PARA A CPU = ');
     READLN(QUANTUN);*)
     NUMERO_PROCESSOS := 4;

     PROC[1].CPU := 8;
     PROC[1].ENTRADA := 4;
     PROC[1].INDICE := 1;

     PROC[2].CPU := 5;
     PROC[2].ENTRADA := 0;
     PROC[2].INDICE := 2;

     PROC[3].CPU := 6;
     PROC[3].ENTRADA := 9;
     PROC[3].INDICE := 3;

     PROC[4].CPU := 7;
     PROC[4].ENTRADA := 14;
     PROC[4].INDICE := 4;
     QUANTUN := 5;

     FOR X := 1 TO NUMERO_PROCESSOS -1 DO
         FOR Y := X +1 TO NUMERO_PROCESSOS DO
             IF PROC[X].ENTRADA > PROC[Y].ENTRADA THEN
                BEGIN
                      AUX := PROC[X];
                      PROC[X] := PROC[Y];
                      PROC[Y] := AUX;
                      AUX1 := PROC[X].INDICE;
                      PROC[X].INDICE := PROC[Y].INDICE;
                      PROC[Y].INDICE := AUX1;
                END;

     FEITO := FALSE;
     WHILE FEITO <> TRUE DO
           BEGIN
                CONT := 0;
                WHILE CONT <= NUMERO_PROCESSOS DO
                 BEGIN

(********************* Mostra o estado do processo ********************)
                      FOR X := 1 TO NUMERO_PROCESSOS DO
                         BEGIN
                              WRITELN('CPU> ',X,' > ',PROC[X].CPU,'/ ENTRADA > ',PROC[X].ENTRADA);
                              READLN;
                         END;
                      writeln('_______________________________________');
                      CONT := CONT + 1;
                      IF PROC[CONT].CPU >= QUANTUN THEN
                         PROC[CONT].CPU := PROC[CONT].CPU - QUANTUN
                      ELSE
                          IF (PROC[CONT].CPU > 0) AND (PROC[CONT].CPU < QUANTUN) THEN
                              PROC[CONT].CPU := PROC[CONT].CPU - PROC[CONT].CPU;

                      FEITO := TRUE;
                      FOR X := 1 TO NUMERO_PROCESSOS DO
                          IF PROC[X].CPU <> 0 THEN
                             FEITO := FALSE;

                END;
           END;

END.