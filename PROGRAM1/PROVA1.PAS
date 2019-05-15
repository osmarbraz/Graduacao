{ ESTE PROGRAMA TEM POR OBJETIVO : }
{ - ENCONTRAR ENTRE 4 VALORES REAIS  O MAIOR DELES }
{ - DETERMINAR A ORDEM CUJA A SOMA DOS QUATROS VALORES E MAXIMA }
{ - IMPRIMIR O REGISTRO CUJO OS 4 VALORES TEM PARTE DECIMAL IGUAL A ZERO }
{ - IMPRIMIR OS QUATRO VALORES NA FORMA ARREDONDADA }

{ VARIAVEIS DE ENTRADA : }
{      N                : NUMERO DE REGISTROS }
{  VAL1,VAL2,VAL3,VAL4  : 4 VALORES REAIS }

{ VARIAVEIS DE SAIDA   : }
{ MAIOR             : MAIOR DOS QUATRO VALORES }
{ ORDEM             : NUMERO DO REGISTRO CUJA A SOMA E MAXIMA }

{ PROCESSAMENTO : }
{ SOMA     : SOMATORIO DOS QUATRO VALORES }
{ X        : VARIAVEL QUE RECEBE O VALOR TRUNCADO }



PROGRAM PROVA_1;
USES CRT;
VAR
    CONT,N,ORDEM,X                                     : INTEGER;
    VAL1,VAL2,VAL3,VAL4,MAIOR_SOMA,SOMA,MAIOR          : REAL;

BEGIN
     CLRSCR;
     MAIOR_SOMA := 0;
     CONT := 1;
     WRITE ('QUAL O NUMERO DE VEZES A REPETIR ? ');
     READLN (N);
     WHILE CONT <= N DO
          BEGIN

               {**** LEITURA DOS DADOS DE ENTRADA ****}

               WRITE ('DIGITE O VALOR 1 : ');
               READLN (VAL1);
               WRITE ('DIGITE O VALOR 2 : ');
               READLN (VAL2);
               WRITE ('DIGITE O VALOR 3 : ');
               READLN (VAL3);
               WRITE ('DIGITE O VALOR 4 : ');
               READLN (VAL4);
               IF (VAL1 > VAL2) AND (VAL1 > VAL3) AND (VAL1 > VAL4) THEN
                  MAIOR := VAL1
               ELSE
                   IF (VAL2 > VAL1 ) AND (VAL2 > VAL3) AND (VAL2 > VAL4) THEN
                     MAIOR := VAL2
                   ELSE
                       IF (VAL3 > VAL1) AND ( VAL3 > VAL2) AND (VAL3 > VAL4) THEN
                          MAIOR := VAL3
                       ELSE
                          MAIOR := VAL4;

               {**** IMPRESSAO DO MAIOR DOS QUATRO VALORES ****}

               WRITELN ('ENTRE OS VALORES ',VAL1,VAL2,VAL3,VAL4,' O MAIOR E ',MAIOR);
               SOMA := VAL1 + VAL2 + VAL3 + VAL4;

               {**** PROCURA DA ORDEM CUJA A SOMA E MAXIMA ****}

               IF SOMA > MAIOR_SOMA THEN
                  BEGIN
                      MAIOR_SOMA := SOMA;
                      ORDEM := CONT;
                  END;

               {**** VERIFICA SE OS 4 VALORES TEM PARTE DECIMAL IGUAL A 0}

               X := TRUNC (VAL1);
               IF VAL1 = X THEN
                  BEGIN
                      X := TRUNC (VAL2);
                      IF X = VAL2 THEN
                         BEGIN
                             X := TRUNC (VAL3);
                             IF X = VAL3 THEN
                                BEGIN
                                    X:= TRUNC (VAL4);
                                    IF X = VAL4 THEN
                                       WRITELN ('OS VALORES ',VAL1,VAL2,VAL3,VAL4,' TEM PARTE DECIMAL IGUAL A ZERO');                                       WRITELN('VALORES ',VAL1,VAL2,VAL3,VAL4,' TEM PARTE DECIMAL IGUAL A 0');
                                END;
                         END;
                  END;

               {**** ARRENDONDAMENTO DOS QUATRO VALORES ****}

               X := TRUNC (VAL1);
               IF (VAL1 - X) < 0.5 THEN
                  VAL1 := X
               ELSE
                  VAL1 := X + 1;
               X := TRUNC (VAL2);
               IF (VAL2 - X) < 0.5 THEN
                   VAL2 := X
               ELSE
                  VAL2 := X + 1;
               X := TRUNC (VAL3);
               IF (VAL3 - X) < 0.5 THEN
                  VAL3 := X
               ELSE
                  VAL3 := X + 1;
               X := TRUNC (VAL4);
               IF (VAL4 - X) < 0.5 THEN
                  VAL4 := X
               ELSE
                  VAL4 := X + 1;
               WRITELN(' OS VALORES ARREDONDADOS SAO ',VAL1,VAL2,VAL3,VAL4);
               CONT := CONT + 1;
          END;

          {**** IMPRESSAO DO REGISTRO CUJA A SOMA E MAXIMA ****}

          WRITELN(' O REGISTRO CUJA A SOMA E MAXIMA E O ',ORDEM)
END.
