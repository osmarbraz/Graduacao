PROGRAM MAISCULAS;
USES CRT;
TYPE
    LETRAS = STRING [45];
VAR
   NOME : LETRAS;

PROCEDURE CONVERSAO (VAR NOME:LETRAS);
VAR
   TAM,I : BYTE;
   X     : LETRAS;
BEGIN
     TAM := LENGTH(NOME);
     X := '';
     FOR I := 1 TO TAM DO
         X := X + UPCASE(NOME[I]);
     NOME := X;
END;
BEGIN
     CLRSCR;
     WRITELN('DIGITE A STRING minuscula :');
     READLN(NOME);
     CONVERSAO(NOME);
     CLRSCR;
     WRITELN('A STRING MAISCULA = ',NOME);
     REPEAT UNTIL KEYPRESSED;
END.

