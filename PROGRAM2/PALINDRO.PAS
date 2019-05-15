PROGRAM PALINDROME;
USES CRT;
CONST
    N = 100;
TYPE
    SEQUENCIA = ARRAY [1..N] OF STRING[15];
VAR
   PALAVRA,NAO        : SEQUENCIA;
   CONT,CONT1,X,Y,TAM : INTEGER;
   AUX                : STRING[15];
BEGIN
    CLRSCR;
    CONT := 1;
    WRITELN ('DIGITE AS PALAVRAS');
    READLN (PALAVRA[CONT]);
    WHILE PALAVRA[CONT] <> 'FIM' DO
       BEGIN
            INC (CONT);
            WRITELN ('DIGITE OUTRA PALAVRA');
            WRITELN ('PARA SAIR DIGITE FIM E PRESSIONE <ENTER>');
            READLN (PALAVRA[CONT]);
       END;
    DEC(CONT);
    FOR X:= 1 TO CONT -1 DO
       FOR Y := X + 1 TO CONT DO
           IF PALAVRA[X] > PALAVRA [Y] THEN
              BEGIN
                  AUX := PALAVRA[X];
                  PALAVRA[X] := PALAVRA[Y];
                  PALAVRA[Y] := AUX;
              END;
    CONT1 :=0;
    
    FOR X:= 1 TO CONT DO
        BEGIN
             TAM := LENGTH(PALAVRA[X]);
             AUX := '';
             FOR Y := TAM TO 1 DO
                 AUX := AUX + PALAVRA[X][Y];
             IF PALAVRA[X] = AUX THEN
                    WRITELN (PALAVRA[X])
             ELSE
                 BEGIN
                      INC(CONT1);
                      NAO[CONT1] := PALAVRA[X];
                 END;
        END;
    WRITELN;
    WRITELN('PALAVRAS NAO PALIDROMES');
    FOR X:= 1 TO CONT1 DO
       WRITELN(NAO[X]);
    REPEAT UNTIL KEYPRESSED;
END.

