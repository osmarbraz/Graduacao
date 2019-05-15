PROGRAM EXERCICIO_5_PAG_33;
USES CRT;
TYPE
    REGISTRO = RECORD
                     NOME  : STRING;
                     IDADE : BYTE;
                END;
VAR
   FICHA : ^REGISTRO;

PROCEDURE LE_DADOS;
BEGIN
     WRITE('DIGITE O NOME');
     READLN(FICHA^.NOME);
     WRITE('DIGITE A IDADE');
     READLN(FICHA^.IDADE);
END;

BEGIN
    LE_DADOS;
END.
