PROGRAM EXERCICIO_1_PAG_33;
USES CRT;
CONST
    N = 20;
VAR
   AP_VETOR : ARRAY[1..N] OF ^REAL;
   I        : INTEGER;
BEGIN
     CLRSCR;
     FOR I := 1 TO N DO
       BEGIN
         NEW(AP_VETOR[I]);
         WRITE(I,'- ELEMENTO = ');
         READ(AP_VETOR[I]^);
       END;
     FOR I := 1 TO N DO
         DISPOSE(AP_VETOR[I]);
END.

