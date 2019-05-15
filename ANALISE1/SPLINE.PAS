(*************************************************************************)
(* OSMAR DE OLIVEIRA BRAZ JUNIOR  E LUSICLER DE SOUZA MOLON  -  07/06/94 *)
(*    PROGRAMA PARA CALCULAR UM VALOR INTERPOLADO POR SPLINE CUBICO      *)
(*   SOLICITADO PELO PROFESSOR DE ANALISE NUMERICA 2, SALOMAO W. SANDRINI*)
(*************************************************************************)

PROGRAM SPLINE_CUBICOS;
USES CRT;
VAR
   I,N,CHAVE                      : WORD;
   X,Y,H,D,C,O,B                  : ARRAY[1..30] OF REAL;
   XX,S,XO,A,BB,ALFA,BETA,TETA    : REAL;
   TECLA                          : CHAR;

PROCEDURE ABERTURA;
CONST
    TEMPO = 40;
VAR
   COLUNA1,COLUNA2,LINHA1,LINHA2 :INTEGER;
BEGIN
     WINDOW(1,1,80,25);
     TEXTBACKGROUND(15);
     TEXTCOLOR(1);
     CLRSCR;
     COLUNA1:= 40;
     COLUNA2 := 40;
     LINHA1 :=  13;
     LINHA2 :=  13;
     GOTOXY(12,7);
     WRITE('ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
     GOTOXY(12,8);
     WRITE('บ                                                       บ');
     GOTOXY(12,9);
     WRITE('บ                                                       บ');
     GOTOXY(12,10);
     WRITE('บ                                                       บ');
     GOTOXY(12,11);
     WRITE('บ                                                       บ');
     GOTOXY(12,12);
     WRITE('บ                                                       บ');
     GOTOXY(12,13);
     WRITE('บ                                                       บ');
     GOTOXY(12,14);
     WRITE('บ                                                       บ');
     GOTOXY(12,15);;
     WRITE('ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
     GOTOXY(25,13);
     WRITE('BY OSMAR DE OLIVEIRA BRAZ JUNIOR');
     GOTOXY(27,14);
     WRITE('AND LUSICLER DE SOUZA MOLON');
     GOTOXY(25,9);
     WRITE('INTERPOLACAO POR SLINES CUBICOS');
     TEXTCOLOR(16);
     GOTOXY(22,11);
     WRITE('APERTE A TECLA <ENTER> PARA CONTINUAR');
     READLN;
     REPEAT
           TEXTBACKGROUND(4);
           WINDOW(COLUNA1,LINHA1,COLUNA2,LINHA2);
           CLRSCR;
           DELAY(TEMPO);
           INC(COLUNA2);
           DEC(COLUNA1);
           IF COLUNA1 < 1 THEN
              COLUNA1 := 1;
           INC(LINHA2);
           IF LINHA2 > 25 THEN
              LINHA2 := 25;
           DEC(LINHA1);
           IF LINHA1 < 1 then
              LINHA1 := 1;
    UNTIL COLUNA2 > 80;
    CLRSCR;
    WINDOW(1,1,80,25);
    TEXTBACKGROUND(15);
    CLRSCR;
    TEXTCOLOR(1);
    WRITELN('                     INTERPOLACAO POR SPLINES CUBICOS');
    WINDOW(2,2,79,24);
    TEXTBACKGROUND(1);
    CLRSCR;
    TEXTCOLOR(15);
    WINDOW(3,3,78,24);
    TEXTCOLOR(15);
    TEXTBACKGROUND(0);
    CLRSCR;
END;


(**************************** PROGRAMA PRINCIPAL ***************************)

BEGIN
     ABERTURA;

(*************** LE O NUMERO DE PONTOS A SEREM INTERPOLADOS ****************)

     WRITELN('       >>>>O NUMERO DE PONTOS DEVE SER MAIOR OU IGUAL A 3<<<<');
     WRITE('                    DIGITE O NUMERO DE PONTOS = ');
     READLN(N);
     FOR I := 1 TO N DO
         BEGIN
              GOTOXY(13,3+I);
              WRITE('DIGITE O X',I,' = ');
              READLN(X[I]);
              GOTOXY(40,3+I);
              WRITE('DIGITE O Y',I,' = ');
              READLN(Y[I]);
         END;

(**************** DETERMINA OS COEFICIENTES DO POLINOMIO *******************)

     FOR I := 1 TO N DO
         H[I] := X[I+1] - X[I];
     C[2] := 2 * (H[1]+H[2]);
     FOR I := 3 TO N-1 DO
         C[I]:= 2*(H[I-1]+H[I])-SQR(H[I-1])/C[I-1];
     FOR I := 1 TO N-1 DO
         B[I] := 6*(Y[I+1]-Y[I])/H[I];
     D[2] := B[2] - B[1];
     FOR I := 3 TO N-1 DO
         D[I] := (B[I] - B[I-1])-((H[I-1] * D[I-1])/C[I-1]);
     O[1] := 0;
     O[N] := 0;
     O[N-1] := D[N-1] /C[N-1];
     FOR I := N -2 DOWNTO 2 DO
         O[I] := (D[I] - H[I] * O [I +1] )/C[I];
    {FOR I := 1 TO N DO
         WRITE(I,' O ? = ',O[I]:0:2,' - ');}

(******************** CALCULO DO VETOR INTERPOLADOR ***********************)

     TECLA := 'S';
     WHILE (TECLA = 'S') OR (TECLA ='s') DO
      BEGIN
     A := X[1];
     BB := X[N];

(*************** LEITURA DO VALOR A SER INTERPOLADO POR SPLINE *************)

     WRITELN;
     WRITELN('     O VALOR A SER INTERPOLADO DEVE ESTAR ENTRE <',A:0:2,
             '> E <',BB:0:2,'>');
     WRITE('           DIGITE VALOR  PARA INTERPOLAR POR SPLINE = ');
     READLN(XX);

(*************************** CALCULO DA SOLUCAO ***************************)

     XO := X[1] +H[1];
     CHAVE := 0;
     FOR I := 1 TO N-1 DO
       IF (XX < XO) AND (CHAVE = 0)THEN
          BEGIN
               ALFA := (Y[I+1] - Y[I]) / H[I] - O[I+1] * H[I] / 6
                          - O[I] * H[I] / 3;
               BETA := O[I] / 2;
               TETA :=(O[I+1] - O[I]) / (6 * H[I]);
               S := Y[I] + ALFA * (XX-X[I]) + BETA * SQR(XX - X[I])+
                     TETA * SQR(XX - X[I]) * (XX - X[I]);
               WRITELN;
               WRITELN('                >>>> SOLUCAO PARA ',XX:0:2,' E ',S:0:3,' <<<<');
               CHAVE := 1;
          END
       ELSE
           XO := XO + H[I+1];

(*************************** SAIDA DO ERRO ********************************)

       IF CHAVE <>1 THEN
          BEGIN
               WRITELN;
               WRITELN('              X NAO ESTA NO INTERVALO<',A:0:2,'> E <'
               ,BB:0:2,'>');
               WRITELN;
          END;
       WRITELN;
       WRITE('                 DESEJA FAZER OUTRA CONSULTA (S/N)?');
       TECLA:= READKEY;
       WRITELN;
     END;
     WINDOW(1,1,80,25);
     TEXTBACKGROUND(1);
     TEXTCOLOR(15);
     CLRSCR;
END.
