PROGRAM FUNCIONARIO;
USES CRT;
TYPE
    VETOR = ARRAY[1..10] OF STRING;
    VETOR1 = ARRAY[1..10] OF REAL;
VAR
    NOME             : VETOR;
    SALARIOBRUTO     : VETOR1;
    K,CHAVE,I        : INTEGER;
    B                : STRING;
    A,VALOR,NUMERO   : REAL;


BEGIN
     CLRSCR;
     FOR K := 1 TO 10 DO
        BEGIN
        WRITELN ('DIGITE O NOME');
        READLN(NOME[K]);
        WRITELN ('VALOR DA HORA TRABALHADA');
        READLN(VALOR);
        WRITELN ('NUMERO DE HORAS TRABALHADAS');
        READLN (NUMERO);
        SALARIOBRUTO[K] := NUMERO * VALOR;
        END;
     I := 1;
     CHAVE := 0;
     WHILE (I < 10) AND (CHAVE = 0) DO
           BEGIN
           CHAVE := 1;
           FOR K:= 1 TO 9  DO
               IF NOME [K+1] < NOME [K] THEN
                  BEGIN
                  A := SALARIOBRUTO[K];
                  B := NOME [K];
                  NOME [K] := NOME [K+1];
                  SALARIOBRUTO[K]:= SALARIOBRUTO[K+1];
                  NOME [K+1] := B;
                  SALARIOBRUTO [K+1] := A;
                  CHAVE := 0;
                  END;
               I:=I+1;
           END;
     FOR K:= 1 TO 10 DO
     BEGIN
          WRITELN(NOME[K],' =  ',SALARIOBRUTO[K]:0:2);
     END;
     REPEAT UNTIL KEYPRESSED;
END.



