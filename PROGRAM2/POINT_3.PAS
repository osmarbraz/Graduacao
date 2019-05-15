PROGRAM EXERCICIO_3_PAG_33;
USES CRT;
CONST
    N = 20;
TYPE
    VETOR = ARRAY[1..N] OF CHAR;
VAR
   AP_VETOR      : ^VETOR;
   X,A,E,I,O,U   : INTEGER;
BEGIN
     CLRSCR;
     NEW(AP_VETOR);
     FOR X := 1 TO N DO
       BEGIN
         WRITE(X,'- ELEMENTO = ');
         READLN(AP_VETOR^[X]);
       END;
     FOR X := 1 TO N DO
        IF AP_VETOR^[X]='A' THEN
           INC (A)
           ELSE
               IF AP_VETOR^[X]='E' THEN
                  INC(E)
               ELSE
                   IF AP_VETOR^[X]='I' THEN
                      INC(I)
                   ELSE
                       IF AP_VETOR^[X]='O' THEN
                          INC(O)
                       ELSE
                           IF AP_VETOR^[X]='U' THEN
                              INC(U);

     DISPOSE(AP_VETOR);
END.