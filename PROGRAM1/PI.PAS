PROGRAM FIRST;
USES CRT;
VAR
  SOM,P:REAL;
  I,N:LONGINT;
BEGIN
  WRITELN('QUANTOS TERMOS ?');
  READLN(N);
  SOM:= 0;
    FOR I:=1 TO N DO
     SOM:= SOM + 6/(I*I);
    P:= SQRT(SOM);
      WRITELN('PI = ',P:2:5);
      REPEAT UNTIL KEYPRESSED;
END.


