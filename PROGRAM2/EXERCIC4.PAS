PROGRAM EXERCICIO_4;
USES CRT;
VAR
   X,DESCONTO,PRECO       : INTEGER;
   TOTAL, TOTAL_A_PAGAR   : REAL;
   NOME                   : STRING[30];
   TECLA                  : CHAR;

PROCEDURE CALCULO;
BEGIN
   TOTAL := PRECO - (PRECO * DESCONTO/100);
   TOTAL_A_PAGAR := TOTAL_A_PAGAR + TOTAL;
END;

BEGIN
      CLRSCR;
      TOTAL_A_PAGAR := 0;
      FOR X := 1 TO 4 DO
          BEGIN
               WRITELN;
               WRITE ('NOME : ');
               READLN (NOME);
               WRITE ('PRECO : ');
               READLN (PRECO);
               WRITE ('DESCONTO : ');
               READLN (DESCONTO);
               WRITELN;
               CALCULO;
               WRITELN ('NOME : ',NOME);
               WRITELN ('PRECO : ',PRECO);
               WRITELN ('PRECO COM DESCONTO : ',TOTAL:0:2);
          END;
      WRITELN ('TOTAL A PAGAR : ',TOTAL_A_PAGAR:0:2);
      TECLA := READKEY;
END.