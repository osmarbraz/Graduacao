PROGRAM NUMERO_PAR;
USES CRT;
VAR
   I,SOMA : LONGINT;
   CONT : REAL;
BEGIN
     CLRSCR;
     SOMA :=0;
     FOR I:=1 TO 10 DO
         BEGIN
         CONT := I MOD 2;
         IF CONT <>0 THEN
            BEGIN
            WRITELN('NUMERO ',I,' E IMPAR ');
            SOMA := SOMA + I;
            END
         END;
     WRITELN('A SOMA DOS NUMERO IMPARES ',SOMA);
END.