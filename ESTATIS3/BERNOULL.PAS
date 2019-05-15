(*************************************************************************)
(*        FUNCAO PARA GERAR UM VALOR DE BERNOLLI COM PARAMETRO P         *)
(*************************************************************************)

FUNCTION BERNOULLI ( PE : REAL ) : INTEGER;
BEGIN
     IF (PE <= 0) OR (PE >= 1) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O PARAMETRO DA BERNOULLI');
             WRITELN ('     DEVE  ESTAR EM (0,1).');
             HALT;
        END
     ELSE
         IF RANDOM <= PE THEN
            BERNOULLI := 1
         ELSE
             BERNOULLI := 0;
END;



