PROGRAM INCLUSAO;
USES CRT;
VAR
    N,X,Y   : INTEGER;
    VETOR   : ARRAY[1..100] OF STRING;
    AUX     : STRING;
    TECLA   : CHAR;
BEGIN
    CLRSCR;
    WRITELN('QUAL O NUMERO DE STRING');
    READLN(N);
    FOR X:= 1 TO N DO
       BEGIN
       WRITE(X,' ELEMENTO :');
       READLN(VETOR[X]);
       END;
    N := N +1;
    WRITELN('DIGITE A STRING PARA INCLUSAO :');
    READLN(VETOR[N]);
    FOR X := 1 TO N-1 DO
      FOR Y := X + 1 TO N DO
          IF VETOR[X] > VETOR[Y] THEN
             BEGIN
             AUX := VETOR[X];
             VETOR[X] := VETOR[Y];
             VETOR[Y] := AUX;
             END;
    FOR X := 1 TO N DO
       WRITELN(VETOR[X]);
    TECLA := READKEY;

END.

