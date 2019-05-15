(**************************************************************************)
(*            UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL   18/07/95   *)
(*             CURSO DE CIENCIAS DA COMPUTACAO 6 SEMESTRE                 *)
(*          TRABALHO DA DISCIPLINA DE ESTRUTURA DE DADOS II               *)
(*            SOLICITADO PELO PROFESSOR MARCELO MEDEIROS                  *)
(* OBJETIVO DEMONSTRAR O TEMPO PARA ORDENACAO DE UM VETOR, COMPARANDO SEU *)
(*          TEMPO ENTRE OS METODOS DE ORDENACAO, AQUI UTILIZADOS.         *)
(*            ALUNOS: OSMAR DE OLIVEIRA BRAZ JUNIOR                       *)
(*                    ALEXSSANDRO CARDOSO ANTUNES                         *)
(**************************************************************************)

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
          END
END;

(********************* INCLUSAO DO VETOR *****************************)

PROCEDURE INCLUSAO;
VAR
   CHAVE                      : CHAR;
   TAM                        : ARRAY [1..256] OF CHAR;
   N, ERRO, X, XX, XX1        : INTEGER;
   X1, X2, Y1, Y2, Y, VALOR   : INTEGER;
   TAMA, NUMERO               : STRING[20];
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
                                TAMA :=  CONCAT (TAMA ,TAM[N]);
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
     REPEAT
           BOLHA := 0;
           FOR J:= 1 TO LSUP-1 DO
           BEGIN
              IF VE[J] > VE[J+1] THEN
                 BEGIN
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
     FOR J := 1 TO (M-1) DO
         BEGIN
              MENOR := VE[J];
              INDICE := J;
              FOR I := (J+1) TO M DO
                  IF MENOR > VE[I] THEN
                     BEGIN
                          INDICE := I;
                     END;
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
                IF A[I] <> A[J] THEN
                  BEGIN
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

(**************************** PROCEDURE SHELL ***************************)

PROCEDURE METODOSHELL(VAR TEMPO4: STRING);
VAR
    I, CONT, CONT1         : INTEGER;
    EE, CC                 : VETOR_TIPO;
    HOR, MIN, SEGU, CSEG   : WORD;

PROCEDURE INSDIRSHELL (VAR CC, EE: VETOR_TIPO; VAR I, E1, N :INTEGER);
VAR
  ZZ, R, J, K, CH, ED : INTEGER;

BEGIN
    ZZ := I + I;
    FOR R := (E1 + ZZ) TO N DO
        BEGIN
            K  := E1;
            J  := R-I;
            CH := CC[R];
            ED := EE[R];
            WHILE (J >= E1) AND (K = E1) DO
                 IF CH < CC[J] THEN
                   BEGIN
                       CC[J+I] := CC[J];
                       EE[J+I] := EE[J];
                       J       := J - 1;
                   END
                 ELSE
                     BEGIN
                          K     := J + I;
                          CC[K] := CH;
                          EE[K] := ED;
                     END;
        END;
END;

PROCEDURE SHELL (VAR CC, EE :VETOR_TIPO; VAR N, NP :INTEGER);
VAR
   CONTA, I, J, P : INTEGER;

BEGIN
    FOR P:=NP DOWNTO 1 DO
       BEGIN
           FOR CONTA:=1 TO P DO
               I := I * 2;
           FOR J:=1 TO I DO
               INSDIRSHELL (CC, EE, I, J, N);
        END;
END;

BEGIN
    CONT  := TAMANHO;
    CONT1 := TAMANHO;
    EE    := VETOR;
    CC    := VETOR;
    SETTIME (0,0,0,0);
    SHELL (CC, EE, CONT, CONT1);
    GETTIME (HOR, MIN, SEGU, CSEG);
    TEMPOEXE (TEMPO4, HOR, MIN, SEGU, CSEG);
END;


(*************************** PROCEDURE HEAPSORT *************************)

PROCEDURE HEAPESORT(VAR TEMPO5:STRING);
VAR
  I, CONT                : INTEGER;
  EE, CC                 : VETOR_TIPO;
  HOR, MIN, SEGU, CSEG   : WORD;

FUNCTION VALOR (CC:VETOR_TIPO; ZZZ, I:INTEGER):REAL;
BEGIN
    IF I > ZZZ THEN
         VALOR := ZZZ
    ELSE
         VALOR := CC[I];
END;

PROCEDURE INSEREHEAP(VAR CC, EE: VETOR_TIPO; VAR N, K, N1: INTEGER);
VAR
  I, H, CH ,ED  :INTEGER;
  TROCA         :BOOLEAN;

BEGIN
     I     := K;
     TROCA := TRUE;
     WHILE TROCA DO
         BEGIN
              IF VALOR (CC, N1, 2*I) > VALOR(CC, N1, 2*I+1) THEN
                 H := 2 * I
              ELSE
                 H := 2 * I + 1;

              IF CC[I] < VALOR (CC, N1, H) THEN
                 BEGIN
                     CH    := CC[I];
                     CC[I] := CC[H];
                     CC[H] := CH;
                     ED    := EE[I];
                     EE[I] := EE[H];
                     EE[H] := ED;
                     I     := H;
                 END
              ELSE
                  TROCA:=FALSE;
         END;
END;

PROCEDURE HEAPSORT(VAR CC, EE: VETOR_TIPO; VAR N:INTEGER);
VAR
  I, K, N1, CH, ED, P : INTEGER;

BEGIN
    I := N DIV 2;
    FOR K := I DOWNTO 1 DO
       BEGIN
          INSEREHEAP (CC, EE, N, K, N);
          FOR N1 := N-1 TO 1 DO
             BEGIN
                 CH       := CC[1];
                 CC[1]    := CC[N1+1];
                 CC[N1+1] := CH;
                 P        := 1;
                 INSEREHEAP(CC, EE, N, P, N1);
             END;
       END;
END;

BEGIN
    EE    :=VETOR;
    CC    :=VETOR;
    CONT  :=TAMANHO;
    SETTIME (0,0,0,0);
    HEAPSORT (CC, EE, CONT);
    GETTIME (HOR, MIN, SEGU, CSEG);
    TEMPOEXE (TEMPO5, HOR, MIN, SEGU, CSEG);
END;

(************************* PROCEDURE DE ORDENACAO ************************)
VAR
   CHAVE          : CHAR;

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

                BOLHA (TEMPO1);
                OUTTEXTXY (120, 90, 'METODO DA BOLHA => ');
                OUTTEXTXY (350, 90, TEMPO1);

                SELECAO_DIRETA (TEMPO2);
                OUTTEXTXY (120, 150, 'METODO DA SELECAO DIRETA => ');
                OUTTEXTXY(350, 150, TEMPO2);

                QUICKSORT (TEMPO3);
                OUTTEXTXY (120, 210, 'METODO DE QUICKSORT => ');
                OUTTEXTXY (350, 210, TEMPO3);

                METODOSHELL (TEMPO4);
                OUTTEXTXY (120, 270, 'METODO DE SHELL => ');
                OUTTEXTXY (350, 270, TEMPO4);

                HEAPESORT (TEMPO5);
                OUTTEXTXY (120, 330, 'METODO DE HEAPSORT => ');
                OUTTEXTXY (350, 330, TEMPO5);

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
     INITGRAPH (GD,GM,'C:\COMPILA\PASCAL70\BGI');

(***************** INICIALIZACAO DO MENU ************************)
     L := 130;
     N := 1;

(******************** CRIA VETOR RANDOMICO ***********************)
     TAMANHO := 100;
     RANDOMIZE;
     FOR X:= 1 TO TAMANHO do
       VETOR[X] := RANDOM(99);

     CLEARDEVICE;
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