(**************************************************************************)
(*            UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL   18/07/95   *)
(*             CURSO DE CIENCIAS DA COMPUTACAO 6 SEMESTRE                 *)
(*          TRABALHO DA DISCIPLINA DE ESTRUTURA DE DADOS II               *)
(*            SOLICITADO PELO PROFESSOR MARCELO MEDEIROS                  *)
(*   OBJETIVO DEMONSTRAR UMA ARVORE BINARIA NO TELA GRAFICA DO PASCAL     *)
(*            ALUNOS: OSMAR DE OLIVEIRA BRAZ JUNIOR                       *)
(*                    ALEXSSANDRO CARDOSO ANTUNES                         *)
(**************************************************************************)

PROGRAM ARVORES;
USES GRAPH, CRT;

TYPE
    VET        = ARRAY [1..4] OF STRING;
    VETOR_TIPO = ARRAY [1..100] OF INTEGER;

CONST
     CIMA   = 72;
     BAXO   = 80;
     DIRE   = 77;
     ESQU   = 75;
     ESC    = #27;
     ENTER  = #13;
     BS     = #08;
VAR
   VETOR                                 : VETOR_TIPO;
   T,TECLA,FINAL                         : CHAR;
   GD, GM, X, L, N, TAMANHO              : INTEGER;
   NMO                                   : VET ;

(**************** BARRA PONTILHADA DO MENU PRINCIPAL ******************)
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
     BAR (170, 100, 450, 260);

     SETCOLOR (0);
     RECTANGLE (173, 103, 447, 257);
END;

PROCEDURE BARRA_INT2;
BEGIN
     SETFILLSTYLE (1, 15);
     BAR (170, 100, 459, 260);

     SETCOLOR (0);
     RECTANGLE (173, 103, 447, 257);
END;

PROCEDURE BARRA_INT3;
BEGIN
     SETFILLSTYLE (1, 15);
     BAR (174, 104, 446, 256);
END;

(******************* ITENS DO MENU DE BARRA **********************)
PROCEDURE ITENS;
BEGIN
     NMO[1] := ('1 - Apresentacao.');
     NMO[2] := ('2 - Inclusao do Vetor.');
     NMO[3] := ('3 - Visualizacao da Arvore.');
     NMO[4] := ('4 - Saida para S.O.');
     SETCOLOR (12);
     OUTTEXTXY (200, 130, NMO[1]);
     OUTTEXTXY (200, 160, NMO[2]);
     OUTTEXTXY (200, 190, NMO[3]);
     OUTTEXTXY (200, 220, NMO[4]);
END;

(******************* APRESENTACAO  **********************)
PROCEDURE APRESENTACAO;
BEGIN
     T := ' ';
     WHILE T <> ESC DO
         BEGIN
              SETFILLSTYLE (1, 11);
              BAR (100, 175, 540, 425);
              SETCOLOR (0);
              RECTANGLE (103, 178, 537, 422);
              OUTTEXTXY (130, 200, ' >>>>  TRABALHO DE ESTRUTURA DE DADOS II <<<<');
              OUTTEXTXY (130, 220, '  Solicitado pelo Professor Marcelo Medeiros');
              LINE (350, 230, 485, 230);
              OUTTEXTXY (130, 290, '   Osmar de Oliveira Braz Junior - CCP 8579');
              OUTTEXTXY (130, 330, '    Alexssandro Cardoso Antunes - CCP 8427');
              RECTANGLE (135, 400, 505, 415);
              OUTTEXTXY (130, 405, '  Tecle ESC para voltar para o menu principal');
              T := READKEY;
              T := UPCASE (T);
         END;
END;

(********************* INCLUSAO DO VETOR *******************************)
PROCEDURE INCLUSAO;
VAR
   CHAVE                         : CHAR;
   TAM                           : ARRAY [1..256] OF CHAR;
   N, ERRO, X, XX, W, XX1        : INTEGER;
   X1, X2, Y1, Y2, Y, VALOR      : INTEGER;
   TAMA, NUMERO                  : STRING[20];
   VETO                          : VETOR_TIPO;

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
                BAR (180, 1, 465, 20);
                RECTANGLE (182, 3, 463, 25);
                OUTTEXTXY (190, 10, '>>>>>>> INCLUSAO DO VETOR <<<<<<<');
                OUTTEXTXY (10, 50, 'DIGITE O TAMANHO DO VETOR : ');
                N      := 1;
                X      := 250;
                TAMA   := '';
                TAM[N] := READKEY;

(***************** LEITURA DO TAMANHO DO VETOR **********************)
                WHILE TAM[N] <> ENTER DO
                   BEGIN
                        IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                           OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                           OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                           OR (TAM[N]='0') THEN
                              OUTTEXTXY (X, 50, TAM[N]);
                        X := X + 10;
                        IF TAM[N] = BS THEN
                           BEGIN
                                IF X <= 250 then
                                   X := 250
                                ELSE
                                    BEGIN
                                         X := X - 20;
                                         BAR (X, 40, 600, 60);
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

(******************* DESENHA OS RETANGULOS DO VETOR *******************)
                 VAL (TAMA, TAMANHO, ERRO);
                 IF TAMANHO > 31 THEN
                    TAMANHO := 31;
                 X1 := 17; X2 := 77;
                 Y1 := 70; Y2 := 100;
                 FOR X:= 1 TO TAMANHO  DO
                     BEGIN
                          SETCOLOR (0);
                          RECTANGLE (X1, Y1, X2, Y2);
                          STR (X, NUMERO);
                          OUTTEXTXY (X1 + 27, Y1 + 35, NUMERO);
                          X1 := X1 + 60;
                          X2 := X2 + 60;
                          IF X2 > 640 THEN
                             BEGIN
                                  Y1 := Y1 + 60; Y2 := Y2 + 60;
                                  X1 := 17;      X2 := 77;
                             END;
                     END;
                 X  := 30;
                 Y1 := 82;
                 FOR Y := 1 TO TAMANHO DO
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
                                       X := X + 9;
                                  END;
                               IF (TAM[N] = BS) AND (X > 29) THEN
                                  BEGIN
                                       XX  := X;
                                       XX1 := XX;
                                       IF X < 30 THEN
                                          X := 30
                                       ELSE
                                           BEGIN
                                                XX1 := XX1 + 4;
                                                SETFILLSTYLE (1, 11);
                                                BAR (XX - 9, Y1 - 5, XX1 + 4, Y1 + 10);
                                                DELETE ( TAMA, N - 1, N);
                                                N := N - 1;
                                                X := X - 9;
                                           END;
                                  END
                               ELSE
                                   BEGIN
                                        TAMA :=  CONCAT (TAMA, TAM[N]);
                                        N := N + 1;
                                   END;

(************* ENCERRA O NUMERO AO COMPLETAR 4 DIGITOS *******************)
                               IF N < 5 THEN
                                  TAM[N] := READKEY
                               ELSE
                                  TAM[N] := ENTER;

(************ CANCELA A DIGITACAO DOS ELEMENTOS DA ARVORE ***************)
                               IF TAM[N] = ESC THEN
                                  BEGIN
                                     X:= TAMANHO;
                                     TAM[N] := ENTER;
                                  END;
                             END;


(********* FAZ A MUDANCA DE LINHA DA LEITURA DOS NUMEROS DO VETOR ********)
                          X1 := ( N - 2) * 9;
                          X := X - X1;
                          X := X + 51;
                          IF X > 570 THEN
                             BEGIN
                                  X  := 30;
                                  Y1 := Y1 + 60;
                             END;
                          VAL (TAMA, VALOR, ERRO);
                          VETO[Y] := VALOR;
                     END;
              RECTANGLE (220, 434, 410, 454);
              OUTTEXTXY (230, 442, 'CONFIRMA DADOS? (S/N)');
              CHAVE := READKEY;
              CHAVE := UPCASE (CHAVE);
           END;
     VETOR := VETO;
END;

(******************** VISUALIZACAO DA ARVORE **************************)
PROCEDURE VISUALIZACAO;
TYPE
    AP_LISTA = ^LISTA;
    LISTA    =  RECORD
                      X,Y        : INTEGER;
                      SEGUINTE   : AP_LISTA;
                END;
    PONTAS   =  RECORD
                      COMECO  : AP_LISTA;
                      TERMINO : AP_LISTA;
                END;
VAR
   F                                : PONTAS;
   T                                : AP_LISTA;
   CHAVE                            : CHAR;
   TAMA, CONT, X, Y, XX, YY, Z, R   : INTEGER;
   XXX, YYY, ESPACO, ESPA           : INTEGER;
   NUM                              : STRING[4];

(***************** PROCEDURE INICIA FILA ***************************)
PROCEDURE INICIO(VAR F : PONTAS);
BEGIN
     F.COMECO  := NIL;
     F.TERMINO := NIL;
END;

(************* PROCEDURE INSERE ELEMENTO NA FILA ****************)
PROCEDURE INSERCAO (VAR X,Y : INTEGER; VAR F : PONTAS);
BEGIN
     NEW(T);
     T^.X := X;
     T^.Y := Y;
     T^.SEGUINTE := NIL;
     IF F.TERMINO <> NIL THEN
        F.TERMINO^.SEGUINTE := T;
     F.TERMINO := T;
     IF F.COMECO = NIL THEN
        F.COMECO := T;
     T := NIL;
END;

(************ PROCEDURE RETIRA ELEMENTO DA FILA *************************)
PROCEDURE RETIRA ( VAR X,Y : INTEGER; VAR F : PONTAS);
BEGIN
     IF F.COMECO = NIL THEN
        OUTTEXTXY (100, 50,'FILA ESTA VAZIA')
     ELSE
         BEGIN
              T := F.COMECO;
              X := T^.X;
              Y := T^.Y;
              F.COMECO := F.COMECO^.SEGUINTE;
              T^.SEGUINTE := NIL;
              DISPOSE (T);
              IF F.COMECO = NIL THEN
                 F.TERMINO := NIL ;
         END;
END;

(********************* PRINCIPAL VISUALIZACAO **************************)
BEGIN
     INICIO(F);
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
                OUTTEXTXY (170, 10, '>>>>>>> VISUALIZACAO DA ARVORE <<<<<<<');
                TAMA := TAMANHO;
                CONT := 1;
                X       := 320;
                Y       := 60;
                R       := 16;
                ESPACO  := 10;
                ESPA    := 40;
                INSERCAO (X, Y, F);
                CIRCLE (X, Y, R);
                STR (VETOR[CONT],NUM);
                OUTTEXTXY (X-14,Y,NUM);
                WHILE CONT < TAMANHO  DO
                      BEGIN
                         CONT := CONT + 1;
                         RETIRA (X, Y, F);
                         IF (CONT=1) OR (CONT=2) OR (CONT=4) OR (CONT=8) OR (CONT=16) OR (CONT=32) then
                            BEGIN
                                ESPACO := ESPACO+ESPACO;
                                XX := X - ESPACO;
                            END
                         ELSE
                            IF (CONT=3) OR (CONT=6) OR (CONT=12) OR (CONT=24) OR (CONT=48) THEN
                                XX := X
                            ELSE
                               IF (cont = 10) OR (CONT=21) OR (CONT=22) THEN
                                   XX := X - ESPA
                               ELSE
                                   IF (CONT = 18) THEN
                                      XX := X - (3 * ESPA)
                                   ELSE
                                       IF (CONT = 20) THEN
                                          XX := X - (2 * ESPA)
                                       ELSE
                                            IF (CONT = 28) THEN
                                                    XX := X + (2 * ESPA)
                                             ELSE
                                                 IF CONT = 30 THEN
                                                       XX := X + (3 * ESPA)
                                                  ELSE
                                                       XX := X + ESPA;

                         YY := Y + 75;
                         CIRCLE (XX, YY, R);
                         LINE (X, Y + R, XX, YY - R);
                         STR (VETOR[CONT], NUM);
                         OUTTEXTXY (XX - 14, YY - 3, NUM);
                         INSERCAO (XX, YY, F);
                         IF CONT < TAMANHO THEN
                            BEGIN
                                 XXX := XX + ESPA;
                                 YYY := YY;
                                 LINE (X, Y + R, XXX, YYY - R);
                                 CIRCLE (XXX, YYY, R);
                                 CONT := CONT + 1;
                                 STR (VETOR[CONT], NUM);
                                 OUTTEXTXY (XXX - 14, YYY - 3, NUM);
                                 INSERCAO (XXX, YYY, F);
                             END;
                     END;
               RECTANGLE (300, 434, 635, 454);
               OUTTEXTXY (300 + 10, 442, 'Pressione Qualquer Tecla Para Continuar!');
               CHAVE := READKEY;
           END;
END;

(***************** PROCEDIMENTO DE FIM ***************************)
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
              OUTTEXTXY (215, 175, 'Para sair pressione "esc"');
              T := READKEY;
         END;
    OUTTEXTXY (215, 190, 'CONFIRMA SAIDA? (S/N)');
    FINAL := READKEY;
    FINAL := UPCASE (FINAL);
    TECLA := ENTER;
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

(******************* PROCEDURE DE BARRA **********************)
PROCEDURE BARRA;
BEGIN
     SETFILLSTYLE (1, 13);
     BAR (175, L - 12, 445, L + 12);
     SETCOLOR (0);
     RECTANGLE (177, L - 10, 443, L + 10);
     OUTTEXTXY (200, L, NMO[N]);
END;

(******************** BARRA DO MENU **************************)
PROCEDURE PARACIMA(VAR N: INTEGER);
BEGIN
     IF L = 130  THEN
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

(********************* PROGRAMA PRINCIPAL ***********************)
BEGIN
     GD := DETECT;
     INITGRAPH (GD,GM,'C:\COMPILA\pascal70\BGI');

(***************** INICIALIZACAO DO MENU ************************)
     L := 130;
     N := 1;

     TAMANHO := 32;

     VETOR[1] := 1;
     VETOR[2] := 2;
     VETOR[3] := 3;
     VETOR[4] := 4;
     VETOR[5] := 5;
     VETOR[6] := 6;
     VETOR[7] := 7;
     VETOR[8] := 8;
     VETOR[9] := 9;
     VETOR[10] := 10;
     VETOR[11] := 11;
     VETOR[12] := 12;
     VETOR[13] := 13;
     VETOR[14] := 14;
     VETOR[15] := 15;
     VETOR[16] := 16;
     VETOR[17] := 17;
     VETOR[18] := 18;
     VETOR[19] := 19;
     VETOR[20] := 20;
     VETOR[21] := 21;
     VETOR[22] := 22;
     VETOR[23] := 23;
     VETOR[24] := 24;
     VETOR[25] := 25;
     VETOR[26] := 26;
     VETOR[27] := 27;
     VETOR[28] := 28;
     VETOR[29] := 29;
     VETOR[30] := 30;
     VETOR[31] := 31;
     VETOR[32] := 32;

     CLEARDEVICE;
     BARRA_EXT;
     BARRA_INT1;
     ITENS;
     BARRA;
     FINAL := 'N';
     REPEAT
          TECLA := READKEY;
          IF (TECLA = ENTER) AND (FINAL <>'S')THEN
             BEGIN
                  OPCAO(N);
                  BARRA_EXT;
                  BARRA_INT1;
                  ITENS;
                  BARRA;
            END;
          CASE ORD(TECLA) OF
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


