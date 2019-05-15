PROGRAM MAIOR_VALOR;
USES CRT;
CONST
     FIM = 5;
TYPE
    NUMEROS = ARRAY [1..FIM] OF LONGINT;
VAR
   SEQUENCIA   : NUMEROS;
   K           : INTEGER;
   MAIOR       : LONGINT;
BEGIN
     CLRSCR;
     WINDOW (1,10,50,25);
     FOR K := 1 TO FIM DO
         READLN ( SEQUENCIA [K]);
     MAIOR := SEQUENCIA [1];
     FOR K:= 2 TO FIM DO
         IF SEQUENCIA [K] > MAIOR THEN
            MAIOR := SEQUENCIA [K];
     WRITELN ('O MAIOR E : ',MAIOR)
END.
