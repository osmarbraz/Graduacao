PROGRAM EXERCICIO_7;USES CRT;
VAR
   NUMERO                                     : STRING[3];
   SOM1,SOM2,SOM3                             : STRING[1];
   SOMA1,SOMA2,SOMA3                          : INTEGER;
   ERRO1,ERRO2,ERRO3,SOMA_TOTAL               : INTEGER;
   TECLA                                      : CHAR;
BEGIN
     CLRSCR;
     WRITELN ('DIGITE UM NUMERO MENOR QUE 1000');
     READLN (NUMERO);
     SOM1 := NUMERO[1];
     SOM2 := NUMERO[2];
     SOM3 := NUMERO[3];
     VAL (SOM1,SOMA1,ERRO1);
     VAL (SOM2,SOMA2,ERRO2);
     VAL (SOM3,SOMA3,ERRO3);
     SOMA_TOTAL := SOMA1 + SOMA2 + SOMA3;
     WRITE ('A SOMA DOS DIGITOS E : ');
     WRITELN (SOMA_TOTAL);
     TECLA := READKEY;
END.