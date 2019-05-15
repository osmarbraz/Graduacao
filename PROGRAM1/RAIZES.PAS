PROGRAM RAIZES;
USES CRT;
VAR
    A,B,C : INTEGER;
    X,DELTA,RAIZ1,RAIZ2:REAL;
BEGIN
     CLRSCR;
     WINDOW (1,1,60,25);
     WRITELN('                CALCULO DE RAIZES');
     WRITELN('  PARA SAIR DIGITE A = -5 E PRESSIONE <ENTER>');
     WINDOW (16,5,80,25);
     WRITELN('DIGITE O VALOR DE A');
     READLN(A);
     WHILE A <> -5 DO
        BEGIN
        WRITELN('DIGITE O VALOR DE B');
        READLN (B);
        WRITELN('DIGITE O VALOR DE C');
        READLN (C);
        DELTA := ( B*B - 4*A*C);
        IF DELTA < 0 THEN
            WRITELN ('NAO EXISTE RAIZ')
        ELSE
          BEGIN
          DELTA := SQRT(DELTA);
          RAIZ1 :=( - B + DELTA )  /( 2*A);
          RAIZ2 :=( - B - DELTA )  /( 2*A);
          WRITELN('AS RAIZES SAO X1 =',RAIZ1,' E X2 = ',RAIZ2);
          END;
        WRITELN;
        WRITELN('DIGITE O VALOR DE A');
        READLN(A);
        END;
END.


