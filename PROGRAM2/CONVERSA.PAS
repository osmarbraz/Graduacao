PROGRAM MASSTRIAS;
USES CRT;
VAR
     M, MINUSCULA :ARRAY[1..30,1..30] OF STRING [30];
     I,J,Y,N: INTEGER;
PROCEDURE CONVERSAO;
BEGIN
    MINUSCULA [I,J] :=' ';
    IF (ORD (M[I,J]) >= 65) AND (ORD (M[I,J]) <= 90) THEN
            BEGIN
            MINUSCULA [I,J]:= CHR((ORD (M[I,J])) + 32);
            END
    ELSE
         MINUSCULA [I,J]:= M[I,J];
END;
PROCEDURE ENTRADA;
BEGIN
    FOR I:= 1 TO N DO
      FOR J:= 1 TO N DO
        BEGIN
            WRITE(' ENTRE ELEMENTO [,'I,',',J,']:');
            READLN(M[I,J]);
        END;
END;
BEGIN
    CLRSCR;
    WRITE('ENTRE O TAMANHO DA MATRIZ:');
    READLN(N);
    ENTRADA;
    FORI:= 1 TO N DO
       FOR J:= 1 TO N DO
           BEGIN
               IF N <> (N - J + I)  THEN
                   CONVERSAO;
               ELSE
                   MINUSCULA[I,J]:= M[I,J];
           END;
    WRITELN(' RESULTADO: ');
    FOR I:= 1 TO N DO
      FOR J:= 1 TO N DO
         WRITE(MINUSCULA[I,J], ' ');
         WRITELN;
    RECHICO                �w  