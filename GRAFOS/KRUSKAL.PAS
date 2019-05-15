(**************************************************************************)
(* UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL                26/07/95 *)
(* CURSO DE CIENCIAS DA COMPUTACAO - 6 SEMESTRE                           *)
(* TRABALHO DA DISCIPLINA DE TEORIA DE GRAFO, SOLICITADO PELO             *)
(* PROFESSOR SALOMAO WESTPHAL SANDRINI                                    *)
(* OBJETIVO OBTER A ARVORE MINIMA ATRAVES DO ALGORITMO DE KRUSKAL         *)
(* ACADEMICOS : ALEXSSANDRO CARDO ANTUNES                                 *)
(*              LUSICLER DE SOUZA MOLON                                   *)
(*              OSMAR DE OLIVEIRA BRAZ JUNIOR                             *)
(**************************************************************************)

PROGRAM KRUSKAL;
USES GRAPH, CRT;

TYPE
    VET      = ARRAY [1..4] OF STRING;
    ARRN     = ARRAY [1..1000] OF INTEGER;
    ARRN1    = ARRAY [1..1000] OF INTEGER;
    ARRM     = ARRAY [1..1000] OF INTEGER;


CONST
     CIMA   = 72;
     BAXO   = 80;
     DIRE   = 77;
     ESQU   = 75;
     ESC    = #27;
     ENTER  = #13;
     BS     = #08;

VAR
    VERTICE, SUCESSOR, VALOR                  : INTEGER;
    ENDV1, ENDV2, WEIGHT,TRANS1,TRANS2,TRANSW : ARRM;
    TEDGE1, TEDGE2                            : ARRN1;
    CONNECT                                   : BOOLEAN;
    TWEIGHT, NN, MM, TRANSNN, TRANSMM         : INTEGER;

    GD, GM,  L, N                             : INTEGER;
    T, FINAL, TECLA1                          : CHAR;
    NMO                                       : VET ;

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
     NMO[2] := ('2 - Inclusao do Grafo de Suporte.');
     NMO[3] := ('3 - Arvore Parcial de Valor Minimo.');
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
              SetTextJustify(LeftText, CenterText);
              SetTextStyle(TriplexFont, HORIZDir, 3);
              OUTTEXTXY (70, 190, '     TRABALHO DE TEORIA DE GRAFOS');
              SetTextStyle(DEFAULTFONT, HORIZDir, 0);
              OUTTEXTXY (130, 220, ' Solicitado pelo Professor Salomao W. Sandrini');
              LINE (340, 230, 500, 230);
              OUTTEXTXY (130, 240, ' Sobre Arvore Parcial de Valor Minimo, Usando ');
              OUTTEXTXY (130, 260, '          o algoritmo de   KRUSKAL ');
              OUTTEXTXY (130, 300, '   Osmar de Oliveira Braz Junior - CCP 8579');
              OUTTEXTXY (130, 330, '      Lusicler de Souza Molon - CCP 3920');
              OUTTEXTXY (130, 360, '    Alexssandro Cardoso Antunes - CCP 8427');
              RECTANGLE (130, 400, 510, 415);
              OUTTEXTXY (125, 410, '  Tecle <ESC> para voltar para o menu principal');
              T := READKEY;
              T := UPCASE (T);
         END;
END;

PROCEDURE APRESENTACAO1;
BEGIN
     T := ' ';
     SETFILLSTYLE (1, 11);
     BAR (80, 85, 570, 385);
     SETCOLOR (0);
     RECTANGLE (83, 88, 567, 382);
     SetTextJustify(LeftText, CenterText);
     SetTextStyle(TriplexFont, HORIZDir, 3);
     OUTTEXTXY (140, 110, 'TRABALHO DE TEORIA DE GRAFOS ');
     SetTextStyle(DEFAULTFONT, HORIZDir, 0);
     OUTTEXTXY (140, 150, ' Solicitado pelo Professor Salomao W. Sandrini');
     LINE (340, 160, 500, 160);
     OUTTEXTXY (140, 180, ' Sobre Arvore Parcial de Valor Minimo, Usando ');
     OUTTEXTXY (140, 200, '          o algoritmo de   KRUSKAL ');
     OUTTEXTXY (140, 250, '   Osmar de Oliveira Braz Junior - CCP 8579');
     OUTTEXTXY (140, 280, '      Lusicler de Souza Molon - CCP 3920');
     OUTTEXTXY (140, 310, '    Alexssandro Cardoso Antunes - CCP 8427');
     RECTANGLE (190, 345, 480, 365);
     OUTTEXTXY (140, 355, '            Pressione qualquer tecla');
     T := READKEY;
END;

(***************************************************************************)
(************** INCLUSAO DOS DADOS DO GRAFO VALORADO   *********************)
PROCEDURE INCLUSAO;
VAR
   CHAVE, CONFIRMA, TECLA                    : CHAR;
   TAM                                       : ARRAY [1..256] OF CHAR;
   N, ERRO, X, Y, XX, XXX, YY, CONT, CONT1   : INTEGER;
   TAMA,NUM                                  : STRING[20];
   AUX                                       : ARRN;
BEGIN
     CLEARDEVICE;
     SETFILLSTYLE (1, 11);
     BAR (1, 10, 640, 460);
     SETCOLOR (0);
     RECTANGLE (4, 13, 632, 457);
     SETFILLSTYLE (1, 11);
     BAR (160, 1, 495, 20);
     RECTANGLE (162, 3, 493, 25);
     OUTTEXTXY (210, 10, '>>>>> INCLUSAO DO GRAFO <<<<<');
     CONT  := 1;
     CONT1 := 1;
     CHAVE := 'N';
     X := 260;
     Y := 70;
     WHILE CHAVE = 'N' DO
           BEGIN
                CONFIRMA := 'C';
                XXX := X;
                YY := Y;

                OUTTEXTXY (10, YY, '    DIGITE O VERTICE INICIAL : ');
                OUTTEXTXY (10, YY + 20, 'DIGITE O SUCESSOR DO VERTICE : ');
                OUTTEXTXY (10, YY + 40, '  DIGITE O VALOR DA  ARESTAS : ');

                WHILE CONFIRMA <> 'E' DO
                BEGIN

(*********************** LEITURA DO NUMERO DE VERTICES *********************)
                     XX     := XXX;
                     N      := 1;
                     TAMA   := '';
                     STR (CONT, NUM);
                     OUTTEXTXY (XX, YY - 15, NUM);

                     OUTTEXTXY (XX, YY, '_');
                     TAM[N] := READKEY;
                     WHILE TAM[N] <> ENTER DO
                         BEGIN
                           IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                              OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                              OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                              OR (TAM[N]='0') THEN
                                BEGIN
                                  BAR (XX, YY - 1, XX + 8, YY + 7);
                                  OUTTEXTXY (XX, YY, TAM[N]);
                                  XX := XX + 10;
                                  OUTTEXTXY (XX, YY, '_');
                                END;

                           IF TAM[N] = BS THEN
                              BEGIN
                                   IF XX <= 260 then
                                      XX := 250
                                   ELSE
                                       BEGIN
                                            BAR (XX, Y + 1, XX + 8, Y + 7);
                                            XX := XX - 10;
                                            BAR (XX, Y - 1, XX + 6, Y + 7);
                                            OUTTEXTXY (XX, YY, '_');
                                            DELETE (TAMA, N - 1, N);
                                            N := N - 1;
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
                     VAL (TAMA, VERTICE, ERRO);
                     BAR (XX, YY + 1, XX + 8, YY + 7);

(******************** LEITURA DO NUMERO DE SUCESSOR ************************)
                     XX     := XXX;
                     YY     := YY + 20;
                     N      := 1;
                     TAMA   := '';
                     OUTTEXTXY (XX, YY, '_');
                     TAM[N] := READKEY;
                     WHILE TAM[N] <> ENTER DO
                           BEGIN
                               IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                                  OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                                  OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                                  OR (TAM[N]='0') THEN
                                  BEGIN
                                    BAR (XX, YY - 1, XX + 8, YY + 7);
                                    OUTTEXTXY (XX, YY, TAM[N]);
                                    XX := XX + 10;
                                    OUTTEXTXY (XX, YY, '_');
                                  END;
                               IF TAM[N] = BS THEN
                                  BEGIN
                                     IF XX <= 260 then
                                        XX := 250
                                     ELSE
                                         BEGIN
                                              BAR (XX, YY + 1, XX + 8, YY + 7);
                                              XX := XX - 10;
                                              BAR (XX, YY - 1, XX + 6, YY + 7);
                                              OUTTEXTXY (XX, YY, '_');
                                              DELETE (TAMA, N - 1, N);
                                              N := N - 1;
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
                    VAL (TAMA, SUCESSOR, ERRO);
                    BAR (XX, YY + 1, XX + 8, YY + 7);

(*********************** LEITURA DO VALOR DA ARESTA    *********************)
                    XX     := XXX;
                    YY     := YY + 20;
                    N      := 1;
                    TAMA   := '';
                    OUTTEXTXY (XX, YY, '_');
                    TAM[N] := READKEY;
                    WHILE TAM[N] <> ENTER DO
                          BEGIN
                               IF (TAM[N]='1') OR (TAM[N]='2') OR (TAM[N]='3')
                                   OR (TAM[N]='4') OR (TAM[N]='5') OR (TAM[N]='6')
                                   OR (TAM[N]='7') OR (TAM[N]='8') OR (TAM[N]='9')
                                   OR (TAM[N]='0') THEN
                                       BEGIN
                                            BAR (XX, YY - 1, XX + 8, YY + 7);
                                            OUTTEXTXY (XX, YY, TAM[N]);
                                            XX := XX + 10;
                                            OUTTEXTXY (XX, YY, '_');
                                       END;
                               IF TAM[N] = BS THEN
                                  BEGIN
                                       IF XX <= 260 then
                                          XX := 250
                                       ELSE
                                           BEGIN
                                                 BAR (XX, YY + 1, XX + 8, YY + 7);
                                                 XX := XX - 10;
                                                 BAR (XX, YY - 1, XX + 6, YY + 7);
                                                 OUTTEXTXY (XX, YY, '_');
                                                 DELETE (TAMA, N - 1, N);
                                                 N := N - 1;
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
                          VAL (TAMA, VALOR, ERRO);
                          BAR (XX, YY + 1, XX + 8, YY + 7);

(********************* CONFIRMA, ENCERRAR OU ANULA ************************)
                          RECTANGLE (30, 434, 330, 454);
                          OUTTEXTXY (40, 442, 'CONFIRMA(C), ANULA(A), ENCERRA(E) ?');
                          TECLA := 'S';
                          WHILE TECLA <> 'N' DO
                               BEGIN
                                    CONFIRMA := READKEY;
                                    CONFIRMA := UPCASE (CONFIRMA);
                                    IF (CONFIRMA = 'C') OR (CONFIRMA ='A') OR (CONFIRMA ='E') OR (CONFIRMA = ENTER) THEN
                                       TECLA := 'N'
                                    ELSE
                                       TECLA := 'S';
                               END;
                         BAR (30, 434, 330, 454);

                         ENDV1[CONT] := VERTICE;
                         ENDV2[CONT] := SUCESSOR;
                         WEIGHT[CONT] := VALOR;
                         CONT := CONT + 1;
                         IF (CONFIRMA = 'C') OR (CONFIRMA = ENTER) THEN
                            BEGIN
                                 XXX := XXX + 35;
                                 YY := Y;
                            END
                         ELSE
                             IF CONFIRMA= 'A' THEN
                                BEGIN
                                     BAR (XX - 20, YY - 45, XX + 20, YY + 10);
                                     XX := XXX;
                                     YY := Y;
                                     CONT := CONT - 1;
                                END
                             ELSE
                                 IF CONFIRMA= 'E' THEN
                                    BEGIN
                                         CHAVE := 'S';
                                    END;
                         IF ((CONT = 11) AND (CONFIRMA <> 'A')) OR
                            ((CONT = 21) AND (CONFIRMA <> 'A')) OR
                            ((CONT = 31) AND (CONFIRMA <> 'A')) THEN
                            BEGIN
                                 Y := Y + 80;
                                 XXX := X;
                                 CONFIRMA := 'E';
                            END;
                         IF CONT > 40 THEN
                            BEGIN
                                 CONFIRMA := 'E';
                                 CHAVE := 'S';
                            END;
                END;
                    IF CHAVE = 'S' THEN
                       BEGIN
                            RECTANGLE (360, 434, 550, 454);
                            OUTTEXTXY (370, 442,'CONFIRMA DADOS (S/N) ?');
                            CHAVE := READKEY;
                            CHAVE := UPCASE(CHAVE);
                            IF CHAVE = 'S' THEN
                               CONFIRMA := 'E'
                            ELSE
                                BEGIN
                                     CLEARDEVICE;
                                     SETFILLSTYLE (1, 11);
                                     BAR (1, 10, 640, 460);
                                     SETCOLOR (0);
                                     RECTANGLE (4, 13, 632, 457);
                                     SETFILLSTYLE (1, 11);
                                     BAR (160, 1, 495, 20);
                                     RECTANGLE (162, 3, 493, 25);
                                     OUTTEXTXY (210, 10, '>>>>> INCLUSAO DO GRAFO <<<<<');
                                     CONT := 1;
                                     CHAVE := 'N';
                                     X := 260;
                                     Y := 70;
                                 END;
                       END;

           END;
     FOR X := 1 TO MM DO
         BEGIN
              AUX[X] := ENDV1[X];
         END;
     FOR X:= MM+1 TO MM + MM DO
         BEGIN
              AUX[X] := ENDV2[X];
         END;
    XX := 0;
    CONT1 := 1;
    FOR X:= 1 TO MM DO
        FOR Y:= 1 TO MM + MM DO
            IF (X = AUX[Y]) AND (X <> XX) THEN
               BEGIN
                    XX := X;
                    CONT1 := CONT1 + 1;
               END;
    NN := CONT1;
    MM := CONT -1;
END;

(***************************************************************************)
(***************************** SOLUCAO DO GRAFO ****************************)
PROCEDURE SOLUCAO;
VAR
   NUM              : STRING;
   COL, XX, YY      : INTEGER;
   KEY              : BOOLEAN;

PROCEDURE KRUSKAL(
          NN, MM                                     : INTEGER;
          VAR ENDV1, ENDV2, WEIGHT                   : ARRM;
          VAR CONNECT                                : BOOLEAN;
          VAR TEDGE1, TEDGE2                         : ARRN1;
          VAR TWEIGHT                                : INTEGER);
VAR
   I, LAST, U, V, R1, R2, ECOUNT, TCOUNT  : INTEGER;
   FATHER                                 : ARRN;

PROCEDURE HEAP (FIRST, LAST : INTEGER);
VAR
   J, K, TEMP1, TEMP2, TEMP3 : INTEGER;

BEGIN
     J := FIRST;
     WHILE J <= TRUNC (LAST / 2) DO
           BEGIN
                IF (2 * J < LAST) AND (WEIGHT[2*J+1] < WEIGHT[2*J]) THEN
                   K := 2 * J + 1
                ELSE
                    K := 2 * J;
                IF WEIGHT[K] < WEIGHT[J] THEN
                BEGIN
                     TEMP1     := ENDV1[J];
                     TEMP2     := ENDV2[J];
                     TEMP3     := WEIGHT[J];
                     ENDV1[J]  := ENDV1[K];
                     ENDV2[J]  := ENDV2[K];
                     WEIGHT[J] := WEIGHT[K];
                     ENDV1[K]  := TEMP1;
                     ENDV2[K]  := TEMP2;
                     WEIGHT[K] := TEMP3;
                     J         := K;
                END
                ELSE
                    J := LAST;
           END; (*WHILE*)
END; (* HEAP *)

FUNCTION FIND(I : INTEGER) : INTEGER;
VAR
   PTR : INTEGER;
BEGIN
     PTR := I;
     WHILE FATHER[PTR] > 0 DO
           PTR := FATHER[PTR];
     FIND:= PTR;
END; (*FIND*)

PROCEDURE UNION(I,J: INTEGER);
VAR
   X : INTEGER;
BEGIN
     X := FATHER[I] + FATHER[J];
     IF FATHER[I] > FATHER[J] THEN
     BEGIN
          FATHER[I] := J;
          FATHER[J] := X;
     END
     ELSE
     BEGIN
          FATHER[J] := I;
          FATHER[I] := X;
     END;
END; (*UNION*)

BEGIN
     FOR I := 1 TO NN DO
         FATHER[I] := -1;
     FOR I := TRUNC(MM/2) DOWNTO 1 DO
         HEAP(I,MM);
     LAST := MM;
     ECOUNT := 0;
     TCOUNT := 0;
     TWEIGHT := 0;
     CONNECT := TRUE;
     WHILE ((TCOUNT< NN-1) AND (ECOUNT < MM)) DO
     BEGIN
          ECOUNT := ECOUNT + 1;
          U := ENDV1[1];
          V := ENDV2[1];
          R1 := FIND(U);
          R2 := FIND(V);
          IF R1 <> R2 THEN
          BEGIN
               TCOUNT := TCOUNT + 1;
               UNION (R1, R2);
               TEDGE1[TCOUNT] := U;
               TEDGE2[TCOUNT] := V;
               TWEIGHT := TWEIGHT + WEIGHT[1]
          END;
          ENDV1[1] := ENDV1[LAST];
          ENDV2[1] := ENDV2[LAST];
          WEIGHT[1] := WEIGHT[LAST];
          LAST := LAST - 1;
          HEAP (1 ,LAST);
     END; (*WHILE*)
     IF TCOUNT <> NN - 1 THEN
        CONNECT := FALSE
END; (*KRUSKAL*)

BEGIN
     T := ' ';
     WHILE T <> ESC DO
         BEGIN
              CLEARDEVICE;
              SETFILLSTYLE (1, 11);
              BAR (1, 10, 640, 460);
              SETCOLOR (0);
              RECTANGLE (4, 13, 632, 457);
              SETFILLSTYLE (1, 11);
              BAR (160, 1, 495, 20);
              RECTANGLE (162, 3, 493, 25);
              OUTTEXTXY (210, 10, '>>>>> SOLUCAO DO GRAFO <<<<<');
              OUTTEXTXY (30, 70, 'GRAFO SUPORTE');
              COL := 30;
              YY  := 100;
              FOR XX:= 1 TO MM DO
                  BEGIN
                       STR (ENDV1[XX], NUM);
                       OUTTEXTXY (COL, YY, NUM);
                       STR (ENDV2[XX], NUM);
                       OUTTEXTXY (COL, YY + 15, NUM);
                       STR (WEIGHT[XX], NUM);
                       OUTTEXTXY (COL, YY + 30, NUM);
                       COL := COL + 30;
                       IF (XX = 20) THEN
                          BEGIN
                               YY := YY + 50;
                               COL := 30;
                          END;
                  END;
              COL := 30;
              OUTTEXTXY (COL,YY + 50,'NUMERO DE VERTICES = ');
              STR (NN, NUM);
              OUTTEXTXY (COL + 170 ,YY + 50, NUM);
              OUTTEXTXY (COL + 230 ,YY + 50, 'NUMERO DE ARESTAS = ');
              STR (MM, NUM);
              OUTTEXTXY (COL + 390 ,YY + 50, NUM);
              LINE (25, YY + 80, 600, YY + 80);
              OUTTEXTXY (COL , YY + 110, 'ARVORE PARCIAL DE VALOR MINIMO');

              TRANSNN := NN;
              TRANSMM := MM;
              TRANS1  := ENDV1;
              TRANS2  := ENDV2;
              TRANSW := WEIGHT;

              KRUSKAL(TRANSNN, TRANSMM, TRANS1, TRANS2, TRANSW, CONNECT, TEDGE1, TEDGE2, TWEIGHT);

              IF (CONNECT = TRUE) THEN
                 BEGIN
                      COL := 30;
                      FOR XX := 1 TO NN -1 DO
                          BEGIN
                               STR (TEDGE1[XX], NUM);
                               OUTTEXTXY (COL, YY + 140, NUM);
                               STR (TEDGE2[XX], NUM);
                               OUTTEXTXY (COL, YY + 155, NUM);
                               COL := COL + 20;
                               IF (XX = 20) THEN
                                  BEGIN
                                       COL := 30;
                                       YY := YY + 30;
                                  END;
                          END;
                      OUTTEXTXY (30, YY+ 180,'TOTAL DO CAMINHO = ');
                      STR (TWEIGHT, NUM);
                      OUTTEXTXY(180, YY + 180, NUM);
                 END
              ELSE
                  IF (CONNECT = FALSE) THEN
                     BEGIN
                          OUTTEXTXY (COL , YY + 130, '>>> GRAFO DESCONECTO!!! <<<');
                     END;
              RECTANGLE (130, 435, 510, 455);
              OUTTEXTXY (125, 440, '  Tecle <ESC> para voltar para o menu principal');
              T := READKEY;
              T := UPCASE (T);
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
        3    :  SOLUCAO;
        4    :  FIM;
     END;
END;

(******************************************************************)
(********************* PROGRAMA PRINCIPAL *************************)
BEGIN
     GD := DETECT;
     INITGRAPH (GD,GM,'C:\COMPILA\pascal70\BGI ');
(*     INITGRAPH (GD,GM,' ');   *)

(***************** INICIALIZACAO DO MENU ***************************)
     L := 130;
     N := 1;

(************************* EXEMPLO INICIAL ************************)
     NN := 7;
     MM := 11;
     ENDV1[1]:= 1;
     ENDV1[2]:= 1;
     ENDV1[3]:= 2;
     ENDV1[4]:= 2;
     ENDV1[5]:= 2;
     ENDV1[6]:= 3;
     ENDV1[7]:= 3;
     ENDV1[8]:= 4;
     ENDV1[9]:= 4;
     ENDV1[10]:= 5;
     ENDV1[11]:= 6;

     ENDV2[1]:= 2;
     ENDV2[2]:= 3;
     ENDV2[3]:= 3;
     ENDV2[4]:= 4;
     ENDV2[5]:= 7;
     ENDV2[6]:= 4;
     ENDV2[7]:= 5;
     ENDV2[8]:= 5;
     ENDV2[9]:= 6;
     ENDV2[10]:= 6;
     ENDV2[11]:= 7;

     WEIGHT[1] := 43;
     WEIGHT[2] := 27;
     WEIGHT[3] := 28;
     WEIGHT[4] := 20;
     WEIGHT[5] := 24;
     WEIGHT[6] := 26;
     WEIGHT[7] := 14;
     WEIGHT[8] := 19;
     WEIGHT[9] := 18;
     WEIGHT[10] := 24;
     WEIGHT[11] := 22;

     CLEARDEVICE;

     BARRA_EXT;
     APRESENTACAO1;
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
                                 SOLUCAO;
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