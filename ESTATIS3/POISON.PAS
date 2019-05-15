(*************************************************************************)
(*    FUNCAO PARA GERAR UM VALOR DE POISSON COM PARAMETRO LAMBDA         *)
(*************************************************************************)

FUNCTION POISON ( LAMBDA : REAL ) : INTEGER;
VAR
   SOMA              : INTEGER;
   PRODUTO,COMPARA   : REAL;
BEGIN
     IF (LAMBDA <= 0) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O PARAMETRO DA POISSON ');
             WRITELN ('DEVE SER MAIOR DO QUE 0');
             HALT;
        END
     ELSE
         BEGIN
              COMPARA := EXP ( - LAMBDA);
              PRODUTO := 1;
              SOMA := -1;
              REPEAT
                    PRODUTO := PRODUTO * RANDOM;
                    SOMA := SOMA + 1;
              UNTIL PRODUTO <= COMPARA;
              POISSON := SOMA;
         END;
END;
