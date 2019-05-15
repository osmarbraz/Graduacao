(**************************************************************************)
(*      PROCEDIMENTO PARA GERAR NORMAL (0,1) - BOX MULLER MARSAGLIA       *)
(*    NO PROGRAMA PRINCIPAL DEVE-SE DECLARADO                             *)
(*     TYPE                                                               *)
(*         VETDOIS : ARRAY [1..2] OF REAL                                 *)
(**************************************************************************)

PROCEDURE NORM_B_M ( VAR NORM_2 : VET DOIS);
VAR
   V_UM, V_DOIS, RAIZ, ESSE  : REAL;
BEGIN
     REPEAT
           V_UM := 2 * RANDOM -1;
           V_DOIS := 2 * RANDOM -1;
           ESSE := V_UM * V_UM + V_DOIS *V_DOIS;
     UNTIL ESSE < 1;
     RAIZ := SQRT ( - 2 * LN (ESSE) / ESSE);
     NORM_2[1] := V_UM * RAIZ;
     NORM_2[2] := V_DOIS * RAIZ;
END;


