
PROGRAM EXERCICIO_9;
USES CRT;
VAR
   N,CONT      : INTEGER;
   TECLA       : CHAR;
BEGIN
     CLRSCR;
     CONT := 0;
     WRITELN ('DIGITE UMA A QUANTIDADE DE CARACTERES');
     READLN (N);
     WRITELN ('DIGITE UMA SERIE DE STRING');
     TECLA := READKEY;
     WHILE TECLA<> #13 DO
         BEGIN
              CONT := CONT + 1;
              IF CONT = N THEN
                 BEGIN
                 WRITELN;
                 WRITELN (' A STRING ESTRAPOLOU OS PARAMETROS , TECLE <ENTER>');
                 END;
              WRITE (TECLA);
              TECLA := READKEY;
         END;
         WRITELN;
END.