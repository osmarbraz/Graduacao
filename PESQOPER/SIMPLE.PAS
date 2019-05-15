Program Fase_1;
Uses Crt;
TYPE
  TAB = ARRAY [1..10] OF REAL;
VAR
  TABLEAU : ARRAY [1..10] OF TAB;
  BI      : ARRAY [1..10] OF REAL;
  VB      : ARRAY [1..10] OF INTEGER;
  I,J,K   : INTEGER;
  VARIAVEIS,RESTRICOES,LIN,COL : BYTE;
  MENOR   : REAL;
  INDICE_MENOR : BYTE;
  QUOCIENTE  : REAL;
  LINHA_PIVO : INTEGER;

{************************************************************************}

FUNCTION ESTA_NA_BASE (NUM : INTEGER) : BOOLEAN;
VAR
  ACHOU_NA_BASE : BOOLEAN;
  Z             : BYTE;
BEGIN
  Z := 1;
  ACHOU_NA_BASE := FALSE;
  WHILE ((Z <= RESTRICOES) AND NOT(ACHOU_NA_BASE)) DO
  BEGIN
    IF NUM = VB[Z] THEN
       ACHOU_NA_BASE := TRUE
    ELSE
       INC(Z);
  END;
  IF ACHOU_NA_BASE THEN
    ESTA_NA_BASE := TRUE
  ELSE
    ESTA_NA_BASE := FALSE;
END;

{************************************************************************}

PROCEDURE PASSO_5 (POSITIVO_VB : REAL);
BEGIN
  IF ((BI[I]/POSITIVO_VB) < QUOCIENTE) THEN
  BEGIN
    QUOCIENTE  := BI[I]/POSITIVO_VB;
    LINHA_PIVO := I;
  END;
END;

{************************************************************************}

PROCEDURE PASSO_4 (J : INTEGER); { J = INDICE_MENOR }
VAR
  EXISTE : BOOLEAN;
BEGIN
  K := J;
  EXISTE := FALSE;
  I := 1;
  QUOCIENTE := 9999;
  REPEAT
  IF TABLEAU[I][K] > 0 THEN
  BEGIN
    EXISTE := TRUE;
    PASSO_5(TABLEAU[I][K]);
    IF EXISTE = FALSE THEN
      WRITE('SOLUCAO IMPOSSIVEL = Q(x)= -oo');
  END;
  INC(I);
  UNTIL I > RESTRICOES;
END;

{************************************************************************}

PROCEDURE SUBSTITUI_VB (ENTRA, SAI : INTEGER);
BEGIN
   VB[SAI] := ENTRA;
END;

{************************************************************************}

PROCEDURE PIVOTEAMENTO;
VAR
  PIVO : REAL;
  L,M  : INTEGER;
  INICIO : BOOLEAN;
  FATOR : REAL;
BEGIN
  PIVO := TABLEAU[LINHA_PIVO,INDICE_MENOR];
  L    := 1;

{********* DIVIDINDO OS ELEMENTOS DA LINHA DO PIVO PELO PIVO ***********}

  REPEAT
    TABLEAU[LINHA_PIVO,L] := TABLEAU[LINHA_PIVO,L]/PIVO;
    INC(L);
  UNTIL L > RESTRICOES + VARIAVEIS;
  BI[LINHA_PIVO] := BI[LINHA_PIVO]/PIVO;

{************************************************************************}
  L := 1;
  INICIO := TRUE;
  REPEAT
    IF L <> LINHA_PIVO THEN
    BEGIN
     FOR M := 1 TO RESTRICOES + VARIAVEIS DO
     BEGIN
       IF INICIO THEN
       BEGIN
         FATOR  := TABLEAU[L,M];
         INICIO := FALSE;
         TABLEAU[L,M] := (TABLEAU[LINHA_PIVO,M] * (FATOR * -1))
                        + TABLEAU[L,M];
       END
       ELSE
       TABLEAU[L,M] := (TABLEAU[LINHA_PIVO,M] * (FATOR * -1))
                        + TABLEAU[L,M];
       END;
       BI[L] := (BI[LINHA_PIVO] * (FATOR * -1)) + BI[L];
     END;
       INC(L);
       INICIO := TRUE;
  UNTIL L > RESTRICOES + 1;
END;
{************************************************************************}
     {
BEGIN
  CLRSCR;
  gotoxy (10,05);
  Write('QUANTIDADE DE VARIAVEIS : ');
  Readln(Variaveis);
  Write('QUANTIDADE DE RESTRICOES COM SINAL MENOR IGUAL ( <= ) : ');
  Readln(Restricoes);
  For I := 1 to Restricoes + 1 do
  Begin
   col := 8;
   For J := 1 to Variaveis+Restricoes do
   Begin
     gotoxy(col,lin);
     Readln(TABLEAU[I][J]);
     Inc(col,6);
   End;
   GotoXY(col+3,lin);
   ReadLn(Bi[i]);
   Inc(Lin);
End;}

TABLEAU[1][1] := -10;
TABLEAU[1][2] := 15;
TABLEAU[1][3] := 1;
TABLEAU[1][4] := 0;
TABLEAU[1][5] := 0;
TABLEAU[1][6] := 0;
TABLEAU[2][1] := -1;
TABLEAU[2][2] := 5;
TABLEAU[2][3] := 0;
TABLEAU[2][4] := 1;
TABLEAU[2][5] := 0;
TABLEAU[2][6] := 0;
TABLEAU[3][1] := 1;
TABLEAU[3][2] := 1;
TABLEAU[3][3] := 0;
TABLEAU[3][4] := 0;
TABLEAU[3][5] := 1;
TABLEAU[3][6] := 0;
TABLEAU[4][1] := 1;
TABLEAU[4][2] := 0;
TABLEAU[4][3] := 0;
TABLEAU[4][4] := 0;
TABLEAU[4][5] := 0;
TABLEAU[4][6] := 1;
TABLEAU[5][1] := -2;
TABLEAU[5][2] := -1;
TABLEAU[5][3] := 0;
TABLEAU[5][4] := 0;
TABLEAU[5][5] := 0;
TABLEAU[5][6] := 0;
BI[1] := 45;
BI[2] := 20;
BI[3] := 10;
BI[4] := 8;
BI[5] := 0;

{********** TABLEAU [RESTRICOES+1] CONTEM A FUNCAO OBJETIVO ************}

{******************* MONTAGEM DA BASE DE VARIAVEIS *********************}

RESTRICOES := 4;
VARIAVEIS  := 2;

J := 1;
FOR I := VARIAVEIS+1 TO RESTRICOES+VARIAVEIS DO
BEGIN
  VB[J] := I;
  INC(J);
END;

{************************************************************************}

{ TESTA SE DENTRE OS COEFICIENTES DAS VARIAVEIS QUE NAO ESTAO NA
  BASE EXISTEM VALORES MENORES QUE ZERO}

{************************************************************************}

  J := 1;
  I := 1;
  MENOR := 9999;
  REPEAT
    BEGIN
    IF NOT(ESTA_NA_BASE(J)) THEN
    BEGIN
      FOR I := 1 TO RESTRICOES DO
       IF TABLEAU[J][I] < MENOR THEN
       BEGIN
         MENOR        := TABLEAU[J][I];
         INDICE_MENOR := J;
         WRITE('MENOR >>> ',MENOR:2:0,+'  #  ',INDICE_MENOR);
       END;
    END;
    INC(J);
  END;
  UNTIL J = VARIAVEIS+RESTRICOES;
  PASSO_4(INDICE_MENOR);
  SUBSTITUI_VB(INDICE_MENOR,LINHA_PIVO);
  PIVOTEAMENTO;
END.


