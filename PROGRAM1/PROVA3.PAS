{ ESTE PROGRAMA CALCULA F PARA VALORES DE X E DE Y                        }
{ ENTRADAS  N   : NUMERO DE VEZES RESOLVE A EQUACAO PARA VALORES DE X E Y }
{           X E Y : VARIAVEIS DA FUNCAO                                   }

{ SAIDA     F     : RESULTADO DA EQUACAO                                  }
{ PROCESSAMENTO   :  F:= (X**2 - X) / (Y**2 - Y)                          }

PROGRAM PROVA_3;
USES CRT;
VAR
    X,Y,F   : REAL;
    CONT,N  : INTEGER;

BEGIN
     CLRSCR;
     CONT := 0;
     {*** LEITURA DO NUMERO DE VEZES QUE VAI EXECUTAR A EQUACAO ***}
     WRITE ('QUAL O NUMERO DE VEZES ? ');
     READLN (N);
     WHILE CONT < N DO
       BEGIN
          CONT := CONT + 1;

          {******  LEITURA DO VALOR DE X ********}

          WRITE ('DIGITE O VALOR DE X : ');
          READLN (X);

          {******  LEITURA DO VALOR DE Y ********}

          WRITE ('DIGITE O VALOR DE Y : ');
          READLN (Y);

          {*********** PROCESSAMENTO ************}

          F := (SQR(X) - X) / (SQR(Y) - Y);

          {***** IMPRESSAO DOS RESULTADOS *******}

          WRITELN ('O RESULTADO E : ',F:0:2);
       END;
END.