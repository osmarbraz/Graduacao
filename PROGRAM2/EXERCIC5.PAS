
PROGRAM EXERCICIO_5;
USES CRT;
VAR
   VALOR,PAGO,TROCO                              : INTEGER;
   NOTAS_100,NOTAS_10,NOTAS_1,RESTO_100,RESTO_10 : INTEGER;
   TECLA                                         : CHAR;
BEGIN
      CLRSCR;
      WRITE ('QUAL O VALOR DA COMPRA : ');
      READLN (VALOR);
      WRITE ('QUAL O VALOR PAGO : ');
      READLN (PAGO);
      TROCO := PAGO - VALOR;
      WRITELN ('TROCO DO CLIENTE : ',TROCO);
      WRITELN;
      NOTAS_100 := TROCO DIV 100;
      RESTO_100 := TROCO MOD 100;
      NOTAS_10 := RESTO_100 DIV 10;
      RESTO_10 := RESTO_100 MOD 10;
      NOTAS_1 := RESTO_10 DIV 1;
      WRITELN ('NOTAS DE 100 :',NOTAS_100);
      WRITELN ('NOTAS DE 10  :',NOTAS_10);
      WRITELN ('NOTAS DE 1   :',NOTAS_1);
      TECLA := READKEY
END.