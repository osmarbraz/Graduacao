PROGRAM EXERCICIO_2_PAG_33;
USES CRT;
CONST
    N = 20;
TYPE
    VETOR = ARRAY[1..N] OF CHAR;
VAR
   AP_VETOR : ^VETOR;
   I        : INTEGER;
BEGIN
     CLRSCR;
     NEW(AP_VETOR);
     FOR I := 1 TO N DO
       BEGIN
         WRITE(I,'- ELEMENTO = ');
         READLN(AP_VETOR^[I]);
       END;
     DISPOSE(AP_VETOR);
END.