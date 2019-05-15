PROGRAM BOLHA1;
USES CRT;
VAR
   VET                         : ARRAY [1..100] OF INTEGER;
   X,I,J,AUX,N,BOLHA,LSUP      : INTEGER;

BEGIN
     CLRSCR;
     WRITE ('DIGITE A QUANTIDADE DE NUMEROS : ');
     READLN (N);
     FOR X:=1 TO N DO
         BEGIN
              WRITE ('NUMERO ',X, ' = ');
              READLN (VET[X]);
         END;           
     WRITELN;           
     FOR X:= 1 TO N DO
         WRITE(VET[X]);
     WRITELN;           
     LSUP := N;
     REPEAT
           BOLHA := 0;  
           FOR J:= 1 TO LSUP-1 DO
           BEGIN
              IF VET[J] > VET [ J+1] THEN
                 BEGIN
                      AUX := VET[J];
                      VET[J] := VET[J+1];
                      VET[J+1] := AUX;
                      BOLHA := J;
                 END;
            END;
           LSUP := BOLHA;
     UNTIL LSUP <= 1;
     FOR X:= 1 TO N DO
          WRITE(VET[X]);
      READLN;
END.

