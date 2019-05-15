(*************************************************************************)
(*        FUNCAO PARA GERAR UM VALOR DE BINOMIAL  (ENE, PE)              *)
(*************************************************************************)
FUNCTION BINOMIAL (ENE : INTEGER; PE : REAL) : INTEGER;
VAR
   I,VALOR  :INTEGER;
BEGIN
     IF ( ENE <= 0) THEN
        BEGIN
             CLRSCR;
             WRITELN ('O NUMERO DE TENTATIVAS DA ');
             WRITELN ('  BINOMIAL DEVE SER > 0 .');
             HALT;
        END
     ELSE
         BEGIN
              VALOR := 0;
              FOR I :=1 TO ENE DO
                  VALOR := VALOR + BERNOULLI (PE);
         END;
     BINOMIAL := VALOR;
END;