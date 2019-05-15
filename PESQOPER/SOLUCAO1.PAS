Program RESOLUCAO;
Uses Crt;

Var
  RESTRICOES,VARIAVEIS,J,K,I,G,H,L,OP,VOLGA,COLUNA,LINHA   :BYTE;
  VET                                       :ARRAY[0..10,0..10] OF REAL;
  F,D,A,PRE                                 :REAL;
  X                                         :ARRAY[1..10,1..10] OF INTEGER;
  Q,BI,N10                                  :ARRAY[1..10] OF INTEGER;
  TECLA                                     :CHAR;
{   ************* VARIAVEIS*****************
      RESTRICOES    = NUMERO DE RESTRICOES
      VARIAVEIS    = NUMERO DE VARIAVEIS
      VET   = MATRIZ PRINCIPAL
      COLUNA= COLUNA Do PIVO
      LINHA = LINHA Do PIVO
    *****************************************}

{******** MOSTRANDo PADRONIZACAO ******** }
Procedure MOSTRA;
Begin
  Clrscr;
  K:=7;
  For I:=7 TO 15 Do
    Begin
      For H:=4 TO 15 Do
         Begin
           GotoXY(K,H);
           Write('³');
         End;
      K:=K+7;
    End;
  K:=6;
  For I:=6 TO 10 Do
    Begin
      For H:=1 TO 60 Do
        Begin
          GotoXY(H,K);
          Write('Ä');
        End;
        K:=K+2;
    End;
  J:=2; { COLUNA }
  K:=5; { LINHA  }
  For I:=0 TO RESTRICOES+1 Do
    Begin
      For H:=0 TO VARIAVEIS+RESTRICOES+1 Do
        Begin
          GotoXY(J,K);
           WriteLN(VET[H,I]:2:2);
          J:=J+7;
        End;
      J:=2;
      K:=K+2;
    End;
  TECLA:=READKEY;
End;

{******** ENTRADA DE DADOS ***********}
Procedure LERDADoS;
Begin
  CLRSCR;
(*  Write('NUMERO DE RESTRICOES=');
  Readln(RESTRICOES);       {Leitura Do numero de restricoes}
  Write('NUMERO DE VARIAVEIS =');
  Readln(VARIAVEIS); {leitura Do numero de vari reis}*)

  restricoes := 4;
  variaveis := 2;

{******************* H-COLUNA , I-LINHA *****************}
(*  For I:=1 TO RESTRICOES  Do
    Begin
      For H:=1 TO VARIAVEIS Do
        Begin
          Write('RESTRICAO ',I,' X',H,' COEFICIENTE=');
          Readln(X[H,I]);  {leitura Dos valores da matriz}
        End;
      Write('B',I,'=');
      Readln(BI[I]);
    End; *)


  x[1,1] := -10;
  x[2,1] := 15;

  x[1,2] := -1;
  x[2,2] := 5;

  x[1,3] := 1;
  x[2,3] := 1;

  x[1,4] := 1;
  x[2,4] := 0;

  bi[1] := 45;
  bi[2] := 20;
  bi[3] := 10;
  bi[4] := 8;

  Write('1 - MAX OU 2 - MINI ? ');
  Readln(OP);
  If (OP<>1) AND  (OP<>2) Then
     OP:=1;
 { For I:=1 TO VARIAVEIS Do
     Begin
       Write('X',I,' COEFICIENTE NA Q(X)=');
       Readln(Q[I]);
     End;}
  q[1] := 2;
  q[2] := 1;

  If OP=2 Then
     For I:=1 TO VARIAVEIS Do
       Q[I]:=Q[I] * -1;
 End;
  {**********FIM DA LEITURA DoS DADoS **************}

{************* PADRONIZAR *************************}
Procedure PADRONIZA;
VAR
  R1:BYTE;
Begin
{********H= COLUNA VARIAVEIS, I= LINHA  RESTRICOES**************}
For I:=1 TO 10 Do
  N10[I]:=0;
{***** INICIALIZANDo *****}
  For H:=0 TO 10 Do
    For I:=0 TO 10 Do
      Begin
        VET[H,I]:=0;
      End;

{ COLOCANDo COEFICIENTE DAS VARIAVEIS }
  For H:=1 TO VARIAVEIS Do
     For I:=1 TO RESTRICOES Do
        Begin
          VET[H,I]:=X[H,I]
        End;

{*******   INICIALIZANDo PRIMEIRA POSICAO  **** }
  VET[0,0]:=0;

{********   COLOCANDo VALOR DA BASE ******* }
  R1:=VARIAVEIS;
  For I:=1 TO RESTRICOES Do
    Begin
      R1:=R1+1;
      VET[0,I]:=R1;
    End;

{**** COLOCANDo VALOR DA LINHA ZERO ***}
  For H:=1 TO VARIAVEIS+RESTRICOES Do
    VET[H,0]:=H;
{***** MONTANDo Q(X) ******}
  For H:=1 TO VARIAVEIS Do
    Begin
      If Q[H]=0 Then
         Begin
           N10[H]:=H;
         End;
      VET[H,RESTRICOES+1]:=Q[H];
    End;
 {**** COLOCANDo VOLGA ****}
  For H:=VARIAVEIS+1 TO VARIAVEIS+RESTRICOES Do
    For I:=1 TO RESTRICOES Do
      Begin
        If VET[0,I]=VET[H,0] Then
           VET[H,I]:=1
        ELSE
           VET[H,I]:=0;
      End;

{****MONTANDo Bi ***********}
  R1:=VARIAVEIS+RESTRICOES+1;
  For I:=1 TO RESTRICOES Do
    Begin
      VET[R1,I]:=BI[I];
    End;
  VET[R1,0]:=0;

{**** MOSTRANDo A PADRONIZACAO ********* }

  MOSTRA;

End;
{*********** FIM DA PADRONIZACAO *****************}
{
*********************************************************************
*                                                                   *
*     FINAL Do PROBLEMA                                             *
*                                                                   *
*********************************************************************
}
Procedure FINAL;
VAR
  VAR1:BYTE;
Begin
  CLRSCR;
  For I:=02 TO 78 Do
    Begin
      GotoXY(I,10);
      Write('*');
    End;
  GotoXY(22,12);
  WriteLN('    SOLUCAO   ');
  For I:=1 TO VARIAVEIS+RESTRICOES Do
    Begin
      VAR1:=1;
        For  H:=1 TO RESTRICOES Do
          Begin
            If (VET[0,H]=VET[0,I]) AND (VET[0,I]<= VARIAVEIS)   Then
               Begin
                 WriteLN('X',VET[0,I]:1:0, '=',VET[VARIAVEIS+RESTRICOES+1,I]:2:2);
                 H:=RESTRICOES;
                 VAR1:=0;
               End;
          End;
      If (VAR1=1) AND (VET[0,I]<=VARIAVEIS) AND (VET[0,I]<>0)Then
         WriteLN('X',VET[0,I]:1:0,'=',0);
    End;
  Write('Q(X)= ',VET[VARIAVEIS+RESTRICOES+1,RESTRICOES+1]:2:2);
  TECLA:=READKEY;
  HALT;
End;

{
**************  FIM Do FINAL *************************************}

{
************  CALCULANDo O PIVOTIAMENTO ******************************
}
Procedure CALCULO;
VAR
  VALOR : REAL;
  AUX : ARRAY[0..10,0..10] OF REAL;
Begin
{***** DIVIDINDo A LINHA Do PIVO PELO PIVO ****}
  VET[0,LINHA]:=VET[COLUNA,0];
  VALOR:=VET[COLUNA,LINHA];
  For H:=1 TO VARIAVEIS+RESTRICOES+1 Do
    VET[H,LINHA]:=VET[H,LINHA]/VALOR;

  For I:=0 TO 10 Do
    For H:=0 TO 10 Do
      AUX[H,I]:=VET[H,I];

  For I:=1 TO RESTRICOES+1 Do
    Begin
      If I<>LINHA Then
         For H:=1 TO VARIAVEIS+RESTRICOES+1 Do
           Begin
             VET[H,I]:=AUX[H,I]-(AUX[COLUNA,I]*AUX[H,LINHA])
           End;
    End;
  MOSTRA;
End;

{
************ PROCERANDo O MENOR NA COLUNA Do MENOR_QX *****
*************   OBJETIVA ENCONTRAR A LINHA Do PIVO     ****
}
Procedure MINIMO;
VAR
  VERDADE:BOOLEAN;
  I2             :BYTE;
  VALOR,VMINIMO  :REAL;
Begin
  VMINIMO:=0;
  VERDADE:=FALSE;
  I2:=0;
  For I:=1 TO RESTRICOES Do
    Begin
      If 0< VET[COLUNA,I] Then
         Begin
           VERDADE:=TRUE;
           If I2=0 Then
              Begin
                I2:=1;
                VMINIMO:=VET[VARIAVEIS+RESTRICOES+1,I]/VET[COLUNA,I];
                LINHA:=I;
              End;
           VALOR:=VET[VARIAVEIS+RESTRICOES+1,I]/VET[COLUNA,I];
           If VMINIMO>VALOR  Then
              Begin
                VMINIMO:=VALOR;
                LINHA:=I;
              End;
         End;
    End;
  If NOT VERDADE Then
     Begin
       Write('************* SEM SOLUCAO **************');
       HALT;
     End;
  GotoXY(20,21);
  Write('VMINIMO=',VMINIMO:2:2,'  LINHA=',LINHA);
  TECLA:=READKEY;
End;

{
************ PROCURA MENOR EM Q(X), VET[VERIAVEL,RESTRICOES+1] ************
************  ENCONTRA A COLUNA COM O MENOR VALOR      ************
 }
Procedure MENOR_QX;
VAR
  MENOR:REAL;
  VERDADE,VERDADE2:BOOLEAN;
Begin
  MENOR:=0;
  VERDADE2:=TRUE;
  VERDADE:=TRUE;
  For H:=1 TO RESTRICOES+2 Do
    Begin
      VERDADE:=TRUE;
      For I:=1 TO RESTRICOES Do
        If VET[H,0]=VET[0,I] Then
           VERDADE:=FALSE;
        If VERDADE Then
           Begin
             If MENOR>VET[H,RESTRICOES+1] Then
                 Begin
                   VERDADE2:=FALSE;
                   MENOR:=VET[H,RESTRICOES+1];
                   COLUNA:=H;
                 End;
           End;
    End;
  If VERDADE2 Then
     Begin
       For H:=1 TO RESTRICOES+2 Do
         Begin
           VERDADE:=TRUE;
           For I:=1 TO RESTRICOES Do
             If VET[H,0]=VET[0,I] Then
                VERDADE:=FALSE;
           If VERDADE Then
              Begin
                PRE:=10000000;
                VET[H,RESTRICOES+1]:=INT((VET[H,RESTRICOES+1])*PRE)/PRE;
                If 0=VET[H,RESTRICOES+1] Then
                   Begin
                     GotoXY(22,22);
                     Write('INFITAS SOLUCOES');
                     TECLA:=READKEY;
                     FINAL;
                     HALT;
                   End;
              End;
         End;
     End;
  If MENOR=0 Then
     FINAL;

  GotoXY(20,20);
  Write('MENOR= ' , MENOR:2:2,' COLUNA=',COLUNA );
  TECLA:=READKEY;
End;

Begin
  LERDADoS;
  PADRONIZA;
  L:=1;
  WHILE  L=1 Do
    Begin
      MENOR_QX;
      MINIMO;
      CALCULO;
    End;
End.
{************ FIM ******************}
