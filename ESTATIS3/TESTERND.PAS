PROGRAM  TESTERND;
USES CRT;
CONST
     NUM = 10000;
VAR
   I,VALOR         : INTEGER;
   ESP,QUI_Q       : REAL;
   FREQ            : ARRAY [0..9] OF INTEGER;
BEGIN
     CLRSCR;

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

     FOR I := 0 TO 9 DO
         WRITELN('DIG : ',I,'  FREQUENCIA : ',FREQ[I]:5);
     WRITELN;
     WRITELN ('QUI-QUADRADO : ',QUI_Q:7:2);
END.
