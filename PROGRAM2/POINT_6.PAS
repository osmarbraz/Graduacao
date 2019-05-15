PROGRAM EXERCICIO_6_PAG_33;
USES CRT;
TYPE
    REGISTRO = RECORD
                     NOME  : STRING;
                     IDADE : BYTE;
                END;
VAR
   FICHA : ARRAY [1..10] OF ^REGISTRO;

PROCEDURE LE_DADOS;
VAR
   I  : INTEGER;

BEGIN
     FOR I := 1 TO 10 DO
       BEGIN
         WRITE('DIGITE O NOME');
         READLN(FICHA[I]^.NOME);
         WRITE('DIGITE A IDADE');
         READLN(FICHA[I]^.IDADE);
      end;
END;

BEGIN
    LE_DADOS;
END.
