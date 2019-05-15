(**************************************************************************)
(* UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL                19/07/95 *)
(* CURSO DE CIENCIAS DA COMPUTACAO - 6 SEMESTRE                           *)
(* TRABALHO DA DISCIPLINA DE TEORIA DE GRAFO, SOLICITADO PELO             *)
(* PROFESSOR SALOMAO WESTPHAL SANDRINI                                    *)
(* OBJETIVO CALCULAR A BASE E A CONTRA-BASE DE UM GRAFO A PARTIR          *)
(* DA MATRIZ ADJACENTE                                                    *)
(* ACADEMICOS : ALEXSSANDRO CARDO ANTUNES                                 *)
(*              OSMAR DE OLIVEIRA BRAZ JUNIOR                             *)
(*              LUSICLER DE SOUZA MOLON                                   *)
(**************************************************************************)

PROGRAM GRAFOS_CONDENSADOS;
USES GRAPH, CRT;

TYPE
    VET        = ARRAY [1..4] OF STRING;
    VETORB     = ARRAY [1..30, 1..30] OF BYTE;
    VETORC     = ARRAY [1..30, 1..30] OF CHAR;

CONST
     CIMA   = 72;
     BAXO   = 80;
     DIRE   = 77;
     ESQU   = 75;
     ESC    = #27;
     ENTER  = #13;
     BS     = #08;

VAR
    TAMANHO, D, CONTA, CONT                 : INTEGER;
    LINHA, COLUNA, LIN, COL, SOMA, AUX      : INTEGER;
    GD, GM, X, L, N                         : INTEGER;
    F, N1, A, ADJ, R, Q, M, AD              : VETORB;
    Y                                       : VETORC;
    T, TECLA1, FINAL                        : CHAR;
    NMO                                     : VET ;

(******************* BARRA PONTILHADA DO MENU PRINCIPAL *******************)
PROCEDURE BARRA_EXT;
BEGIN
    SETFILLSTYLE (10, 15);
    BAR (1, 1, 640, 460);

    SETCOLOR (15);
    RECTANGLE (2, 2, 639, 460);
END;

(******************* BARRA INTERNA DO MENU *************************)
PROCEDURE BARRA_INT1;
BEGIN
     SETFILLSTYLE (10, 15);
     BAR (3, 3, 633, 458);

     SETFILLSTYLE (1, 15);
     BAR (170, 100, 490, 260);

     SETCOLOR (0);
     RECTANGLE (173, 103, 487, 257);
END;

PROCEDURE BARRA_INT2;
BEGIN
     SETFILLSTYLE (1, 15);
     BAR (170, 100, 489, 260);

     SETCOLOR (0);
     RECTANGLE (173, 103, 487, 257);
END;

PROCEDURE BARRA_INT3;
BEGIN
     SETFILLSTYLE (1, 15);
     BAR (174, 104, 486, 256);
END;

(******************* ITENS DO MENU DE BARRA **********************)
PROCEDURE ITENS;
BEGIN
     NMO[1] := ('1 - Apresentacao.');
     NMO[2] := ('2 - Inclusao da Matriz Adjacente.');
     NMO[3] := ('3 - Visualizacao das Matrizes.');
     NMO[4] := ('4 - Saida para S.O.');
     SETCOLOR (12);
     OUTTEXTXY (200, 130, NMO[1]);
     OUTTEXTXY (200, 160, NMO[2]);
     OUTTEXTXY (200, 190, NMO[3]);
     OUTTEXTXY (200, 220, NMO[4]);
END;

(*********************** PROCEDURE DE BARRA *****************************)
PROCEDURE BARRA;
BEGIN
     SETFILLSTYLE (1, 13);
     BAR (175, L - 12, 485, L + 12);
     SETCOLOR (0);
     RECTANGLE (177, L - 10, 483, L + 10);
     OUTTEXTXY (200, L, NMO[N]);
END;

(************************* BARRA DO MENU *******************************)
PROCEDURE PARACIMA (VAR N: INTEGER);
BEGIN
     IF L = 130 THEN
        BEGIN
             L := L + 90;
             N := N + 3;
        END
     ELSE
         BEGIN
              L := L - 30;
              N := N - 1;
         END;
     BARRA_INT3;
     ITENS;
     BARRA;
END;

PROCEDURE PARABAIXO (VAR N: INTEGER);
BEGIN
     IF L = 220  THEN
        BEGIN
             L := L - 90;
             N := N - 3;
        END
     ELSE
         BEGIN
              L := L + 30;
              N := N + 1;
         END;
     BARRA_INT3;
     ITENS;
     BARRA;
END;

(**************************************************************************)
(*************************** APRESENTACAO  ********************************)
PROCEDURE APRESENTACAO;
BEGIN
     T := ' ';
     WHILE T <> ESC DO
         BEGIN
              SETFILLSTYLE (1, 11);
              BAR (100, 175, 540, 425);
              SETCOLOR (0);
              RECTANGLE (103, 178, 537, 422);
              OUTTEXTXY (130, 200, '    >>>>  TRABALHO DE TEORIA DE GRAFOS <<<<');
              OUTTEXTXY (130, 220, ' Solicitado pelo Professor Salomao W. Sandrini');
              LINE (340, 230, 500, 230);
              OUTTEXTXY (130, 280, '   Osmar de Oliveira Braz Junior - CCP 8579');
              OUTTEXTXY (130, 310, '      Lusicler de Souza Molon - CCP 3920');
              OUTTEXTXY (130, 340, '    Alexssandro Cardoso Antunes - CCP 8427');
              RECTANGLE (130, 400, 510, 415);
              OUTTEXTXY (125, 405, '  Tecle <ESC> para voltar para o menu principal');
              T := READKEY;
              T := UPCASE (T);
         END;
END;

(***************************************************************************)
(****************** INCLUSAO DA MATRIZ ADJACENTE   *************************)
PROCEDURE INCLUSAO;
VAR
   CHAVE                         : CHAR;
   TAM                           : ARRAY [1..256] OF CHAR;
   N, ERRO, X, XX, W, XX1        : INTEGER;
   X1, X2, Y1, Y2, Y, VALOR      : INTEGER;
   TAMA, NUMERO, NUM             : STRING[20];

BEGIN
     CHAVE := 'N';
     WHILE CHAVE = 'N' DO
           BEGIN
                CLEARDEVICE;
                SETFILLSTYLE (1, 11);
                BAR (1, 10, 640, 460);
                SETCOLOR (0);
                RECTANGLE (4, 13, 632, 457);
                SETFILLSTYLE (1, 11);
                BAR (160, 1, 495, 20);
                RECTANGLE (162, 3, 493, 25);
                OUTTEXTXY (170, 10, '>>>>> INCLUSAO DO MATRIZ ADJACENTE <<<<<');
                OUTTEXTXY (10, 40, 'DIGITE O TAMANHO DA MATRIZ : ');
                N      := 1;
                X      := 250;
                TAMA   := '';
                TAM[N] := READKEY;

(*********************** LEITURA DO TAMANHO DA MATRIZ **********************)
                WHILE TAM[N] <> ENTER DO
                      BEGIN
                           IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                              OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                              OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                              OR (TAM[N]='0') THEN
                                BEGIN
                                  OUTTEXTXY (X, 40, TAM[N]);
                                  X := X + 10;
                                END;
                           IF TAM[N] = BS THEN
                              BEGIN
                                   IF X <= 260 then
                                      X := 250
                                   ELSE
                                       BEGIN
                                            X := X - 10;
                                            BAR (X, 39, X + 6, 47);
                                            DELETE (TAMA, N-1, N);
                                            N := N - 1;
                                       END;
                              END
                           ELSE
                               BEGIN
                                    TAMA :=  CONCAT (TAMA, TAM[N]);
                                    N := N + 1;
                               END;
                           TAM[N] := READKEY;

                      END;
(**************TRANSFORMA A STRING (TAMA) NO INTEIRO (TAMANHO) *************)
                VAL (TAMA, TAMANHO, ERRO);

(************* EXECUTA NO MAXIMO UMA MATRIZ 20 X 20 ************************)
                IF TAMANHO > 20 THEN
                   TAMANHO := 20;

(******************** DESENHA OS RENTANGULOS DA MATRIZ *********************)
                X1 := 12; X2 := 42;
                Y1 := 70; Y2 := 88;
                FOR X:= 1 TO TAMANHO  DO
                    BEGIN
                         FOR Y := 1 TO TAMANHO DO
                             BEGIN
                                  SETCOLOR (0);
                                  RECTANGLE (X1, Y1, X2, Y2);
                                  X1 := X1 + 30;
                                  X2 := X2 + 30;
                             END;
                         STR (X, NUM);
                         OUTTEXTXY (X1 + 3, Y1 + 7, NUM);
                         Y1 := Y1 + 18;
                         Y2 := Y2 + 18;
                         X1 := 12;
                         X2 := 42;
                    END;
                X1 := 22;
                Y1 := 60;
                FOR X:= 1 TO TAMANHO DO
                    BEGIN
                         SETCOLOR (0);
                         STR (X, NUM);
                         OUTTEXTXY(X1, Y1, NUM);
                         X1 := X1 + 30;
                    END;

(********************* MENSAGEM PARA SAIR DA DIGITACAO *********************)
                RECTANGLE (330, 434, 580, 454);
                OUTTEXTXY (340, 442, 'Para Cancelar Pressione <ESC>');

(**************** LEITURA DOS ELEMENTOS DA MATRIZ ADJACENTE ****************)
                X1 := 21;
                X  := 21;
                Y1 := 76;
                FOR LINHA := 1 TO TAMANHO DO
                    BEGIN
                         FOR COLUNA := 1 TO TAMANHO DO
                             BEGIN
                                  N := 1;
                                  TAMA := '';
                                  TAM[N] := READKEY;
                                  WHILE TAM[N] <> ENTER DO
                                        BEGIN
                                            IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                                             OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                                             OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                                             OR (TAM[N]='0') THEN
                                                BEGIN
                                                     OUTTEXTXY (X, Y1, TAM[N]);
                                                     X := X + 6;
                                                END;
                                                     IF (TAM[N] = BS) THEN
                                                        BEGIN
                                                             XX  := X;
                                                             XX1 := XX;
                                                        END;

                                                     IF (TAM[N] = BS) AND (X >15) THEN
                                                        BEGIN
                                                             IF X < 16 THEN
                                                                X := 16
                                                             ELSE
                                                                 BEGIN
                                                                      XX1 := XX1 - 2;
                                                                      (*  XX  := XX - 6;*)
                                                                      SETFILLSTYLE (1, 11);
                                                                      BAR (XX-6, Y1 - 3, XX1+3, Y1 + 8);
                                                                      DELETE (TAMA, N-1, N);
                                                                      N := N - 1;
                                                                      X := X - 6;
                                                                 END
                                                        END
                                                     ELSE
                                                         BEGIN
                                                              TAMA :=  CONCAT (TAMA, TAM[N]);
                                                              N := N + 1;
                                                         END;

(*************** ENCERRA O NUMERO AO COMPLETAR 2 DIGITOS *******************)
                                                    IF N < 3 THEN
                                                       TAM[N] := READKEY
                                                    ELSE
                                                        TAM[N] := ENTER;

(***** ENCERRA PARA NOVA DIGITACAO SE OS DADOS DA MATRIZ FOREM INCORRETOS ***)

                                                    IF TAM[N] = ESC THEN
                                                       BEGIN
                                                            LINHA := TAMANHO;
                                                            COLUNA := TAMANHO;
                                                       END;

                                         END;

(************** TRANSFORMA A STRING (TAMA) EM INTEIRO (VALOR) **************)
                                  VAL (TAMA, VALOR, ERRO);

(******************** INCLUSAO DO VALOR NA MATRIZ **************************)
                                  AD[LINHA, COLUNA] := VALOR;
                                  X1 := ( N - 2) * 6;
                                  X := X - X1;
                                  X := X + 24;
                             END;

(************ RETORNA A COLUNA INICIAL E PULA A LINHA DA MATRIZ ************)
                             X  := 21;
                             Y1 := Y1 + 18;
                     END;

(******************** CONFIRMACAO DA MATRIZ DE ADJACENCIA ******************)
                RECTANGLE (50, 434, 240, 454);
                OUTTEXTXY (60, 442, 'CONFIRMA DADOS? (S/N)');
                CHAVE := READKEY;
                CHAVE := UPCASE (CHAVE);
           END;

(*** TRANSFERE A MATRIZ CONFIRMADA TEMPORARIA PARA A MATRIZ DEFINITIVA *****)
     ADJ := AD;
END;

(***************************************************************************)
(********************** VISUALIZACAO DAS MATRIZES **************************)
PROCEDURE VISUALIZACAO;
VAR
   CHAVE, TECLA              : CHAR;
   VALOR                     : STRING;
   X1, X2, Y1, Y2, COL1      : INTEGER;

BEGIN
     CHAVE := 'N';
     WHILE CHAVE = 'N' DO
           BEGIN
                CLEARDEVICE;
                SETFILLSTYLE (1, 11);
                BAR (1, 10, 640, 460);
                SETCOLOR (0);
                RECTANGLE (2, 13, 638, 457);
                BAR (155, 1, 485, 20);
                RECTANGLE (157, 3, 483, 25);
                OUTTEXTXY (170, 10, '>>>>> VISUALIZACAO DAS MATRIZES <<<<<');

(**************** GERANDO A MATRIZ R ACESSIBILIDADE ************************)
                FOR LINHA := 1 TO TAMANHO DO
                   FOR COLUNA :=1 TO TAMANHO DO
                       BEGIN
                            R [LINHA, COLUNA] := 0;
                            Y [LINHA, COLUNA] := 'F';
                       END;
                FOR LINHA := 1 TO TAMANHO do
                   BEGIN
                        CONTA := 1;
                        WHILE CONTA <= TAMANHO  do
                              BEGIN
                                   IF CONTA = LINHA THEN
                                      R[LINHA, CONTA] := 1;
                                   IF (R[LINHA, CONTA] = 1) AND (Y[LINHA, CONTA] = 'F') then
                                      BEGIN
                                           FOR D:=1 TO TAMANHO DO
                                               IF ADJ[CONTA, D] = 1 THEN
                                                  R[LINHA, D] := 1;
                                           Y[LINHA, CONTA] := 'V';
                                           CONTA := 1;
                                      END
                                         ELSE
                                            CONTA := CONTA + 1;
                              END;
                   END;

(*************** MOSTRANDO A MATRIZ DE ACESSIBILIDADE **********************)
               OUTTEXTXY (10, 50, 'Matriz R de Acessibilidade');
               X1 := 15; X2 := 45;
               Y1 := 70; Y2 := 88;
               FOR LINHA := 1 TO TAMANHO  DO
                   BEGIN
                        FOR COLUNA := 1 TO TAMANHO DO
                            BEGIN
                                 SETCOLOR (0);
                                 RECTANGLE (X1, Y1, X2, Y2);
                                 STR (R[LINHA, COLUNA], VALOR);
                                 OUTTEXTXY (X1 + 12, Y1 + 5, VALOR);
                                 X1 := X1 + 30;
                                 X2 := X2 + 30;
                            END;
                        Y1 := Y1 + 18;
                        Y2 := Y2 + 18;
                        X1 := 15;
                        X2 := 45;
                   END;
               RECTANGLE (300, 434, 635, 454);
               OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');

(************************* GERA A MATRIZ TRANSPOSTA **********************)
            FOR LINHA := 1 to TAMANHO do
               FOR COLUNA := 1 to TAMANHO do
                   Q[COLUNA, LINHA] := R[LINHA, COLUNA];

(******************** VISUALIZACAO DA MATRIZ TRANSPOSTA ******************)
               TECLA := READKEY;
               BAR (3, 30, 635, 455);
               OUTTEXTXY (10, 50, 'Matriz Q de Transposta');
               X1 := 15; X2 := 45;
               Y1 := 70; Y2 := 88;
               FOR LINHA := 1 TO TAMANHO  DO
                   BEGIN
                        FOR COLUNA := 1 TO TAMANHO DO
                            BEGIN
                                 SETCOLOR (0);
                                 RECTANGLE (X1, Y1, X2, Y2);
                                 STR (Q[LINHA, COLUNA], VALOR);
                                 OUTTEXTXY (X1 + 12, Y1 + 5, VALOR);
                                 X1 := X1 + 30;
                                 X2 := X2 + 30;
                            END;
                        Y1 := Y1 + 18;
                        Y2 := Y2 + 18;
                        X1 := 15;
                        X2 := 45;
                   END;
               RECTANGLE (300, 434, 635, 454);
               OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');

(**** MULTIPLICANDO A MATRIZ TRANSPOSTA PELA MATRIZ DE ACESSIBILIDADE ****)
                FOR LINHA := 1 to TAMANHO do
                    FOR COLUNA := 1 to TAMANHO do
                        BEGIN
                             M[LINHA, COLUNA]  := 0;
                             N1[LINHA, COLUNA] := 0;
                             IF (R[LINHA, COLUNA] = 1) AND (Q[LINHA, COLUNA] = 1) then
                                BEGIN
                                     M[LINHA, COLUNA] := 1;
                                     N1[LINHA, COLUNA] := 1;
                                END;
                        END;

(**************************** ZERANDO A MATRIZ AUXILIAR ********************)
FOR LINHA := 1 to TAMANHO do
    FOR COLUNA := 1 to TAMANHO do
        F[LINHA, COLUNA] := 0;

(***************************** CALCULANDO OS COMPONENTES *******************)
    CONTA := 0;
    FOR LINHA := 1 to TAMANHO do
        BEGIN
             IF M[LINHA, 1] <> 9 THEN
                BEGIN
                     CONTA := CONTA + 1;
                     F[CONTA, LINHA] := LINHA;
                     FOR D := LINHA + 1 to TAMANHO do
                         BEGIN
                              IF M[D,1] <> 9 THEN
                                 BEGIN
                                      COLUNA := 1;
                                      WHILE (COLUNA < TAMANHO + 1) DO
                                        IF (M[LINHA, COLUNA]=M[D, COLUNA]) THEN
                                           COLUNA := COLUNA + 1
                                        ELSE
                                           COLUNA := TAMANHO + 10;
                                        IF COLUNA = (TAMANHO + 1) THEN
                                           BEGIN
                                                F[CONTA,D] := D;
                                                M[D,1] := 9;
                                           END;
                                 END;
                         END;
                END;
        END;

(************************ MOSTRANDO OS COMPONENTES FORTES *****************)
TECLA := READKEY;
BAR (3, 30, 635, 455);
OUTTEXTXY(10, 50, 'Componentes Fortes do Grafo Condensado');
COL := 10;
LIN := 80;
FOR LINHA := 1 TO CONTA DO
    BEGIN
         OUTTEXTXY (COL, LIN, 'X');
         STR (LINHA, VALOR);
         OUTTEXTXY (COL + 10, LIN, VALOR);
         OUTTEXTXY (COL + 20, LIN, '* = { ');
         COL := COL + 70;
         FOR COLUNA := 1 to TAMANHO do
             BEGIN
                  IF F[LINHA, COLUNA] <> 0 THEN
                     BEGIN
                          OUTTEXTXY (COL, LIN, 'x');
                          STR (F[LINHA, COLUNA], VALOR);
                          OUTTEXTXY (COL + 10, LIN, VALOR) ;
                          OUTTEXTXY (COL + 20, LIN,' }');
                          COL := COL + 40;
                     END;
             END;
         LIN := LIN + 30;
         COL := 10;
    END;
RECTANGLE (300, 434, 635, 454);
OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');

(******************** CALCULANDO E MOSTRANDO A BASE ********************)
TECLA := READKEY;
BAR (3, 30, 635, 455);
OUTTEXTXY (10, 50, 'Bases do Grafo Condensado');
LINHA := 1;
LIN   := 80;
COL   := 10;
WHILE LINHA <= CONTA DO
      BEGIN
           COLUNA := 1;
           WHILE COLUNA <= TAMANHO DO
                 BEGIN
                      SOMA := 0;
                      IF F[LINHA, COLUNA] = 0 THEN
                         COLUNA := COLUNA + 1
                      ELSE
                          BEGIN
                               AUX := F[LINHA, COLUNA];
                               SOMA := 0;
                               COL1 := COL;
                               FOR D := 1 TO TAMANHO DO
                                   IF Q[AUX, D] = N1[AUX ,D] THEN
                                      SOMA := SOMA + 1;
                                   IF SOMA = TAMANHO THEN
                                      BEGIN
                                           OUTTEXTXY (COL, LIN, 'X');
                                           STR (LINHA, VALOR);
                                           OUTTEXTXY (COL + 10, LIN,VALOR);
                                           OUTTEXTXY (COL + 20, LIN,'* = { ');
                                           FOR D := 1 TO TAMANHO DO
                                              BEGIN
                                                  IF F[LINHA, D] <> 0 THEN
                                                     BEGIN
                                                         OUTTEXTXY (COL1 + 70, LIN, 'x');
                                                         STR (F[LINHA, D], VALOR);
                                                         OUTTEXTXY (COL1 + 80, LIN, VALOR) ;
                                                         COL1 := COL1 + 40;
                                                     END;
                                              END;
                                           COLUNA := TAMANHO + 1;
                                           OUTTEXTXY (COL1 + 50, LIN, ' }');
                                           LIN := LIN + 30;
                                      END
                                   ELSE
                                       LINHA := LINHA + 1;
                          END;
                 END;
           LINHA := LINHA + 1;
      END;
RECTANGLE (300, 434, 635, 454);
OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');

(************* CALCULANDO E MOSTRANDO A  CONTRA-BASE *******************)
TECLA := READKEY;
BAR (3, 30, 635, 455);
OUTTEXTXY (10, 50, 'Contra bases do Grafo Condensado');
LIN := 80;
COL := 10;
LINHA := 1;
WHILE LINHA <= CONTA DO
      BEGIN
           COLUNA := 1;
           WHILE COLUNA <= TAMANHO DO
                 BEGIN
                      IF F[LINHA,COLUNA] = 0 THEN
                         COLUNA := COLUNA + 1
                      ELSE
                          BEGIN
                               SOMA := 0;
                               FOR D := 1 TO TAMANHO DO
                                   SOMA := SOMA + Q[COLUNA,D];
                               IF SOMA = TAMANHO THEN
                                  COLUNA := COLUNA + 1
                               ELSE
                                   COLUNA := TAMANHO + 10;
                          END;
                 END;
           COL1 := COL;
           IF COLUNA = (TAMANHO + 1) THEN
              BEGIN
                   OUTTEXTXY (COL, LIN, 'X');
                   STR (LINHA, VALOR);
                   OUTTEXTXY (COL + 10, LIN, VALOR);
                   OUTTEXTXY (COL + 20, LIN, '* = { ');
                   FOR D:=1 TO TAMANHO DO
                       BEGIN
                            IF F[LINHA, D] <> 0 THEN
                               BEGIN
                                    OUTTEXTXY (COL1 + 70, LIN, 'x');
                                    STR (F[LINHA, D], VALOR);
                                    OUTTEXTXY (COL1 + 80, LIN, VALOR) ;
                                    COL1 := COL1 + 40;
                               END;
                       END;
                   OUTTEXTXY (COL1 + 50, LIN, ' }');
                   LIN := LIN + 20;
                   LINHA := LINHA + 1;
              END
           ELSE
               LINHA := LINHA + 1;
      END;
      RECTANGLE (300, 434, 635, 454);
      OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');
      CHAVE := READKEY;
    END;
END;

(************************************************************************)
(******************** PROCEDIMENTO DE FIM *******************************)
PROCEDURE FIM;
BEGIN
     T := ' ';
     FINAL := ' ';
     WHILE T <> ESC DO
          BEGIN
              SETFILLSTYLE (1, 12);
              BAR (105, 145, 520, 225);
              SETCOLOR (0);
              RECTANGLE (108,148,517,223);
              OUTTEXTXY (215, 175, 'Para sair pressione <ESC>');
              T := READKEY;
          END;
    OUTTEXTXY (215, 190, 'CONFIRMA SAIDA? (S/N)');
    FINAL := READKEY;
    FINAL := UPCASE (FINAL);
    TECLA1 := ENTER;
END;

(********************** OPCOES DO MENU ***************************)
PROCEDURE OPCAO(VAR N : INTEGER) ;
BEGIN
     CASE N OF
        1    :  APRESENTACAO;
        2    :  INCLUSAO;
        3    :  VISUALIZACAO;
        4    :  FIM;
     END;
END;

(******************************************************************)
(********************* PROGRAMA PRINCIPAL *************************)
BEGIN
     GD := DETECT;
     INITGRAPH (GD,GM,'C:\COMPILA\PASCAL7\BGI');
(*     INITGRAPH (GD,GM,' ');*)

(***************** INICIALIZACAO DO MENU ***************************)
     L := 130;
     N := 1;

(************************* EXEMPLO INICIAL ************************)
     tamanho:=13;
     ADJ[1,1]:=1;
     ADJ[1,2]:=1;
     ADJ[1,3]:=0;
     ADJ[1,4]:=1;
     ADJ[1,5]:=1;
     ADJ[1,6]:=1;
     ADJ[1,7]:=1;
     ADJ[1,8]:=1;
     ADJ[1,9]:=1;
     ADJ[1,10]:=1;
     ADJ[1,11]:=0;
     ADJ[1,12]:=0;
     ADJ[1,13]:=0;

     ADJ[2,1]:=1;
     ADJ[2,2]:=1;
     ADJ[2,3]:=0;
     ADJ[2,4]:=1;
     ADJ[2,5]:=1;
     ADJ[2,6]:=1;
     ADJ[2,7]:=1;
     ADJ[2,8]:=1;
     ADJ[2,9]:=1;
     ADJ[2,10]:=1;
     ADJ[2,11]:=0;
     ADJ[2,12]:=0;
     ADJ[2,13]:=0;

     ADJ[3,1]:=1;
     ADJ[3,2]:=1;
     ADJ[3,3]:=1;
     ADJ[3,4]:=1;
     ADJ[3,5]:=1;
     ADJ[3,6]:=1;
     ADJ[3,7]:=1;
     ADJ[3,8]:=1;
     ADJ[3,9]:=0;
     ADJ[3,10]:=0;
     ADJ[3,11]:=0;
     ADJ[3,12]:=0;
     ADJ[3,13]:=0;

     ADJ[4,1]:=0;
     ADJ[4,2]:=0;
     ADJ[4,3]:=0;
     ADJ[4,4]:=1;
     ADJ[4,5]:=0;
     ADJ[4,6]:=0;
     ADJ[4,7]:=1;
     ADJ[4,8]:=0;
     ADJ[4,9]:=1;
     ADJ[4,10]:=0;
     ADJ[4,11]:=0;
     ADJ[4,12]:=0;
     ADJ[4,13]:=0;

     ADJ[5,1]:=1;
     ADJ[5,2]:=1;
     ADJ[5,3]:=0;
     ADJ[5,4]:=1;
     ADJ[5,5]:=1;
     ADJ[5,6]:=1;
     ADJ[5,7]:=1;
     ADJ[5,8]:=1;
     ADJ[5,9]:=1;
     ADJ[5,10]:=1;
     ADJ[5,11]:=0;
     ADJ[5,12]:=0;
     ADJ[5,13]:=0;

     ADJ[6,1]:=1;
     ADJ[6,2]:=1;
     ADJ[6,3]:=0;
     ADJ[6,4]:=1;
     ADJ[6,5]:=1;
     ADJ[6,6]:=1;
     ADJ[6,7]:=1;
     ADJ[6,8]:=1;
     ADJ[6,9]:=1;
     ADJ[6,10]:=1;
     ADJ[6,11]:=0;
     ADJ[6,12]:=0;
     ADJ[6,13]:=0;

     ADJ[7,1]:=0;
     ADJ[7,2]:=0;
     ADJ[7,3]:=0;
     ADJ[7,4]:=1;
     ADJ[7,5]:=0;
     ADJ[7,6]:=0;
     ADJ[7,7]:=1;
     ADJ[7,8]:=0;
     ADJ[7,9]:=1;
     ADJ[7,10]:=0;
     ADJ[7,11]:=0;
     ADJ[7,12]:=0;
     ADJ[7,13]:=0;

     ADJ[8,1]:=0;
     ADJ[8,2]:=0;
     ADJ[8,3]:=0;
     ADJ[8,4]:=1;
     ADJ[8,5]:=0;
     ADJ[8,6]:=0;
     ADJ[8,7]:=1;
     ADJ[8,8]:=1;
     ADJ[8,9]:=1;
     ADJ[8,10]:=1;
     ADJ[8,11]:=0;
     ADJ[8,12]:=0;
     ADJ[8,13]:=0;

     ADJ[9,1]:=0;
     ADJ[9,2]:=0;
     ADJ[9,3]:=0;
     ADJ[9,4]:=1;
     ADJ[9,5]:=0;
     ADJ[9,6]:=0;
     ADJ[9,7]:=1;
     ADJ[9,8]:=0;
     ADJ[9,9]:=1;
     ADJ[9,10]:=0;
     ADJ[9,11]:=0;
     ADJ[9,12]:=0;
     ADJ[9,13]:=0;

     ADJ[10,1]:=0;
     ADJ[10,2]:=0;
     ADJ[10,3]:=0;
     ADJ[10,4]:=1;
     ADJ[10,5]:=0;
     ADJ[10,6]:=0;
     ADJ[10,7]:=1;
     ADJ[10,8]:=1;
     ADJ[10,9]:=1;
     ADJ[10,10]:=1;
     ADJ[10,11]:=0;
     ADJ[10,12]:=0;
     ADJ[10,13]:=0;

     ADJ[11,1]:=0;
     ADJ[11,2]:=0;
     ADJ[11,3]:=0;
     ADJ[11,4]:=1;
     ADJ[11,5]:=0;
     ADJ[11,6]:=0;
     ADJ[11,7]:=1;
     ADJ[11,8]:=1;
     ADJ[11,9]:=1;
     ADJ[11,10]:=1;
     ADJ[11,11]:=1;
     ADJ[11,12]:=1;
     ADJ[11,13]:=1;

     ADJ[12,1]:=0;
     ADJ[12,2]:=0;
     ADJ[12,3]:=0;
     ADJ[12,4]:=1;
     ADJ[12,5]:=0;
     ADJ[12,6]:=0;
     ADJ[12,7]:=1;
     ADJ[12,8]:=1;
     ADJ[12,9]:=1;
     ADJ[12,10]:=1;
     ADJ[12,11]:=1;
     ADJ[12,12]:=1;
     ADJ[12,13]:=1;


     ADJ[13,1]:=0;
     ADJ[13,2]:=0;
     ADJ[13,3]:=0;
     ADJ[13,4]:=1;
     ADJ[13,5]:=0;
     ADJ[13,6]:=0;
     ADJ[13,7]:=1;
     ADJ[13,8]:=1;
     ADJ[13,9]:=1;
     ADJ[13,10]:=1;
     ADJ[13,11]:=1;
     ADJ[13,12]:=1;
     ADJ[13,13]:=1;

(**************************** TELA INICIAL ******************************)
     CLEARDEVICE;
     BARRA_EXT;
     BARRA_INT1;
     ITENS;
     BARRA;
     FINAL := 'N';
     REPEAT
          TECLA1 := READKEY;
          IF (TECLA1 = ENTER) AND (FINAL <>'S')THEN
             BEGIN
                  OPCAO(N);
                  BARRA_EXT;
                  BARRA_INT1;
                  ITENS;
                  BARRA;
            END;
          CASE ORD(TECLA1) OF
             CIMA      :   PARACIMA(N);
             BAXO      :   PARABAIXO(N);
             DIRE      :   PARACIMA(N);
             ESQU      :   PARABAIXO(N);
             27        :   BEGIN
                                FIM;
                                BARRA_EXT;
                                BARRA_INT1;
                                ITENS;
                                BARRA;
                            END;
             49        :   BEGIN
                                APRESENTACAO;
                                BARRA_EXT;
                                BARRA_INT1;
                                ITENS;
                                BARRA;
                           END;
              50       :   BEGIN
                                INCLUSAO;
                                BARRA_EXT;
                                BARRA_INT1;
                                ITENS;
                                BARRA;
                           END;
              51       :   BEGIN
                                 VISUALIZACAO;
                                 BARRA_EXT;
                                 BARRA_INT1;
                                 ITENS;
                                 BARRA;
                             END;
              52        :   BEGIN
                                 FIM;
                                 BARRA_EXT;
                                 BARRA_INT1;
                                 ITENS;
                                 BARRA;
                             END;
          END;
          UNTIL (FINAL = 'S');
    CLOSEGRAPH;
    EXIT;
END.