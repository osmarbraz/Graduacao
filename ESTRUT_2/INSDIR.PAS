PROGRAM INSDIR;
USES CRT;
VAR
   VET                         : ARRAY [0..100] OF INTEGER;
   X,I,J,AUX,N                 : INTEGER;

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

     FOR J:= 2 TO N DO
         BEGIN
              AUX := VET[J];
              X := AUX;
              VET[0] := X;
              I := J - 1;
              WHILE X < VET[I] DO
                    BEGIN
                         VET[I+1] := VET[I];
                         I := I - 1;
                    END;
              VET[I + 1] := AUX;
         END;


     FOR X:= 1 TO N DO
          WRITE(VET[X]);

      READLN;
END.

