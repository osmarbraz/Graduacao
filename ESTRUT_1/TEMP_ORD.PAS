(***************************************************************************)
(**     Trabalho de Estrutura de dados I solicitado pela professora       **)
(**     Patricia Milaneze                                                 **)
(**     Alunos                                                            **)
(**             Lusicler de Souza Molon  - 3920                           **)
(**             Angelica Kemper          - 7016                           **)
(**             Siliane Dagostin         - 6709                           **)
(**             Ricardo Cachoeira        - 10386                          **)
(**                                                                       **)
(***************************************************************************)

PROGRAM METODOS_DE_ORDENACAO;
USES GRAPH, CRT, DOS;

TYPE
    VET        = ARRAY [1..4] OF STRING;
    VETOR_TIPO = ARRAY [1..3000] OF WORD;

CONST
     CIMA   = 72;
     BAXO   = 80;
     DIRE   = 77;
     ESQU   = 75;
     ESC    = #27;
     ENTER  = #13;
     BS     = #08;
VAR
   VETOR                                     : VETOR_TIPO;
   T, TECLA, FINAL                           : CHAR;
   GD, GM, X, L, N, TAMANHO                  : INTEGER;
   NMO                                       : VET ;
   COMPA1,COMPA2,COMPA3                      : LONGINT;
   TROCA1,TROCA2,TROCA3                      : LONGINT;

PROCEDURE BARRA_EXT;
BEGIN
    SETFILLSTYLE (10, 15);
    BAR (1, 1, 640, 459);

    SETCOLOR (15);
    RECTANGLE (2, 2, 639, 459);
END;

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

(************************ ITENS DO MENU DE BARRA *********************)

PROCEDURE ITENS;
BEGIN
     NMO[1] := ('1 - Apresentacao.');
     NMO[2] := ('2 - Inclusao do Vetor.');
     NMO[3] := ('3 - Tempo para ordenacao.');
     NMO[4] := ('4 - Saida para S.O.');
     SETCOLOR (12);
     OUTTEXTXY (200, 130, NMO[1]);
     OUTTEXTXY (200, 160, NMO[2]);
     OUTTEXTXY (200, 190, NMO[3]);
     OUTTEXTXY (200, 220, NMO[4]);
END;

(****************************** APRESENTACAO  ************************)

PROCEDURE APRESENTACAO;
BEGIN
     T := ' ';
(*     WHILE T <> ESC DO*)
          BEGIN
               SETFILLSTYLE (1, 11);
               BAR (100, 175, 540, 425);
               SETCOLOR (0);
               RECTANGLE (103, 178, 537, 422);
               OUTTEXTXY (130, 200, '  >>>>  TRABALHO DE ESTRUTURA DE DADOS I <<<<');
               OUTTEXTXY (130, 220, '  Solicitado pelo Professora Patricia Milaneze');
               LINE (360, 230, 505, 230);
               OUTTEXTXY (130, 270, '          Angelica Kemper - CCP 7016 ');
               OUTTEXTXY (130, 300, '       Lusicler de Souza Molon - CCP 3920 ');
               OUTTEXTXY (130, 330, '        Ricardo Cachoeira - CCP 10386 ');
               OUTTEXTXY (130, 360, '          Siliane Dagostin - CCP 6709 ');
               RECTANGLE (135, 400, 505, 415);
               OUTTEXTXY (130, 405, '  Tecle ESC para voltar para o menu principal');
               T := READKEY;
               T := UPCASE (T);
           END
END;

(********************* INCLUSAO DO VETOR *****************************)
PROCEDURE INCLUSAO;
VAR
   CHAVE                      : CHAR;
   TAM                        : ARRAY [1..256] OF CHAR;
   N, ERRO, X, XX, XX1        : INTEGER;
   X1, X2, Y1, Y2, Y, VALOR   : INTEGER;
   TAMA,NUMERO                : STRING[20];
   VETO                       : VETOR_TIPO;
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
                OUTTEXTXY (X, 51, '_');
                TAM[N] := READKEY;
(***************** LEITURA DO TAMANHO DO VETOR **********************)
                WHILE TAM[N] <> ENTER DO
                   BEGIN
                        IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                           OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                           OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                           OR (TAM[N]='0') THEN
                           BEGIN
                                BAR (X-2, 57 , X + 9, 60 );
                                OUTTEXTXY (X, 50, TAM[N]);
                                X := X + 10;
                                OUTTEXTXY (X, 51, '_');
                           END;

                        IF TAM[N] = BS THEN
                           BEGIN
                                IF X <= 250 then
                                   BEGIN
                                         X := 250;
                                   END
                                ELSE
                                    BEGIN
                                         X := X - 10;
                                         BAR (X  , 40, 600, 60);
                                         DELETE (TAMA, N-1, N);
                                         OUTTEXTXY (X , 50, '_');
                                         N := N - 1;
                                         TAMA[N] := ' ';
                                    END;
                           END
                        ELSE
                            IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                               OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                               OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                               OR (TAM[N]='0') THEN
                                  BEGIN
                                       TAMA :=  CONCAT (TAMA, TAM[N]);
                                       N := N + 1;
                                  END;

                         TAM[N] := READKEY;
                    END;


(******************* DESENHA OS RETANGULOS DO VETOR ******************)

                 VAL (TAMA, TAMANHO, ERRO);
                 X1 := 17;   X2 := 77;
                 Y1 := 70;   Y2 := 100;
                 FOR X:= 1 TO TAMANHO  DO
                     BEGIN
                          SETCOLOR (0);
                          RECTANGLE (X1, Y1, X2, Y2);
                          STR (X, NUMERO);
                          OUTTEXTXY (X1 + 27, Y1 + 35 ,NUMERO);
                          X1 := X1 + 60;
                          X2 := X2 + 60;
                          IF X2 > 640 THEN
                             BEGIN
                                  Y1 := Y1 + 60;   Y2 := Y2 + 60;
                                  X1 := 17;        X2 := 77;
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
                                        X  := X + 9;
                                   END;
                               IF (TAM[N] = BS) THEN
                                  BEGIN
                                       XX  := X;
                                       XX1 := XX;
                                  END;
                               IF (TAM[N] = BS) AND (X > 30) THEN
                                  BEGIN
                                       IF X < 30 THEN
                                          X:= 30
                                       ELSE
                                           BEGIN
                                                XX1 := XX1 + 4;
                                                SETFILLSTYLE (1, 11);
                                                BAR (XX - 9, Y1 - 5, XX1 + 4, Y1 + 10);
                                                DELETE (TAMA, N-1, N);
                                                N := N - 1;
                                                X := X - 9;
                                           END
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
                          X1 := (N-2) * 9;
                          X  := X - X1;
                          X  := X + 51;
                          IF X > 570 THEN
                             BEGIN
                                  X := 30;
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

(******************** PROCEDURE ORDENA METODOS ***************************)
PROCEDURE ORDENACAO;
VAR
   TEMPO1, TEMPO2, TEMPO3, TEMPO4, TEMPO5 : STRING;

(**************** PROCEDURE MANIPULACAO DO TEMPO ***********************)

PROCEDURE TEMPOEXE(VAR TEMPO : STRING; VAR HORE, MINE, SEGUE, CSEGE: WORD);
CONST
    DP = ':';
VAR
   HORA, MINUTO, SEGUNDOS, CENTESIMOS: STRING;
BEGIN
     TEMPO      := '';
     HORA       := '';
     MINUTO     := '';
     SEGUNDOS   := '';
     CENTESIMOS := '';
     STR (HORE, HORA);
     STR (MINE, MINUTO);
     STR (SEGUE, SEGUNDOS);
     STR (CSEGE, CENTESIMOS);
     TEMPO := CONCAT(HORA, DP, MINUTO, DP, SEGUNDOS, DP, CENTESIMOS);
     HORE  := 0;
     MINE  := 0;
     SEGUE := 0;
     CSEGE := 0;
END;

(************************* PROCEDURE BOLHA ******************************)
PROCEDURE BOLHA(VAR TEMPO1 : STRING);
VAR
    VE                                     : VETOR_TIPO;
    LSUP, BOLHA, J, AUX                    : INTEGER;
    HOR, MIN, SEGU, CSEG                   : WORD;
BEGIN
     VE   := VETOR;
     LSUP := TAMANHO;
     SETTIME (0,0,0,0);
     COMPA1 := 0;
     TROCA1 := 0;
     REPEAT
           BOLHA := 0;
           FOR J:= 1 TO LSUP-1 DO
           BEGIN
              COMPA1 := COMPA1 + 1;
              IF VE[J] > VE[J+1] THEN
                 BEGIN
                      TROCA1 := TROCA1 + 1;
                      AUX     := VE[J];
                      VE[J]   := VE[J+1];
                      VE[J+1] := AUX;
                      BOLHA   := J;
                 END;
            END;
           LSUP := BOLHA;
     UNTIL LSUP <= 1;
     GETTIME (HOR, MIN, SEGU, CSEG);
     TEMPOEXE(TEMPO1, HOR, MIN, SEGU, CSEG);
END;

(*********************** PROCEDURE SELECAO DIRETA ************************)

PROCEDURE SELECAO_DIRETA(VAR TEMPO2 : STRING);
VAR
   J, I, INDICE, MENOR, AUX, M         : INTEGER;
   VE                                  : VETOR_TIPO;
   HOR, MIN, SEGU, CSEG                : WORD;
BEGIN
     VE := VETOR;
     M  := TAMANHO;
     SETTIME (0,0,0,0);
     COMPA2 := 0;
     TROCA2 := 0;
     FOR J := 1 TO (M-1) DO
         BEGIN
              MENOR := VE[J];
              INDICE := J;
              FOR I := (J+1) TO M DO
                  BEGIN
                  COMPA2 := COMPA2 + 1;
                  IF MENOR > VE[I] THEN
                     BEGIN
                          INDICE := I;
                     END;
                  END;
              TROCA2 := TROCA2 + 1;
              AUX        := VE[INDICE];
              VE[INDICE] := VE[J];
              VE[J]      := AUX;
         END;
    GETTIME (HOR, MIN, SEGU, CSEG);
    TEMPOEXE(TEMPO2, HOR, MIN, SEGU, CSEG);
END;

(**************************** PROCEDURE QUICKSORT *************************)

PROCEDURE QUICKSORT (VAR TEMPO3: STRING);
VAR
  I, CONT                  : INTEGER;
  A, VE                    : VETOR_TIPO;
  HOR, MIN, SEGU, CSEG     : WORD;

PROCEDURE QUICK(VAR ITEM: VETOR_TIPO; CONT:INTEGER);

PROCEDURE PARCIALSORT(ESQU, DIRE: INTEGER; VAR A: VETOR_TIPO);
VAR
  I, J, K, C           : INTEGER;

BEGIN
    K := A[(ESQU + DIRE) DIV 2];
    I := ESQU;
    J := DIRE;
    REPEAT
         WHILE A[I] < K DO
            INC(I);
         WHILE K < A[J] DO
            DEC(J);
         IF I <= J THEN
            BEGIN
                COMPA3 := COMPA3 + 1;
                IF A[I] <> A[J] THEN
                  BEGIN
                     TROCA3 := TROCA3 + 1;
                     C    := A[I];
                     A[I] := A[J];
                     A[J] := C;
                  END;
                INC(I);
                DEC(J);
            END;
    UNTIL I>J;
    IF ESQU < J THEN
       PARCIALSORT (ESQU, J, A);
    IF I < DIRE THEN
       PARCIALSORT (I, DIRE, A);
END;

BEGIN
    COMPA3 := 0;
    TROCA3 := 0;
    PARCIALSORT (1, CONT, ITEM);
    GETTIME (HOR, MIN, SEGU, CSEG);
    TEMPOEXE (TEMPO3, HOR, MIN, SEGU, CSEG);
END;

BEGIN
    CONT := TAMANHO;
    VE   := VETOR;
    SETTIME (0,0,0,0);
    QUICK (VE, CONT);
END;

(************************* PROCEDURE DE ORDENACAO ************************)
VAR
   CHAVE          : CHAR;
   NUMERO,NUMERO1        : STRING[10];
BEGIN
     CHAVE := 'N';
     WHILE CHAVE = 'N' DO
           BEGIN
                CLEARDEVICE;
                SETFILLSTYLE (1, 11);
                BAR (1, 10, 640, 460);
                SETCOLOR (0);
                RECTANGLE (2, 13, 638, 457);
                BAR (135, 1, 502, 20);
                RECTANGLE (137, 3, 500, 25);
                OUTTEXTXY (152, 10, '>>>>>>> TEMPO GASTO PARA ORDENACAO <<<<<<<');

                OUTTEXTXY (50, 90, 'Vetor de Tamanho = ');
                STR (TAMANHO, NUMERO);
                OUTTEXTXY (200, 90, NUMERO);
                OUTTEXTXY (250, 110, 'Tempo de Ordenacao');
                OUTTEXTXY (430, 110, 'Comparacoes');
                OUTTEXTXY (550, 110, 'Trocas');

                BOLHA (TEMPO1);
                OUTTEXTXY (60, 150, 'METODO DA BOLHA => ');
                OUTTEXTXY (300,150, TEMPO1);
                STR (COMPA1, NUMERO);
                OUTTEXTXY (450, 150, NUMERO);
                STR (TROCA1, NUMERO);
                OUTTEXTXY (550, 150, NUMERO);

                SELECAO_DIRETA (TEMPO2);
                OUTTEXTXY (60, 210, 'METODO DA SELECAO DIRETA => ');
                OUTTEXTXY(300, 210, TEMPO2);
                STR (COMPA2, NUMERO);
                OUTTEXTXY (450, 210, NUMERO);
                STR (TROCA2, NUMERO);
                OUTTEXTXY (550, 210, NUMERO);

                QUICKSORT (TEMPO3);
                OUTTEXTXY (60, 270, 'METODO DE QUICKSORT => ');
                OUTTEXTXY (300, 270, TEMPO3);
                STR (COMPA3, NUMERO);
                OUTTEXTXY (450, 270, NUMERO);
                STR (TROCA3, NUMERO);
                OUTTEXTXY (550, 270, NUMERO);

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
              RECTANGLE (108, 148, 517, 223);
              OUTTEXTXY (215, 175,'Para sair pressione "esc"');
              T := READKEY;
         END;
    OUTTEXTXY (215, 190,'CONFIRMA SAIDA? (S/N)');
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
        3    :  ORDENACAO;
        4    :  FIM;
     END;
END;

(******************* PROCEDURE DE BARRA **********************)
PROCEDURE BARRA;
BEGIN
     SETFILLSTYLE (1, 13);
     BAR (175, L-12, 445, L+12);
     SETCOLOR (0);
     RECTANGLE (177, L-10, 443, L+10);
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

PROCEDURE PARABAIXO (VAR N:INTEGER);
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
     INITGRAPH (GD,GM,'C:\COMPILA\PASCAL7\BGI');

(***************** INICIALIZACAO DO MENU ************************)
     L := 130;
     N := 1;

(******************** CRIA VETOR RANDOMICO ***********************)
     TAMANHO := 3000;
     RANDOMIZE;
     FOR X:= 1 TO TAMANHO do
       VETOR[X] := RANDOM(9999);

     CLEARDEVICE;
     BARRA_EXT;
     BARRA_INT1;
     ITENS;
     BARRA;
     APRESENTACAO;
     BARRA_EXT;
     BARRA_INT1;
     ITENS;
     BARRA;
     FINAL := 'N';

     REPEAT
          TECLA := READKEY;
          IF (TECLA = ENTER) and (FINAL<>'S')THEN
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
              51        :   BEGIN
                                 ORDENACAO;
                                 BARRA_EXT;
                                 BARRA_INT1;
                                 ITENS;
                                 BARRA;
                             END;
              52        :    BEGIN
                                 FIM;
                                 BARRA_EXT;
                                 BARRA_INT1;
                                 ITENS;
                                 BARRA;
                             END;
          END;
          UNTIL (FINAL = 'S');
    CLOSEGRAPH;
END.