PROGRAM INTERCALACAO;
USES CRT;
TYPE
    VETOR1 = ARRAY [1..100] OF INTEGER;
    VETOR2 = ARRAY [1..200] OF INTEGER;

VAR
   VET1, VET2          : VETOR1;
   VET3                : VETOR2;

   FEITO               : BOOLEAN;
   N,M,X,Y,Z,TOTAL     : INTEGER;
   LSUP,BOLHA,AUX      : INTEGER;

BEGIN
     CLRSCR;

    (****************** VETOR 1 ***********************)

     WRITE ('QUAL O TAMANHO DO VETOR 1 = ');
     READLN (N);

     FOR X:= 1 TO N DO
         BEGIN
              WRITE ('VETOR 1 [ ',X,' ] = ');
              READLN (VET1[X]);
         END;

  (****************** VETOR 2 ***********************)

     WRITE ('QUAL O TAMANHO DO VETOR 2 = ');
     READLN (M);

     FOR Y:= 1 TO M DO
         BEGIN
              WRITE ('VETOR 2 [ ',Y,' ] = ');
              READLN (VET2[Y]);
         END;

      TOTAL := N + M;

      X:= 1;
      Y:= 1;


      FOR Z:= 1 TO TOTAL DO
          BEGIN
               FEITO := TRUE;
               IF X > N THEN
                  BEGIN
                       FEITO := FALSE;
                  END
               ELSE
                   IF Y <= M THEN
                      BEGIN
                           IF VET1[X] > VET2[Y] THEN
                             BEGIN
                                  FEITO := FALSE;
                             END;
                      END;
               IF FEITO THEN
                  BEGIN
                       VET3[Z] := VET1[X];
                       X := X + 1;
                  END
               ELSE
                   BEGIN
                        VET3[Z] := VET2[Y];
                        Y := Y + 1;
                   END;
          END;


     FOR X := 1 TO TOTAL DO
         WRITELN(VET3[X]);

     READLN;


 (******************* METODO DA BOLHA ********************)



     LSUP := TOTAL;

     REPEAT

           BOLHA := 0;

           FOR X:= 1 TO LSUP-1 DO
           BEGIN
              IF VET3[X] > VET3[X+1] THEN
                 BEGIN
                      AUX := VET3[X];
                      VET3[X] := VET3[X+1];
                      VET3[X+1] := AUX;
                      BOLHA := X;
                 END;
            END;
           LSUP := BOLHA;
     UNTIL LSUP <= 1;



     FOR X := 1 TO TOTAL DO
         WRITELN(VET3[X]);

     READLN




END.













END.