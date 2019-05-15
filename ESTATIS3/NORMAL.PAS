(*************************************************************************)
(*    FUNCAO PARA GERAR NORMAL  (0,1) A PARTIR DE 12 UNIFORMES           *)
(*************************************************************************)
FUNCTION NORM_12U : REAL;
VAR
   VALOR   : REAL;
BEGIN
     VALOR := 0;
     FOR I := 1 TO 12 DO
         VALOR := VALOR + RADOM;
     NORM_12U := VALOR - 6;
END;
