(**************************************************************************)
(* UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL                21/11/95 *)
(* CURSO DE CIENCIAS DA COMPUTACAO - 7 SEMESTRE                           *)
(* TRABALHO DA DISCIPLINA DE TEORIA SISTEMAS OPERACINAIS, SOLICITADO PELA *)
(* PROFESSORA JUSSARA MARIA BOZZANO                                       *)
(* OBJETIVO SIMULAR O ALGORITMO ROUND ROBIN                               *)
(* ACADEMICOS : ALEXSSANDRO CARDOSO ANTUNES                               *)
(*              LEONARDO BENEDET                                          *)
(*              OSMAR DE OLIVEIRA BRAZ JUNIOR                             *)
(**************************************************************************)

PROGRAM ROUND_ROBIN;
USES GRAPH, CRT;

TYPE
    VET      = ARRAY [1..4] OF STRING;
    PROCESSOS = RECORD
                     ENTRADA : INTEGER;
                     CPU     : INTEGER;
                     INDICE  : INTEGER;
                     NOME    : STRING[5];
                END;
    PROCESSO = ARRAY[1..100] OF PROCESSOS;

CONST
     CIMA   = 72;
     BAXO   = 80;
     DIRE   = 77;
     ESQU   = 75;
     ESC    = #27;
     ENTER  = #13;
     BS     = #08;

VAR
    NOME_PROCESSO                                   : STRING[5];
    TEMPO_CPU, TEMPO_ENTRADA                        : INTEGER;
    PROC, PROC1                                     : PROCESSO;
    AUX                                             : PROCESSOS;
    NUMERO_PROCESSOS, X, Y, QUANTUM, PRIMEIRO       : INTEGER;
    CONT,AUX1                                       : INTEGER;
    FEITO                                           : BOOLEAN;
    GD, GM, L, N, NN                                : INTEGER;
    T, FINAL, TECLA1                                : CHAR;
    NMO                                             : VET;

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
     NMO[2] := ('2 - Inclusao dos Processos.');
     NMO[3] := ('3 - Execucao dos Processos.');
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
              OUTTEXTXY (70, 190, '          SISTEMAS OPERACIONAIS');
              SetTextStyle(DEFAULTFONT, HORIZDir, 0);
              OUTTEXTXY (130, 220, 'Solicitado pela Professora Jussara Maria Bozzano');
              LINE (340, 230, 515, 230);
              OUTTEXTXY (130, 240, ' Simulado o Escalonamento de Processos, Usando ');
              OUTTEXTXY (130, 260, '                   Round-Robin ');
              OUTTEXTXY (130, 300, '   Osmar de Oliveira Braz Junior - CCP 8579');
              OUTTEXTXY (130, 330, '          Leonardo Benedet - CCP ');
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
     OUTTEXTXY (140, 110, '    SISTEMAS OPERACIONAIS');
     SetTextStyle(DEFAULTFONT, HORIZDir, 0);
     OUTTEXTXY (140, 150, ' Solicitado pela Professora Jussara Maria Bozzano');
     LINE (355, 160, 535, 160);
     OUTTEXTXY (140, 180, ' Simulando Escalonamento de Processos, Usando ');
     OUTTEXTXY (140, 200, '                   Round-Robin');
     OUTTEXTXY (140, 250, '   Osmar de Oliveira Braz Junior - CCP 8579');
     OUTTEXTXY (140, 280, '          Leonardo Benedet - CCP ');
     OUTTEXTXY (140, 310, '    Alexssandro Cardoso Antunes - CCP 8427');
     RECTANGLE (190, 345, 480, 365);
     OUTTEXTXY (140, 355, '            Pressione qualquer tecla');
     T := READKEY;
END;

(***************************************************************************)
(*********************** INCLUSAO DOS PROCESSOS   **************************)
PROCEDURE INCLUSAO;
VAR
   CHAVE, CONFIRMA, TECLA                    : CHAR;
   TAM                                       : ARRAY [1..256] OF CHAR;
   N, ERRO, X, Y, XX, XXX, YY, CONT, CONT1   : INTEGER;
   TAMA,NUM                                  : STRING[20];
   AUX                                       : ARRAY [1..100] OF STRING[5];
BEGIN
     CLEARDEVICE;
     SETFILLSTYLE (1, 11);
     BAR (1, 10, 640, 460);
     SETCOLOR (0);
     RECTANGLE (4, 13, 632, 457);
     SETFILLSTYLE (1, 11);
     BAR (160, 1, 495, 20);
     RECTANGLE (162, 3, 493, 25);
     OUTTEXTXY (210, 10, '>>>>> INCLUSAO DOS PROCESSOS <<<<<');
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

                OUTTEXTXY (10, YY,      ' DIGITE O NOME DO PROCESSO : ');
                OUTTEXTXY (10, YY + 20, ' DIGITE TEMPO TOTAL DE CPU : ');
                OUTTEXTXY (10, YY + 40, ' DIGITE O TEMPO DE ENTRADA : ');

                WHILE CONFIRMA <> 'E' DO
                BEGIN

(*********************** LEITURA DO NOME DO PROCESSOS **********************)
                     XX     := XXX;
                     NN     := 1;
                     TAMA   := '';
                     STR (CONT, NUM);
                     OUTTEXTXY (XX, YY - 15, NUM);

                     OUTTEXTXY (XX, YY, '_');
                     TAM[NN] := READKEY;
                     WHILE TAM[NN] <> ENTER DO
                          BEGIN
                           IF (TAM[NN]='A') OR (TAM[NN]='B') OR (TAM[NN]='C') OR (TAM[NN]='D')
                              OR (TAM[NN]='E') OR (TAM[NN]='F') OR (TAM[NN]='G') OR (TAM[NN]='H')
                              OR (TAM[NN]='I') OR (TAM[NN]='J') OR (TAM[NN]='L') OR (TAM[NN]='M') THEN
                                BEGIN
                                  BAR (XX, YY - 1, XX + 8, YY + 7);
                                  OUTTEXTXY (XX, YY, TAM[NN]);
                                  XX := XX + 10;
                                  OUTTEXTXY (XX, YY, '_');
                                END;

                           IF TAM[NN] = BS THEN
                              BEGIN
                                   IF XX <= 260 then
                                      XX := 250
                                   ELSE
                                       BEGIN
                                            BAR (XX, Y + 1, XX + 8, Y + 7);
                                            XX := XX - 10;
                                            BAR (XX, Y - 4, XX + 6, Y + 7);
                                            OUTTEXTXY (XX, YY, '_');
                                            DELETE (TAMA, NN - 1, NN);
                                            NN := NN - 1;
                                       END;
                              END
                           ELSE
                              IF (TAM[NN]='A') OR (TAM[NN]='B') OR (TAM[NN]='C') OR (TAM[NN]='D')
                              OR (TAM[NN]='E') OR (TAM[NN]='F') OR (TAM[NN]='G') OR (TAM[NN]='H')
                              OR (TAM[NN]='I') OR (TAM[NN]='J') OR (TAM[NN]='L') OR (TAM[NN]='M')
                              OR (TAM[NN]='N') OR (TAM[NN]='O') OR (TAM[NN]='P') OR (TAM[NN]='Q')
                              OR (TAM[NN]='R') OR (TAM[NN]='S') OR (TAM[NN]='T') OR (TAM[NN]='U')
                              OR (TAM[NN]='V') OR (TAM[NN]='X') OR (TAM[NN]='W') OR (TAM[NN]='Z')  THEN
                               BEGIN
                                    TAMA :=  CONCAT (TAMA, TAM[NN]);
                                    NN := NN + 1;
                               END;
                           TAM[NN] := READKEY;
                         END;
                     NOME_PROCESSO := TAMA;
                     BAR (XX, YY + 1, XX + 8, YY + 7);

(********************** LEITURA DO TEMPO DE CPU **************************)
                     XX     := XXX;
                     YY     := YY + 20;
                     NN      := 1;
                     TAMA   := '';
                     OUTTEXTXY (XX, YY, '_');
                     TAM[NN] := READKEY;
                     WHILE TAM[NN] <> ENTER DO
                           BEGIN
                               IF (TAM[NN]='1') OR (TAM[NN]='2') OR (TAM[NN]='3')
                                  OR (TAM[NN]='4') OR (TAM[NN]='5') OR (TAM[NN]='6')
                                  OR (TAM[NN]='7') OR (TAM[NN]='8') OR (TAM[NN]='9')
                                  OR (TAM[NN]='0') THEN
                                  BEGIN
                                    BAR (XX, YY - 1, XX + 8, YY + 7);
                                    OUTTEXTXY (XX, YY, TAM[NN]);
                                    XX := XX + 10;
                                    OUTTEXTXY (XX, YY, '_');
                                  END;
                               IF TAM[NN] = BS THEN
                                  BEGIN
                                     IF XX <= 260 then
                                        XX := 250
                                     ELSE
                                         BEGIN
                                              BAR (XX, YY + 1, XX + 8, YY + 7);
                                              XX := XX - 10;
                                              BAR (XX, YY - 4, XX + 6, YY + 7);
                                              OUTTEXTXY (XX, YY, '_');
                                              DELETE (TAMA, NN - 1, NN);
                                              NN := NN - 1;
                                         END;
                                  END
                               ELSE
                                 IF (TAM[NN]='1') OR (TAM[NN]='2') OR (TAM[NN]='3')
                                    OR (TAM[NN]='4') OR (TAM[NN]='5') OR (TAM[NN]='6')
                                    OR (TAM[NN]='7') OR (TAM[NN]='8') OR (TAM[NN]='9')
                                    OR (TAM[NN]='0') THEN
                                    BEGIN
                                         TAMA :=  CONCAT (TAMA, TAM[NN]);
                                         NN := NN + 1;
                                    END;
                               TAM[NN] := READKEY;

                            END;
                    VAL (TAMA, TEMPO_CPU, ERRO);
                    BAR (XX, YY + 1, XX + 8, YY + 7);

(*********************** LEITURA DO TEMPO DE ENTRADA **********************)
                    XX     := XXX;
                    YY     := YY + 20;
                    NN      := 1;
                    TAMA   := '';
                    OUTTEXTXY (XX, YY, '_');
                    TAM[NN] := READKEY;
                    WHILE TAM[NN] <> ENTER DO
                          BEGIN
                               IF (TAM[NN]='1') OR (TAM[NN]='2') OR (TAM[NN]='3')
                                   OR (TAM[NN]='4') OR (TAM[NN]='5') OR (TAM[NN]='6')
                                   OR (TAM[NN]='7') OR (TAM[NN]='8') OR (TAM[NN]='9')
                                   OR (TAM[NN]='0') THEN
                                       BEGIN
                                            BAR (XX, YY - 1, XX + 8, YY + 7);
                                            OUTTEXTXY (XX, YY, TAM[NN]);
                                            XX := XX + 10;
                                            OUTTEXTXY (XX, YY, '_');
                                       END;
                               IF TAM[NN] = BS THEN
                                  BEGIN
                                       IF XX <= 260 then
                                          XX := 250
                                       ELSE
                                           BEGIN
                                                 BAR (XX, YY + 1, XX + 8, YY + 7);
                                                 XX := XX - 10;
                                                 BAR (XX, YY - 4, XX + 6, YY + 7);
                                                 OUTTEXTXY (XX, YY, '_');
                                                 DELETE (TAMA, NN - 1, NN);
                                                 NN := NN - 1;
                                           END;
                                  END
                               ELSE
                                   IF (TAM[NN]='1') OR (TAM[NN]='2') OR (TAM[NN]='3')
                                      OR (TAM[NN]='4') OR (TAM[NN]='5') OR (TAM[NN]='6')
                                      OR (TAM[NN]='7') OR (TAM[NN]='8') OR (TAM[NN]='9')
                                      OR (TAM[NN]='0') THEN
                                         BEGIN
                                              TAMA :=  CONCAT (TAMA, TAM[NN]);
                                              NN := NN + 1;
                                         END;
                               TAM[NN] := READKEY;
                          END;
                          VAL (TAMA, TEMPO_ENTRADA, ERRO);
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
                         PROC[CONT].NOME := NOME_PROCESSO;
                         PROC[CONT].CPU := TEMPO_CPU;
                         PROC[CONT].ENTRADA := TEMPO_ENTRADA;
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
                                     OUTTEXTXY (210, 10, '>>>>> INCLUSAO DOS PROCESSOS <<<<<');
                                     CONT := 1;
                                     CHAVE := 'N';
                                     X := 260;
                                     Y := 70;
                                 END;
                       END;
           END;
    CONT := CONT - 1;
    NUMERO_PROCESSOS := CONT;
END;

(***************************************************************************)
(************************ EXECUSAO DOS PROCESSOS ***************************)
PROCEDURE EXECUCAO;
VAR
   TAMA, NUM                                 : STRING[20];
   TAM                                       : ARRAY [1..256] OF CHAR;
   ERRO, XX, YY, WW                          : INTEGER;
   INDICE,TEMPO,TEMPO1,TRANS                 : INTEGER;
   ALGO                                      : BOOLEAN;
   SAIDA                                     : ARRAY [1..100] OF INTEGER;
   TURNAROUND,TEMPOESPERA                    : REAL;
   ESPERA                                    : ARRAY [1..100] OF INTEGER;
BEGIN
     TURNAROUND := 0;
     TEMPOESPERA := 0;
     FOR X := 1 TO NUMERO_PROCESSOS DO
         PROC1[X] := PROC[X];

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
              OUTTEXTXY (210, 10, '>>>>> EXECUCAO DOS PROCESSOS <<<<<');
              OUTTEXTXY (10, 40, 'DIGITE O QUANTUN DE TEMPO : ');
              NN      := 1;
              X      := 250;
              TAMA   := '';
              OUTTEXTXY (X, 40, '_');
              TAM[NN] := READKEY;
              WHILE TAM[NN] <> ENTER DO
                   BEGIN
                        IF (TAM[NN]='1') OR (TAM[NN]='2') OR (TAM[NN]='3')
                        OR (TAM[NN]='4') OR (TAM[NN]='5') OR (TAM[NN]='6')
                        OR (TAM[NN]='7') OR (TAM[NN]='8') OR (TAM[NN]='9')
                        OR (TAM[NN]='0') THEN
                           BEGIN
                                BAR (X-2, 43 , X+7 , 45 );
                                OUTTEXTXY (X, 40, TAM[NN]);
                                X := X + 10;
                                OUTTEXTXY (X, 40, '_');
                           END;
                        IF TAM[NN] = BS THEN
                           BEGIN
                                IF X <= 260 then
                                   X := 250
                                ELSE
                                    BEGIN
                                         X := X - 10;
                                         BAR (X, 31, X + 17, 50);
                                         DELETE (TAMA, NN - 1 , NN);
                                         NN := NN - 1;
                                         OUTTEXTXY (X, 40, '_');
                                    END;
                           END
                        ELSE
                            BEGIN
                                 TAMA :=  CONCAT (TAMA, TAM[NN]);
                                 NN := NN + 1;
                            END;
                        TAM[NN] := READKEY;
                   END;
               BAR (X-2, 43 , X+7 , 45 );
               VAL (TAMA, QUANTUM, ERRO);

(******************ORDENA OS PROCESSOS PELA ENTRADA ************************)
               FOR X := 1 TO NUMERO_PROCESSOS -1 DO
                   FOR Y := X +1 TO NUMERO_PROCESSOS DO
                       IF PROC1[X].ENTRADA > PROC1[Y].ENTRADA THEN
                          BEGIN
                               AUX := PROC1[X];
                               PROC1[X] := PROC1[Y];
                               PROC1[Y] := AUX;
                               AUX1 := PROC1[X].INDICE;
                               PROC1[X].INDICE := PROC1[Y].INDICE;
                               PROC1[Y].INDICE := AUX1;
                          END;
               XX := 80;
               YY := 80;
               FEITO := FALSE;
               ALGO := TRUE;
               TEMPO := 0;
               TEMPO1 := 0;
               WHILE FEITO <> TRUE DO
                     BEGIN
                          CONT := 0;
                          WHILE CONT <= NUMERO_PROCESSOS DO
                                BEGIN

(********************* Mostra o estado do processo ********************)
                                     FOR X := 1 TO NUMERO_PROCESSOS DO
                                         BEGIN
                                              IF ALGO = TRUE THEN
                                              BEGIN
                                                   OUTTEXTXY (XX - 50, YY, 'CPU> ');
                                                   OUTTEXTXY (XX, YY, PROC1[X].NOME);
                                                   STR (PROC1[x].CPU, NUM);
                                                   OUTTEXTXY (XX + 25, YY, NUM);
                                                   IF X = INDICE THEN
                                                      BEGIN
                                                           OUTTEXTXY (XX+35,YY,'<---');
                                                           TEMPO1:= TEMPO1 + TEMPO;
                                                           IF PROC1[X].CPU = 0 THEN
                                                              BEGIN
                                                                   SAIDA[X] := TEMPO1;
                                                                   TURNAROUND := TURNAROUND + (SAIDA[X] - PROC1[X].ENTRADA);
                                                              END;
                                                      END;
                                                   YY := YY + 20;
                                                   IF YY = 420 THEN
                                                      BEGIN
                                                           XX := XX + 150;
                                                           YY := 80;
                                                      END;
                                              END;
                                         END;
                                     LINE (XX - 55, YY - 12, XX + 40, YY - 12);
                                     STR (TEMPO1, NUM);
                                     OUTTEXTXY (XX + 45, YY - 12, NUM);
                                     CONT := CONT + 1;
                                     ALGO := FALSE;
                                     IF PROC1[CONT].CPU >= QUANTUM THEN
                                        BEGIN
                                             TEMPO := QUANTUM;
                                             PROC1[CONT].CPU := PROC1[CONT].CPU - QUANTUM;
                                             INDICE := CONT;
                                             ALGO := TRUE;
                                        END
                                     ELSE
                                         IF (PROC1[CONT].CPU > 0) AND (PROC1[CONT].CPU < QUANTUM) THEN
                                            BEGIN
                                                 TEMPO := PROC1[CONT].CPU;
                                                 PROC1[CONT].CPU := PROC1[CONT].CPU - PROC1[CONT].CPU;
                                                 INDICE := CONT;
                                                 ALGO := TRUE;
                                            END;
                                     FEITO := TRUE;
                                     FOR X := 1 TO NUMERO_PROCESSOS DO
                                         IF PROC1[X].CPU <> 0 THEN
                                            FEITO := FALSE;
                     END;
                   END;

(****************** MOSTRA O RESULTADO DO TEMPO DE ESPERA ********************)
              FOR X := 1 TO NUMERO_PROCESSOS DO
                    TEMPOESPERA := TEMPOESPERA +  PROC[X].CPU;
              TEMPOESPERA := TEMPOESPERA - TURNAROUND;
              TEMPOESPERA := TEMPOESPERA / NUMERO_PROCESSOS;
              STR (TEMPOESPERA:6:2, NUM);
              OUTTEXTXY (XX - 55, YY+35, 'Tempo de Espera = ');
              OUTTEXTXY (XX+ 75, YY+35, NUM);

(***************** MOSTRA O RESULTADO DO TURNAROUND ************************)
              TURNAROUND := TURNAROUND / NUMERO_PROCESSOS;
              STR (TURNAROUND:6:2, num);
              OUTTEXTXY (XX - 55, YY + 15, 'Turnaround = ');
              OUTTEXTXY (XX + 45, YY + 15, NUM);

(************************** CONFIRMACAO DE SAIDA **************************)
              RECTANGLE (130, 435, 510, 455);
              OUTTEXTXY (125, 445, '  Tecle <ESC> para voltar para o menu principal');
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
        3    :  EXECUCAO;
        4    :  FIM;
     END;
END;

(******************************************************************)
(********************* PROGRAMA PRINCIPAL *************************)
BEGIN
     GD := DETECT;
     INITGRAPH (GD,GM,'C:\COMPILA\PASCAL70\BGI ');
(*     INITGRAPH (GD,GM,' ');   *)

(***************** INICIALIZACAO DO MENU ***************************)
     L := 130;
     N := 1;

(************************* EXEMPLO INICIAL ************************)
     PROC[1].NOME := 'A';
     PROC[1].CPU := 8;
     PROC[1].ENTRADA := 0;
     PROC[1].INDICE := 1;

     PROC[2].NOME := 'B';
     PROC[2].CPU := 5;
     PROC[2].ENTRADA := 4;
     PROC[2].INDICE := 2;

     PROC[3].NOME := 'C';
     PROC[3].CPU := 6;
     PROC[3].ENTRADA := 9;
     PROC[3].INDICE := 3;

     PROC[4].NOME := 'D';
     PROC[4].CPU := 7;
     PROC[4].ENTRADA := 14;
     PROC[4].INDICE := 4;

     QUANTUM := 5;
     NUMERO_PROCESSOS := 4;
(*********************FIM DO EXEMPLO INICIAL ************************)

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
                                 EXECUCAO;
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