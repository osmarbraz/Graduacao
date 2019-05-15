{  Unisul - Universidade do Sul de Santa Catarina
   Trabalho de Pesquiza Operacional}

Program SIMPLEX_01;
USES CRT;
const
  mold1:string = chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+chr(205)+chr(200);
  mold2:string = chr(218)+chr(196)+chr(191)+chr(179)+chr(217)+chr(196)+chr(192);


 VAR

     RE,VA,J,K,I,G,H,L,OP,VOLGA,COLUNA,LINHA   :BYTE;
     VET                                       :ARRAY[0..10,0..10] OF REAL;
     F,D,A,PRE                                 :REAL;
     X                                         :ARRAY[1..10,1..10] OF INTEGER;
     Q,BI,N10                                  :ARRAY[1..10] OF INTEGER;
     TECLA                                     :CHAR;
{   ************* VARIAVEIS*****************
      RE    = NUMERO DE RESTRICOES
      VA    = NUMERO DE VARIAVEIS
      VET   = MATRIZ PRINCIPAL
      COLUNA= COLUNA DO PIVO
      LINHA = LINHA DO PIVO
    *****************************************}
  procedure escreve(c,l:byte;s:string);
  begin
    gotoxy(c,l);
    write(s);
  end;


  procedure moldura(x1,y1,x2,y2:byte;m:string);
  var
    i:byte;
  begin
   escreve(x1,y1,m[1]);
   for i:=(x1+1) to (x2-1) do
     begin
       escreve(i,y1,m[2]);
       escreve(i,y2,m[2]);
     end;
   escreve(x2,x1,m[3]);
   for i:=(y1+1) to (y2-1) do
     begin
       escreve(x2,i,m[4]);
       escreve(x1,i,m[4]);
     end;
   escreve(x2,y2,m[5]);
   escreve(x1,y2,m[7]);
  end;

{******** MOSTRANDO PADRONIZACAO ******** }
 PROCEDURE MOSTRA;
 BEGIN
      CLRSCR;
      K:=7;
  FOR I:=7 TO 15 DO
   BEGIN
    FOR H:=4 TO 15 DO
      BEGIN
         GOTOXY(K,H);
         WRITE('³');
        END;
        K:=K+7;
    END;
     K:=6;
   FOR I:=6 TO 10 DO
   BEGIN
    FOR H:=1 TO 60 DO
      BEGIN
         GOTOXY(H,K);
         WRITE('Ä');
        END;
        K:=K+2;
    END;
          J:=2; { COLUNA }
          K:=5; { LINHA  }
    FOR I:=0 TO RE+1 DO
     BEGIN
      FOR H:=0 TO VA+RE+1 DO
         BEGIN
          GOTOXY(J,K);
          WRITELN(VET[H,I]:2:2);
          J:=J+7;
         END;
         J:=2;
         K:=K+2;
       END;
    TECLA:=READKEY;
 END;

{******** ENTRADA DE DADOS ***********}
PROCEDURE LERDADOS;
 VAR
  LIN, COL : BYTE;

 BEGIN
     CLRSCR;
       MOLDURA (1,1,79,25,MOLD2);
       MOLDURA (15,5,65,20,MOLD2);
       GOTOXY(20,10);
       WRITE('Quantas Restricoes = ');
       READLN(RE);
       GOTOXY(20,11);
       WRITE('Quantas Variaveis  = ');
       READLN(VA);
       CLRSCR;
   {******************* H-COLUNA , I-LINHA *****************}
     FOR I:=1 TO RE  DO
      BEGIN
       MOLDURA (1,1,79,25,MOLD2);
       LIN := 5;
       COL := 10;
       FOR H:=1 TO VA DO
         BEGIN
          GOTOXY(COL,LIN);
          WRITE('Restricao ',I,' X ',H,' Coeficiente = ');
          READLN(X[H,I]);
          LIN := LIN + 1;
        END;
           GOTOXY(COL,LIN);
           WRITE('Valor de B',I,' = ');
           READLN(BI[I]);
           CLRSCR;
       END;

      MOLDURA (1,1,79,25,MOLD2);
      GOTOXY(10,5);
      WRITE('Escolha : (1) - Para Maximizar ou (2) - Para Minimizar.');
      READLN(OP);

      IF (OP<>1) AND  (OP<>2) THEN
                OP:=1;

       LIN := 6;
       COL := 10;
       FOR I:=1 TO VA DO
         BEGIN
            GOTOXY(COL,LIN);
            WRITE('Q(x) Coeficiente de ' , 'X',I,' = ' );
            READLN(Q[I]);
            LIN := LIN + 1
         END;

    IF OP=1 THEN
          FOR I:=1 TO VA DO
                 Q[I]:=Q[I] * -1;

 END;
  {**********FIM DA LEITURA DOS DADOS **************}

{************* PADRONIZAR *************************}
PROCEDURE PADRONIZA;
VAR
    R1:BYTE;
BEGIN
   {********H= COLUNA VARIAVEIS, I= LINHA  RESTRICOES**************}
   FOR I:=1 TO 10 DO
     N10[I]:=0;

  {***** INICIALIZANDO *****}
    FOR H:=0 TO 10 DO
      FOR I:=0 TO 10 DO
        BEGIN
            VET[H,I]:=0;
         END;

  { COLOCANDO COEFICIENTE DAS VARIAVEIS }
    FOR H:=1 TO VA DO
      FOR I:=1 TO RE DO
        BEGIN
            VET[H,I]:=X[H,I]
         END;
 {  *******   INICIALIZANDO PRIMEIRA POSICAO  **** }
        VET[0,0]:=0;


  {********   COLOCAN VALOR DA BASE ******* }
        R1:=VA;
    FOR I:=1 TO RE DO
      BEGIN
         R1:=R1+1;
         VET[0,I]:=R1;
       END;

  { **** COLOCANDO VALOR DA LINHA ZERO ***}
      FOR H:=1 TO VA+RE DO
           VET[H,0]:=H;

      {***** MONTANDO Q(X) ******}
       FOR H:=1 TO VA DO
        BEGIN
            IF Q[H]=0 THEN
            BEGIN
               N10[H]:=H;
            END;
            VET[H,RE+1]:=Q[H];
        END;
      {**** COLOCANDO VOLGA ****}
        FOR H:=VA+1 TO VA+RE DO
               FOR I:=1 TO RE DO
                 BEGIN
                  IF VET[0,I]=VET[H,0] THEN
                    VET[H,I]:=1
                  ELSE
                     VET[H,I]:=0;
                  END;

      {****MONTANDO Bi ***********}

        R1:=VA+RE+1;
       FOR I:=1 TO RE DO
         BEGIN
          VET[R1,I]:=BI[I];
         END;

         VET[R1,0]:=0;


    {**** MOSTRANDO A PADRONIZACAO ********* }

{      MOSTRA;}



END;
{*********** FIM DA PADRONIZACAO *****************}
{
*********************************************************************
*                                                                   *
*     FINAL DO PROBLEMA                                             *
*                                                                   *
*********************************************************************
}
PROCEDURE FINAL;
VAR
   VAR1:BYTE;
BEGIN

     CLRSCR;
     GOTOXY(22,12);
     WRITELN('    Solucao   ');
     FOR I:=1 TO VA+RE DO
      BEGIN
        VAR1:=1;
           FOR  H:=1 TO RE DO
              BEGIN
                 IF (VET[0,H]=VET[0,I]) AND (VET[0,I]<= VA)   THEN
                    BEGIN
                       WRITELN('X',VET[0,I]:1:0, '=',VET[VA+RE+1,I]:2:2);
                        H:=RE;
                        VAR1:=0;
                     END;
               END;
                    IF (VAR1=1) AND (VET[0,I]<=VA) AND (VET[0,I]<>0)THEN
                     WRITELN('X',VET[0,I]:1:0,'=',0);
        END;

        WRITE('Q(X)= ',VET[VA+RE+1,RE+1]:2:2);
        TECLA:=READKEY;
        HALT;
END;

{
**************  FIM DO FINAL *************************************}

{
************  CALCULANDO O PIVOTIAMENTO ******************************
}
PROCEDURE CALCULO;
   VAR
      VALOR:REAL;
      AUX:ARRAY[0..10,0..10] OF REAL;
BEGIN
  {***** DIVIDINDO A LINHA DO PIVO PELO PIVO ****}
     VET[0,LINHA]:=VET[COLUNA,0];
        VALOR:=VET[COLUNA,LINHA];
   FOR H:=1 TO VA+RE+1 DO
            VET[H,LINHA]:=VET[H,LINHA]/VALOR;

    FOR I:=0 TO 10 DO
     FOR H:=0 TO 10 DO
       AUX[H,I]:=VET[H,I];


        FOR I:=1 TO RE+1 DO
         BEGIN
            IF I<>LINHA THEN
              FOR H:=1 TO VA+RE+1 DO
               BEGIN
                   VET[H,I]:=AUX[H,I]-(AUX[COLUNA,I]*AUX[H,LINHA])
               END;
         END;
{           MOSTRA;}

END;

{
************ PROCERANDO O MENOR NA COLUNA DO MENOR_QX *****
*************   OBJETIVA ENCONTRAR A LINHA DO PIVO     ****
}
PROCEDURE MINIMO;
VAR
   VERDADE:BOOLEAN;
   I2             :BYTE;
   VALOR,VMINIMO  :REAL;
BEGIN
     VMINIMO:=0;
     VERDADE:=FALSE;
     I2:=0;


     FOR I:=1 TO RE DO
       BEGIN

           IF 0< VET[COLUNA,I] THEN
            BEGIN
                 VERDADE:=TRUE;
                 IF I2=0 THEN
                    BEGIN
                      I2:=1;
                      VMINIMO:=VET[VA+RE+1,I]/VET[COLUNA,I];
                      LINHA:=I;
                    END;

                      VALOR:=VET[VA+RE+1,I]/VET[COLUNA,I];
                        IF VMINIMO>VALOR  THEN
                         BEGIN
                           VMINIMO:=VALOR;
                           LINHA:=I;
                         END;
             END;

       END;
          IF NOT VERDADE THEN
           BEGIN
             WRITE('************* SEM SOLUCAO **************');
             HALT;
           END;

          GOTOXY(20,21);
          WRITE('VMINIMO=',VMINIMO:2:2,'  LINHA=',LINHA);

          TECLA:=READKEY;

END;



{
************ PROCURA MENOR EM Q(X), VET[VERIAVEL,RE+1] ************
************  ENCONTRA A COLUNA COM O MENOR VALOR      ************
 }
PROCEDURE MENOR_QX;
VAR
   MENOR:REAL;
   VERDADE,VERDADE2:BOOLEAN;
BEGIN
    MENOR:=0;
    VERDADE2:=TRUE;
    VERDADE:=TRUE;
    FOR H:=1 TO RE+2 DO
      BEGIN
        VERDADE:=TRUE;
           FOR I:=1 TO RE DO
              IF VET[H,0]=VET[0,I] THEN
                 VERDADE:=FALSE;

           IF VERDADE THEN
             BEGIN

               IF  MENOR>VET[H,RE+1] THEN
                 BEGIN
                    VERDADE2:=FALSE;
                    MENOR:=VET[H,RE+1];
                    COLUNA:=H;
                  END;
              END;

      END;

        IF VERDADE2 THEN
        BEGIN
          FOR H:=1 TO RE+2 DO
           BEGIN
             VERDADE:=TRUE;
                FOR I:=1 TO RE DO
                   IF VET[H,0]=VET[0,I] THEN
                       VERDADE:=FALSE;
                   IF VERDADE THEN
                     BEGIN
                            PRE:=10000000;
                            VET[H,RE+1]:=INT((VET[H,RE+1])*PRE)/PRE;

                       IF 0=VET[H,RE+1] THEN
                         BEGIN
                             GOTOXY(22,22);
                             WRITE('INFITAS SOLUCOES');
                             TECLA:=READKEY;
                             FINAL;
                             HALT;
                          END;
                    END;
               END;
            END;

       IF MENOR=0 THEN
           FINAL;


      GOTOXY(20,20);
      WRITE('MENOR= ' , MENOR:2:2,' COLUNA=',COLUNA );
      TECLA:=READKEY;

END;


BEGIN
  LERDADOS;
  PADRONIZA;
  L:=1;
 WHILE  L=1 DO
 BEGIN
  MENOR_QX;
  MINIMO;
  CALCULO;
 END;

END.