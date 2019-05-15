PROGRAM SELECAO_DIRETA;
USES CRT;
VAR
   VET                       : ARRAY [1..100] OF INTEGER;
   J,INDICE,N,I              : INTEGER;
   MENOR,AUX                 : INTEGER;


BEGIN
     CLRSCR;

     WRITE ('QUAL O TAMANHO DO VETOR : ');
     READLN(N);

     FOR J := 1 TO N DO
        BEGIN
             WRITE ('DIGITE OS NUMEROS : ',J,' = ');
             READLN (VET[J]);
        END;

     WRITELN;
     FOR J := 1 TO N DO
         WRITE (VET[J],' = ');

     WRITELN;
     FOR J := 1 TO (N-1) DO
         BEGIN
              WRITELN;
              MENOR := VET[J];
              WRITELN ('MENOR = ',MENOR);

              INDICE := J;
              WRITELN ('INDICE = ',INDICE);

              FOR I := (J+1) TO N DO
                  IF MENOR > VET[I] THEN
                     BEGIN
                          INDICE := I;
                          WRITELN;
                          WRITELN ('INDICE = ',INDICE);
                     END;
              AUX := VET[INDICE];
              VET[INDICE] := VET[J];
              VET[J] := AUX;
         END;

     WRITELN;
     FOR J := 1 TO N DO
         WRITE(VET[J]);

     READLN

END.