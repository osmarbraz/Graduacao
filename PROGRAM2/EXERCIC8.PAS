PROGRAM EXERCICIO_8;
USES CRT;
VAR
   C,Y,K,TAM        : INTEGER;
   NOME,SOBRENOME   : STRING;
   TECLA            : CHAR;
BEGIN
     CLRSCR;
     WRITELN ('DIGITE  O NOME');
     READLN (NOME);
     TAM := LENGTH(NOME);
            C := TAM;
            REPEAT
                  BEGIN
                  C := C - 1;
                  IF NOME[C] = ' ' THEN
                       BEGIN
                       Y := TAM + 1 - C;
                       SOBRENOME := COPY (NOME,C,Y);
                       END;
                   END;
            UNTIL NOME[C] = ' ';
            DELETE(NOME,C,Y);
     WRITELN (SOBRENOME ,', ',NOME);
     TECLA := READKEY;
END.

