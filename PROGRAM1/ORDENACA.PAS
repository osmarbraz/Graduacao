PROGRAM ORDENACAO;
USES CRT;
VAR
     N,X,J,AUXILIAR : INTEGER;
     NUMERO         : ARRAY[1..100] OF INTEGER;
     TECLA          : CHAR;

BEGIN
     CLRSCR;
     WRITELN ('QUAL O NUMERO DE NUMEROS PARA ORDENAR ?');
     READLN (N);
     WRITELN ('DIGITE OS NUMEROS');
     FOR X:= 1 TO N DO
         READLN (NUMERO[X]);
     FOR X:= 1 TO N-1 DO
         FOR J := X+1 TO N DO
             IF NUMERO[X] < NUMERO[J] THEN
                BEGIN
                     AUXILIAR := NUMERO[X];
                     NUMERO[X] := NUMERO[J];
                     NUMERO[J] := AUXILIAR;
                END;
     FOR X := 1 TO N DO
        WRITELN (NUMERO[X]);
     TECLA := READKEY;
END.