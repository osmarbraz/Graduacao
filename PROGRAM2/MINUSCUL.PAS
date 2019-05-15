PROGRAM _MINUSCULA;
USES CRT;
VAR
    MAIUSCULA,MINUSCULA  : STRING;
    I,TAM                : INTEGER;
    X                    : BYTE;
PROCEDURE CONVERSAO;
BEGIN
     IF (ORD (MAIUSCULA [I]) >= 65) AND (ORD (MAIUSCULA [I]) <= 90) THEN
            BEGIN
            MINUSCULA [I] := CHR ((ORD (MAIUSCULA [I]))+32);
            END
         ELSE
             MINUSCULA [I]  := MAIUSCULA [I];
END;

BEGIN
     CLRSCR;
     WRITELN ('DIGITE A PALAVRA MAIUSCULA');
     READLN (MAIUSCULA);
     TAM := LENGTH (MAIUSCULA);
     MINUSCULA := '                                   ';
     FOR I:= 1 TO TAM DO
        CONVERSAO;
     WRITELN('A STRING EM MAIUSCULA :', MINUSCULA);
     REPEAT UNTIL KEYPRESSED;
END.
