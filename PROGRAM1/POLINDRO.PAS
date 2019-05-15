PROGRAM POLINDROME;
USES CRT;
VAR
   PALAVRA              : STRING[30];
   J,CONT,TAM,FIM       : INTEGER;
BEGIN
     CLRSCR;
     CONT := 0;
     WRITELN ('DIGITE UMA PALAVRA');
     READLN (PALAVRA);
     TAM := LENGTH(PALAVRA);

     FIM := TAM;
     FOR J := 1 TO TAM DO
        BEGIN
             IF PALAVRA[J] = PALAVRA[FIM] THEN
                   CONT := CONT + 1;
             FIM := FIM -1;
        END;
     IF CONT = TAM THEN
        WRITELN(' A PALAVRA E POLINDROME');
     ELSE
        WRITELN(' A PALAVRA NAO E POLINDROME');

END.
