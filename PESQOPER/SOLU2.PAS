Program RESOLUCAO;
USES CRT;

 VAR

     RE,VA,J,I,G,H,K,L,L1,OP,VOLGA,COLUNA,LINHA,V12,V13,V14,V15,B1:BYTE;
     VET                                            :ARRAY[0..30,0..30] OF REAL;
     F,D,A,PRE                                      :REAL;
     X                                              :ARRAY[1..30,1..30] OF REAL;
     Q,BI,N10                                       :ARRAY[1..30] OF REAL;
     TECLA                                          :CHAR;
     SINAL,ART                                      :ARRAY[1..30] OF BYTE;
{   ************* VARIAVEIS*****************
      SINAL = SINAL DE = > <
      RE    = NUMERO DE RESTRICOES
      VA    = NUMERO DE VARIAVEIS
      VET   = MATRIZ PRINCIPAL
      COLUNA= COLUNA DO PIVO
      LINHA = LINHA DO PIVO
      V13   = SOMA AS VARIAVEIS ARTIFICIAIS
      ART   = GARDA ASVARIAVEIS DE ARTIVICIAIS
      V14   = SOMA O SINAL DE = IGUAL
      V15   =  1 EXISTE Q(X) ARTIFICIAL 0 NAO
    *****************************************}

{******** MOSTRANDO PADRONIZACAO ******** }
 PROCEDURE MOSTRA;
 BEGIN
      CLRSCR;
   WRITELN('VOLGA......=',VOLGA);
   WRITELN('RESTRICOES.=',RE);
   WRITELN('VERIAVEIS..=',VA);
   WRITELN('ARTIFICIAIS=',V13);
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
     IF V13<>0 THEN
      BEGIN
        L:=V13;
       END
     ELSE
       BEGIN
        L:=0;
       END;
    IF V15<>0 THEN
       G:=2
     ELSE
       G:=1;

    FOR I:=0 TO RE+G DO {LINHA}
     BEGIN
      FOR H:=0 TO VA+VOLGA+L+1 DO   {COLUNA}
         BEGIN
          GOTOXY(J,K);
          WRITELN(VET[H,I]:2:2);
          J:=J+7;
         END;
         J:=2;
         K:=K+2;
       END;
        J:=20;
        K:=50;
   {MOSTRANDO VARIAVEIS ARTIFICIAIS}
    IF V13<>0 THEN
      FOR I:=1 TO 30 DO
       BEGIN
        IF ART[I]<>0 THEN
        BEGIN
         GOTOXY(K,J);
         WRITELN(' VARIAVEL ARTIFICIAL ',I,'=',ART[I]);
          J:=J+1;
         END;
        END;
    WRITELN('TECLE ENTER');
    TECLA:=READKEY;
END;

{******** ENTRADA DE DADOS ***********}
PROCEDURE LERDADOS;
 BEGIN
     CLRSCR;
       WRITE('NUMERO DE RESTRICOES=');
       READLN(RE);
       WRITE('NUMERO DE VARIAVEIS =');
       READLN(VA);
   {******************* H-COLUNA , I-LINHA *****************}
     FOR I:=1 TO RE  DO   { RESTRICOES I}
      BEGIN
       FOR H:=1 TO VA DO  { VARIAVEIS  H}
         BEGIN
          WRITE('RESTRICAO ',I,' X',H,' COEFICIENTE=');
          READLN(X[H,I]);
        END;
           WRITE('B',I,'=');
           READLN(BI[I]);
           V12:=0;
         WHILE V12=0 DO {ENQUANTO DEFESA PARA SINAL}
          BEGIN
           WRITE('1 <  2 >  3 =  OPCAO=');
           READLN(SINAL[I]);
           IF (SINAL[I]=1)OR(SINAL[I]=2)OR(SINAL[I]=3) THEN
                V12:=1;
              { SOMANDO VARIAVEL ARTIFICIAL}
             IF (SINAL[I]<>1) THEN{<}
              BEGIN{30}
               IF (SINAL[I]=2) THEN  {>}
                  IF BI[I]<>0 THEN
                     V13:=V13+1;
               IF SINAL[I]=3 THEN   {=}
                  V13:=V13+1;
               END;{30}
                  
             IF SINAL[I]=3 THEN { SOMANDO RESTRICAO DE IGUALDADE }
                V14:=V14+1;
             IF (SINAL[I]=1) OR (SINAL[I]=2) THEN
                VOLGA:=VOLGA+1;
          END;     { FIM DEFESA DE SINAL}
       END;


      WRITE('1 - MAX OU 2 - MINI ? ');
      READLN(OP);

      IF (OP<>1) AND  (OP<>2) THEN
                OP:=1;

       FOR I:=1 TO VA DO
         BEGIN
            WRITE('X',I,' COEFICIENTE NA Q(X)=');
            READLN(Q[I]);
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
   FOR I:=1 TO 30 DO
    BEGIN
      N10[I]:=0;
      ART[I]:=0;
    END;
  {***** INICIALIZANDO *****}
    FOR H:=0 TO 30 DO
      FOR I:=0 TO 30 DO
        BEGIN
            VET[H,I]:=0;
         END;

                  L:=0;
  { COLOCANDO COEFICIENTE DAS VARIAVEIS }
    FOR H:=1 TO VA DO
      FOR I:=1 TO RE DO
        BEGIN
          IF ((SINAL[I]=3)AND(BI[I]<0))OR((SINAL[I]=2)AND(BI[I]=0)) THEN
           BEGIN{2}
            VET[H,I]:=X[H,I]*-1;
           END{2}
          ELSE
            VET[H,I]:=X[H,I];
         END;

 {  *******   INICIALIZANDO PRIMEIRA POSICAO  **** }
        VET[0,0]:=0;
         R1:=0;
  { ****VENDO NUMERO DE VARIAVEIS DE VOLGA ***}
    IF V13<>0 THEN
      BEGIN{61}
        R1:=VA;
       FOR I:=1 TO RE DO
        BEGIN
         IF SINAL[I]<>3 THEN  { = }
            R1:=R1+1;
         END;


    { VARIAVEIS ARTIFICIAIS ***}
       FOR I:=1 TO V13 DO
        BEGIN
            R1:=R1+1;
           ART[I]:=R1;
         END;
    END;{61}
  {********COLOCANDO VALOR DA BASE******* }
        R1:=VA+1;
        H:=0;
    FOR I:=1 TO RE DO  {LINHA}
      BEGIN
         IF SINAL[I]<>1 THEN {<}
          BEGIN
               H:=H+1;
            IF ART[H]<>0 THEN
               VET[0,I]:=ART[H]
             ELSE
                BEGIN
                    VET[0,I]:=R1;
                    R1:=R1+1;
                END;
           END
           ELSE
            BEGIN
              VET[0,I]:=R1;
              R1:=R1+1;
            END;
       END;


  { *** COLOCANDO VALOR DA LINHA ZERO ***}
      FOR H:=1 TO VA+VOLGA+V13 DO {COLUNA}
           VET[H,0]:=H;

        {***** MONTANDO Q(X) ARTIFICIAL ******}
    IF V13<>0 THEN
     BEGIN{62}
       FOR H:=1 TO VA+VOLGA+V13+1 DO
        BEGIN
            VET[H,RE+1]:=0;
        END;
        FOR H:=VA+VOLGA+1 TO VA+VOLGA+V13 DO
          VET[H,RE+1]:=1;
     END;{62}
      {***** MONTANDO Q(X) ******}
         IF V15<>0 THEN
             L:=2
          ELSE
             L:=1;

       FOR H:=1 TO VA DO
        BEGIN
            IF Q[H]=0 THEN
            BEGIN
               N10[H]:=H;
            END;
            VET[H,RE+L]:=Q[H];
        END;


      {**** COLOCANDO VOLGA ****}    { VET[ H , I ] H=COLUNA I =LINHA}
       FOR H:=VA+1 TO VA+VOLGA DO
          FOR I:=1 TO RE DO
           BEGIN {1}
            IF (SINAL[I]=2)AND(VA+I=H) THEN {>}
             BEGIN {2}
                  VET[H,I]:=-1;
             END {2}
             ELSE
               IF (SINAL[I]=1)OR((SINAL[I]=2)AND(BI[I]=0)) THEN  {<}
                BEGIN {3}
                 IF VET[0,I]=VET[H,0] THEN
                    VET[H,I]:=1
                 ELSE
                     VET[H,I]:=0;
               END;{3}
           END;{1}
                      I:=0;
        {COLOCANDO VALOR AS ARTIFICIAIS }
     IF V13<>0 THEN
        FOR H:=VA+VOLGA+1 TO VA+VOLGA+V13 DO
           BEGIN {1}
            FOR  I:=1 TO RE DO
               IF VET[0,I]=VET[H,0] THEN
                  VET[H,I]:=1
               ELSE
                 VET[H,I]:=0;

           END;{1}


      {****MONTANDO Bi ***********}
           IF V13<>0  THEN
            L:=V13
            ELSE
             L:=0;

        R1:=VA+VOLGA+L+1;
       FOR I:=1 TO RE DO
         BEGIN
         IF (SINAL[I]=3)AND(BI[I]<0) THEN
             VET[R1,I]:=BI[I]*-1
          ELSE
            VET[R1,I]:=BI[I];

         END;

         VET[R1+1,0]:=0;

               H:=0;
               L:=1;
               D:=0;
          {****  retirando variavel artificial da q(x)  ARTIFICIAL****}
     IF V13<>0 THEN
       BEGIN{60}
           FOR H:=1 TO VOLGA+VA+V13+1 DO
            BEGIN{61}
              FOR  I:=1  TO RE DO
               IF VET[0,I]=ART[L] THEN
                BEGIN{62}
                  D:=VET[H,I]+D;
                  L:=L+1;
                END;{62}
                  VET[H,I+1]:=VET[H,I+1]-D;
                  D:=0;
                  L:=1;
            END;{61}
       END;{60}



    {**** MOSTRANDO A PADRONIZACAO ********* }

      MOSTRA;



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
    FOR I:=02 TO 78 DO
    BEGIN
     GOTOXY(I,10);
     WRITE('*');
   END;

     GOTOXY(22,12);
     WRITELN('    SOLUCAO   ');
     FOR i:=1 TO RE DO
       WRITELN('X ',VET[0,I]:2:2,'=',VET[VOLGA+VA+1,I]:2:2);
    {
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
        END;}

        WRITE('Q(X)= ',VET[VA+VOLGA+1,RE+1]:2:2);
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
      AUX:ARRAY[0..30,0..30] OF REAL;
BEGIN
  {***** DIVIDINDO A LINHA DO PIVO PELO PIVO ****}
     VET[0,LINHA]:=VET[COLUNA,0];
        VALOR:=VET[COLUNA,LINHA];

      IF V13<> 0 THEN
          L:=V13
       ELSE
          L:=0;

   FOR H:=1 TO VA+VOLGA+L+1 DO {COLUNA}
       VET[H,LINHA]:=VET[H,LINHA]/VALOR;

    FOR I:=0 TO 30 DO
     FOR H:=0 TO 30 DO
       AUX[H,I]:=VET[H,I];

       IF V15<>0  THEN
          K:=2
       ELSE
          K:=1;

        FOR I:=1 TO RE+K DO {LIMHA }
         BEGIN
            IF I<>LINHA THEN
              FOR H:=1 TO VA+VOLGA+L+1 DO {COLUNA}
               BEGIN
                   VET[H,I]:=AUX[H,I]-(AUX[COLUNA,I]*AUX[H,LINHA])
               END;
         END;
            WRITELN('FIM PIVOTIAMENTO');
            TECLA:=READKEY;
           MOSTRA;

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
     VERDADE:=TRUE;
     I2:=0;
     B1:=1;
     L:=1;
       B1:=1;

            VERDADE:=TRUE;
            B1:=1;
    IF V13<>0 THEN{VENDO SE EXISTE VARIAVEL ARTIFICIAL COM LINHA ZERADA}
     BEGIN{40}
     FOR B1:=1 TO 30 DO
      BEGIN{80}
       IF ART[B1]<>0 THEN
        FOR I:=1 TO RE DO  {PEGANDO LINHA}
         BEGIN{41}
           IF VET[0,I]=ART[B1] THEN
            BEGIN{42}
                FOR H:=1 TO VA+VOLGA+V13+1 DO {COLUNA}
                 BEGIN{43}
                    IF VET[H,0]<>VET[0,I] THEN
                     BEGIN {12}
                      IF VET[H,I]<>0 THEN
                         VERDADE:=FALSE;
                      END;{12}
                 END;{43}
                IF  VERDADE THEN{SE A VARIAVEL ARTIFICIAL E TODA LINHA 0 }
                  BEGIN {44}
                      {ELIMINANDO DE ART VARIAVEL ARTIFICIAL }
                      FOR G:=1 TO V13 DO
                        IF ART[G]=VET[0,I] THEN
                           ART[G]:=0;

                        {** ACHANDO COLUNA ***}
                         FOR K:=1 TO VA+VOLGA+V13+1 DO
                          IF VET[0,I]=VET[K,0] THEN
                            BEGIN{47}
                               J:=K;
                            END;{47}
                        {**ELIMINANDO UMA LINHA**}
                        K:=I;{GUARDA LINHA CORRENTE}
                        IF V15<>0 THEN {VENDO SE EXISTE Q(X) ARTIFICIAL}
                           H:=2
                        ELSE
                           H:=1;   {2 1  1}
                      FOR K:=I TO RE+H DO     {-1}
                       FOR G:=0 TO VA+VOLGA+V13+1 DO {COLUNA}
                       BEGIN{45}
                             VET[G,K]:=VET[G,K+1];
                       END;{45}
                      {**** ELIMINANDO COLUNA *****}

                            FOR K:=J  TO   VA+VOLGA+V13+1 DO
                              FOR L:=0 TO  RE+1 DO {LINHA}
                               BEGIN{48}
                                   VET[K,L]:=VET[K+1,L];
                               END;{48}


                      WRITELN(' ELIMINADA VARIAVEL ARTIFICIAL MENOR');
                         TECLA:=READKEY;
                   V13:=V13-1;
                   RE:=RE-1;
                   L:=1;
                  END; {44}
            END;{42}

        END;{41}
     END;{40}
   END;{80}


               MOSTRA;
              VERDADE:=FALSE;

     FOR I:=1 TO RE DO {LINHA}
       BEGIN
           IF 0< VET[COLUNA,I] THEN
            BEGIN
                 VERDADE:=TRUE;
                 IF I2=0 THEN
                    BEGIN

                     IF V15<>0 THEN
                        L:=V13
                      ELSE
                         L:=0;

                      I2:=1;
                      VMINIMO:=VET[VA+VOLGA+L+1,I]/VET[COLUNA,I];
                      LINHA:=I;
                    END;

                      VALOR:=VET[VA+VOLGA+L+1,I]/VET[COLUNA,I];
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
          WRITELN('VMINIMO=',VMINIMO:2:2,'  LINHA=',LINHA);
          TECLA:=READKEY;

END;



{
************ PROCURA MENOR EM Q(X), VET[VERIAVEL,RE+1] ************
************  ENCONTRA A COLUNA COM O MENOR VALOR      ************
 }
PROCEDURE MENOR_QX;
VAR
   MENOR:REAL;
   VERDADE,VERDADE2,RETIRA:BOOLEAN;
BEGIN
    MENOR:=0;
    VERDADE2:=TRUE;
    VERDADE:=TRUE;
                VERDADE:=TRUE;
            B1:=1;
    IF V13<>0 THEN{VENDO SE EXISTE VARIAVEL ARTIFICIAL COM LINHA ZERADA}
     BEGIN{40}
     FOR B1:=1 TO 30 DO
      BEGIN{80}
       IF ART[B1]<>0 THEN
        FOR I:=1 TO RE DO  {PEGANDO LINHA}
         BEGIN{41}
           IF VET[0,I]=ART[B1] THEN
            BEGIN{42}
                FOR H:=1 TO VA+VOLGA+V13+1 DO {COLUNA}
                 BEGIN{43}
                    IF VET[H,0]<>VET[0,I] THEN
                     BEGIN {12}
                      IF VET[H,I]<>0 THEN
                         VERDADE:=FALSE;
                      END;{12}
                 END;{43}
                IF  VERDADE THEN{SE A VARIAVEL ARTIFICIAL E TODA LINHA 0 }
                  BEGIN {44}
                      {ELIMINANDO DE ART VARIAVEL ARTIFICIAL }
                      FOR G:=1 TO V13 DO
                        IF ART[G]=VET[0,I] THEN
                           ART[G]:=0;

                        {** ACHANDO COLUNA ***}
                         FOR K:=1 TO VA+VOLGA+V13+1 DO
                          IF VET[0,I]=VET[K,0] THEN
                            BEGIN{47}
                               J:=K;
                            END;{47}
                        {**ELIMINANDO UMA LINHA**}
                        K:=I;{GUARDA LINHA CORRENTE}
                        IF V15<>0 THEN {VENDO SE EXISTE Q(X) ARTIFICIAL}
                           H:=2
                        ELSE
                           H:=1;   {2 1  1}
                      FOR K:=I TO RE+H DO     {-1}
                       FOR G:=0 TO VA+VOLGA+V13+1 DO {COLUNA}
                       BEGIN{45}
                             VET[G,K]:=VET[G,K+1];
                       END;{45}
                      {**** ELIMINANDO COLUNA *****}

                            FOR K:=J  TO   VA+VOLGA+V13+1 DO
                              FOR L:=0 TO  RE+1 DO {LINHA}
                               BEGIN{48}
                                   VET[K,L]:=VET[K+1,L];
                               END;{48}


                      WRITELN(' ELIMINADA VARIAVEL ARTIFICIAL MENOR');
                         TECLA:=READKEY;
                   V13:=V13-1;
                   RE:=RE-1;
                   L:=1;
                  END; {44}
            END;{42}

        END;{41}
     END;{40}
   END;{80}

   MOSTRA;


   VERDADE:=TRUE;
    { ***** VENDO SE Q(X) ARTIFICIAL E MAIOR QUE ZERO ***}
  IF V15<>0  THEN
  BEGIN {60}               {+1}
     FOR H:=1 TO VA+VOLGA+V13 DO {COLUNA}
      BEGIN
           PRE:=10000000;
           VET[H,RE+1]:=INT((VET[H,RE+1])*PRE)/PRE;
        IF VET[h,RE+1]<0 THEN
           VERDADE:=FALSE;
      END;

         IF  VERDADE THEN {ENTRA SE Q(X) ARTIFICIAL MAIOR QUE ZERO}
          BEGIN {61}
               V15:=0; {NAO TEM MAIS Q(x) ARTIFICIAL}
               L:=1;
             {*** RETIRANDO Q(X) ARTIFICIAL*******}
               FOR H:=1 TO VA+VOLGA+V13+1   DO {COLUNA}
                 VET[h,RE+1]:=VET[h,RE+2];

                 WRITELN('Q(X) ARTIFICIAL RETIRADA');
                 TECLA:=READKEY;
                 MOSTRA;
            { ** VENDO SE FICOU ALGUMA VARIAVEL ARTIFICIALNA VB ****}
          FOR L:=1 TO V13 DO
            FOR I:=1 TO RE DO
                 IF VET[0,I]=ART[L] THEN {** SOLUCAO IMPOSSIVEL ****}
                   BEGIN{5}
                     IF VET[VA+VOLGA+1+V13,I]<>0 THEN
                      BEGIN {6}
                         WRITELN(' SOLUCAO IMPOSSIVEL, ' );
                         WRITELN(' NAO FOI POSSIVEL ELIMINAR VARIAVEIS ARTIFICIAIS');
                         TECLA:=READKEY;
                         CLRSCR;
                         HALT;
                       END;{6}
                   END; {5}
                 { RETIRANDO VARIAVEIS ARTIFICIAIS }
                 G:=V13;
                 H:=1;
                 K:=VA+VOLGA+1;
                  RETIRA:=TRUE;
               WHILE H<=G DO
                BEGIN{43}
                  IF NOT RETIRA THEN
                     K:=K+1;{SOMA COLUNA}
                     RETIRA:=TRUE;
                     FOR I:=1 TO RE+1 DO  {LINHA}
                       BEGIN{44}
                        IF VET[K,0]=VET[0,I] THEN
                            RETIRA:=FALSE;
                         END;{44}
                       IF RETIRA THEN
                          BEGIN{45}
                           FOR L:=1 TO V13 DO
                                IF ART[L]=VET[K,0] THEN
                                    ART[L]:=0;

                           FOR L:=K TO VA+VOLGA+V13 DO{COLUNA}
                            FOR I:=0 TO RE+1  DO
                              VET[L,I]:=VET[L+1,I];
                                WRITELN('VARIAVEL ARTIFICIAL RETIRADA JUNTO Q(X) ART MENOR');
                                  TECLA:=READKEY;
                               V13:=V13-1;
                          END;{45}
                     H:=H+1;
                 END;{43}
            END;{61}
  END;{60}

    MOSTRA;

        VERDADE:=TRUE;
            B1:=1;
    IF V13<>0 THEN{VENDO SE EXISTE VARIAVEL ARTIFICIAL COM LINHA ZERADA}
     BEGIN{40}
     FOR B1:=1 TO 30 DO
      BEGIN{80}
       IF ART[B1]<>0 THEN
        FOR I:=1 TO RE DO  {PEGANDO LINHA}
         BEGIN{41}
           IF VET[0,I]=ART[B1] THEN
            BEGIN{42}
                FOR H:=1 TO VA+VOLGA+V13+1 DO {COLUNA}
                 BEGIN{43}
                    IF VET[H,0]<>VET[0,I] THEN
                     BEGIN {12}
                      IF VET[H,I]<>0 THEN
                         VERDADE:=FALSE;
                      END;{12}
                 END;{43}
                IF  VERDADE THEN{SE A VARIAVEL ARTIFICIAL E TODA LINHA 0 }
                  BEGIN {44}
                      {ELIMINANDO DE ART VARIAVEL ARTIFICIAL }
                      FOR G:=1 TO V13 DO
                        IF ART[G]=VET[0,I] THEN
                           ART[G]:=0;

                        {** ACHANDO COLUNA ***}
                         FOR K:=1 TO VA+VOLGA+V13+1 DO
                          IF VET[0,I]=VET[K,0] THEN
                            BEGIN{47}
                               J:=K;
                            END;{47}
                        {**ELIMINANDO UMA LINHA**}
                        K:=I;{GUARDA LINHA CORRENTE}
                        IF V15<>0 THEN {VENDO SE EXISTE Q(X) ARTIFICIAL}
                           H:=2
                        ELSE
                           H:=1;   {2 1  1}
                      FOR K:=I TO RE+H DO     {-1}
                       FOR G:=0 TO VA+VOLGA+V13+1 DO {COLUNA}
                       BEGIN{45}
                             VET[G,K]:=VET[G,K+1];
                       END;{45}
                      {**** ELIMINANDO COLUNA *****}

                            FOR K:=J  TO   VA+VOLGA+V13+1 DO
                              FOR L:=0 TO  RE+1 DO {LINHA}
                               BEGIN{48}
                                   VET[K,L]:=VET[K+1,L];
                               END;{48}


                      WRITELN(' ELIMINADA VARIAVEL ARTIFICIAL MENOR');
                         TECLA:=READKEY;
                   V13:=V13-1;
                   RE:=RE-1;
                   L:=1;
                  END; {44}
            END;{42}

        END;{41}
     END;{40}
   END;{80}


           MOSTRA;


    { CALCULO  MENOR}
     VERDADE:=TRUE;
       IF V13<>0 THEN
          L:=V13
       ELSE
          L:=0;

    FOR H:=1 TO VOLGA+VA+L DO {COLUNA}
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
          FOR H:=1 TO VA+VOLGA+V13+1 DO {COLUNA}
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
      WRITELN('MENOR= ' , MENOR:2:2,' COLUNA=',COLUNA );
      TECLA:=READKEY;

END;


BEGIN
 FOR I:=1  TO  30 DO
 SINAL[I]:=0;
 V13:=0;
 V14:=0;
 V15:=0;
 VOLGA:=0;
  LERDADOS;
   IF V13=0 THEN
  V15:=0
 ELSE
  V15:=1;

  PADRONIZA;
  L:=1;

    L1:=1;
 WHILE  L1=1 DO
 BEGIN
  MENOR_QX;
  MINIMO;
  CALCULO;
 END;

END.
{************ FIM ******************}