PROGRAM ARVORE_BINARIA;
USES CRT,GRAPH,DOS;
TYPE
 ELEMENTO = RECORD
              ESQ,ELE,DIR : WORD;
            END;
var
    VX,VY,VX1,Z,Z1,Z2,CONT,X1,X,XX,COND,LANT,K,CONT1,C1      : INTEGER;
    VCONT,LIMG,OND,TAM,REF,I,DISP,MODO,NIV,J,Y,LIM,CONDE     : INTEGER;
    VET                                    : ARRAY [1..31] of WORD;
    VETTRAB                                : ARRAY [1..31] OF ELEMENTO;
    VETSTR                                 : ARRAY [1..31] OF STRING[3];
    PILHA                                  : ARRAY [1..31] OF WORD;
    SOM         : BYTE;
    NELEM,POSI,AUX1,AUX2                        : WORD;
    AUXVET                                      : BOOLEAN;
    TECLA                                       : CHAR;
    HOR,MIN,SEG,CSEG                            : WORD;
    MEN,HORA,MINUT,SEGUN,CSEGUN                 : STRING;
    AUXCONDE2,AUXCONDE3                         : BOOLEAN;

PROCEDURE ZERA_RELOGIO;
 BEGIN
   SETTIME(0,0,0,0);
 END;

PROCEDURE PEGA_RELOGIO;
 BEGIN
  GETTIME(HOR,MIN,SEG,CSEG);
 END;

PROCEDURE RELOGIO;
 BEGIN
  STR(HOR,HORA);
  STR(MIN,MINUT);
  STR(SEG,SEGUN);
  STR(CSEG,CSEGUN);
  SETTEXTSTYLE(11,0,4);{estilo do texto}
  OUTTEXTXY(460,15,'Tempo de Ordenacao');
  SETTEXTSTYLE(11,0,4);{estilo do texto}
  OUTTEXTXY(500,28,HORA);
  OUTTEXTXY(510,28,':  ');
  OUTTEXTXY(520,28,MINUT);
  OUTTEXTXY(530,28,':  ');
  OUTTEXTXY(540,28,SEGUN);
  OUTTEXTXY(550,28,':  ');
  OUTTEXTXY(560,28,CSEGUN);
 END;

PROCEDURE MENSAGEM(VAR MEN:STRING);
BEGIN
   SETCOLOR(15);
   SETLINESTYLE(0,0,1);{estilo do retangulo de contorno}
   RECTANGLE(9,450,632,470);{Retangulo de contorno da mensagem}
   SETFILLSTYLE(1,7);  {estilo e cor do preenchimento}
   BAR(10,451,630,469); {preenchimento do retangulo}
   SETCOLOR(8);{Cor das linhas sombra}
   SETLINESTYLE(0,0,3);{estilo das linhas sombra}
   SETTEXTSTYLE(11,0,4);{estilo do texto}
   OUTTEXTXY(10,455,'>> '+ MEN);
   LINE(7,452,7,472);{linhas cinzas que dao impressao de sombra}
   LINE(7,472,630,472);
END;

PROCEDURE LIMPA_TELA;
 BEGIN
  SETCOLOR(15);{contorno  branco do quadrado maior tela de inser-
                cao de dados e visualizacao da arvore/vetor/pilha}
  SETLINESTYLE(0,0,1); {estilo do contorno acima}
  RECTANGLE(9,45,632,443);
  SETFILLSTYLE(1,7);
  BAR(10,46,631,442);
  SETCOLOR(8); {cor sombra e letras da entrada de dados(cinza escuro)}
  SETLINESTYLE(0,0,3);{sombra do retangulo}
  LINE(7,47,7,445);{linhas de sombra}
  LINE(7,445,630,445);
 END;

PROCEDURE VETOR;
VAR
  NUM              : WORD;
  POSI2,POS2       : BYTE;

BEGIN
   TEXTBACKGROUND(8);
   TEXTCOLOR(8);
   WINDOW(39,4,41,4);
   OUTTEXTXY(20,54,'QUANTOS COMPONENTES TERA A ARVORE.:');
   {Entra com o numero de componentes}
   REPEAT
    CLRSCR;
    GOTOXY(5,52);  READLN(NELEM);
    UNTIL (NELEM>0) AND (NELEM<32);
   {Entrada dos componentes}
    WINDOW(23,5,26,5);
    OUTTEXTXY(20,69,'DIGITE OS VALORES :');
    VET[1]:=0;
    FOR POSI2:=1 TO NELEM DO
     BEGIN
      AUXVET:=FALSE;
      READ(NUM);
      FOR POS2:=1 TO (POSI2-1) DO
       BEGIN
        IF NUM = VET[POS2] THEN
           BEGIN
             DEC(POSI2);
             AUXVET:=TRUE;
             RECTANGLE(194,188,420,245);
             SETFILLSTYLE(1,7);
             OUTTEXTXY(200,200,'ESTE NUMERO JA FOI DIGITADO ');
             OUTTEXTXY(200,220,'TECLE ENTER PARA CONTINUAR.');
             TECLA:=READKEY;
              BAR(10,85,631,442);  {Para apagar o retangulo com mensagem acima}
             END;
       END;
       IF (NUM <> VET[POS2]) AND (AUXVET=FALSE) THEN VET[POSI2]:=NUM;
     end;
 END;

 PROCEDURE CRIA_VET_TRAB;
  VAR
  POSI      : BYTE;
  TAMVET    : BYTE;
  BEGIN
  TAMVET:=NELEM DIV 2;

  IF (NELEM DIV 2)= 0 THEN  TAMVET :=1;

   FOR POSI := 1 TO TAMVET DO
    BEGIN
      IF (2 * POSI)     <= NELEM THEN VETTRAB[POSI].ESQ := VET[2 * POSI];
      IF (2 * POSI + 1) <= NELEM THEN VETTRAB[POSI].DIR := VET[2 * POSI + 1];
      VETTRAB[POSI].ELE := VET[POSI];
     END;
  END;

PROCEDURE ORDENA_ARVORE;
VAR
 TROCA,TROCA2 : BOOLEAN;
 POS          : BYTE;
 BEGIN
 CLRSCR;
 TROCA:=TRUE;
 TROCA2:=FALSE;
 ZERA_RELOGIO;
WHILE TROCA =TRUE DO
BEGIN

 TROCA:=FALSE;
 FOR POSI:=1 TO (NELEM DIV 2) DO
  BEGIN
    IF VETTRAB[POSI].ELE < VETTRAB[POSI].DIR THEN
    BEGIN
     AUX1:=VETTRAB[POSI].DIR;
     AUX2:=VETTRAB[POSI].ELE;
     VETTRAB[POSI].DIR:=VETTRAB[POSI].ELE;
     VETTRAB[POSI].ELE:=AUX1;
     TROCA2:=FALSE;
      FOR POS:=1 TO (NELEM DIV 2) DO
       BEGIN

        IF  (POS<>POSI)  and (TROCA2=FALSE) then
         BEGIN
          IF (VETTRAB[POS].ELE = AUX1) THEN
           BEGIN
            VETTRAB[POS].ELE:=AUX2;
            TROCA2:=TRUE;
             IF (VETTRAB[POS].ELE<VETTRAB[POS].DIR) OR (VETTRAB[POS].ELE<VETTRAB[POS].ESQ)
              THEN TROCA:=TRUE
           END;
         END;

        IF ((POS <> POSI)  AND (POSI = 1)) AND (TROCA2=FALSE) THEN
         BEGIN
            IF (VETTRAB[POS].ELE = AUX1) THEN
             BEGIN
              VETTRAB[POS].ELE:=AUX2;
              IF(VETTRAB[POS].ELE<VETTRAB[POS].DIR) OR
                (VETTRAB[POS].ELE<VETTRAB[POS].ESQ) THEN
                TROCA:=TRUE;
             END;
          END;

         IF (POSI<>1)  AND (POS < POSI) and (TROCA2=FALSE) THEN
          BEGIN
           IF (VETTRAB[POS].DIR = AUX2) THEN
            BEGIN VETTRAB[POS].DIR:=AUX1;
             IF VETTRAB[POS].DIR > VETTRAB[POSI].ELE THEN TROCA:=TRUE
            END;

           IF (VETTRAB[POS].ESQ = AUX2) THEN
            BEGIN VETTRAB[POS].ESQ:=AUX1;
             IF VETTRAB[POS].ESQ > VETTRAB[POS].ELE THEN TROCA:=TRUE
            END;
         END;
       END;
    END;

   IF VETTRAB[POSI].ELE < VETTRAB[POSI].ESQ THEN
     BEGIN
      AUX1:=VETTRAB[POSI].ESQ;
      AUX2:=VETTRAB[POSI].ELE;
      VETTRAB[POSI].ESQ:=VETTRAB[POSI].ELE;
      VETTRAB[POSI].ELE:=AUX1;
      TROCA2:=FALSE;
       FOR POS:=1 TO (NELEM DIV 2) DO
        BEGIN

        IF (POS<>POSI)  AND (TROCA2=FALSE) THEN
         BEGIN

          IF (VETTRAB[POS].ELE = AUX1) THEN
           BEGIN
            VETTRAB[POS].ELE:=AUX2;
            TROCA2:=TRUE;
            IF (VETTRAB[POS].ELE<VETTRAB[POS].DIR) OR
               (VETTRAB[POS].ELE<VETTRAB[POS].ESQ)
             THEN TROCA:=TRUE
           END;

        END;

         IF (POSI = 1)  AND (POSI<>POS) AND (TROCA2=FALSE) THEN
          BEGIN

          IF (VETTRAB[POS].ELE = AUX1) THEN
           BEGIN
            VETTRAB[POS].ELE:=AUX2;
            IF (VETTRAB[POS].ELE<VETTRAB[POS].DIR) OR
               (VETTRAB[POS].ELE<VETTRAB[POS].ESQ)
               THEN TROCA:=TRUE
           END;

        END;

          IF (POSI<>1) AND (POS <> POSI) AND (TROCA2=FALSE) THEN
           BEGIN
           IF (VETTRAB[POS].DIR = AUX2) THEN
            BEGIN
             VETTRAB[POS].DIR:=AUX1;
              IF VETTRAB[POS].DIR > VETTRAB[POS].ELE THEN TROCA:=TRUE
            END;

           IF (VETTRAB[POS].ESQ = AUX2) THEN
            BEGIN
             VETTRAB[POS].ESQ:=AUX1;
             IF VETTRAB[POS].ESQ > VETTRAB[POS].ELE THEN TROCA:=TRUE
            END;
          END;
         END;
        END;
    END;
END;
PEGA_RELOGIO;
END;

PROCEDURE MONTA_HEAP;
VAR
 POS1,TAMPILHA  :  BYTE;
 MARCA          :  BOOLEAN;
BEGIN
CLRSCR;

TAMPILHA:=NELEM;
MARCA:=TRUE;
POS1:=(TAMPILHA DIV 2);
 WHILE POS1 >= 1 DO
  BEGIN

   IF (VETTRAB[POS1].DIR <> 0) OR (VETTRAB[POS1].ESQ <> 0) THEN
    BEGIN
     IF (VETTRAB[POS1].DIR <>0) THEN
      BEGIN
       AUX1:=VETTRAB[POS1].DIR;
       AUX2:=VETTRAB[1].ELE;
       VETTRAB[POS1].DIR:=0;
       VETTRAB[1].ELE:=AUX1;
       PILHA[TAMPILHA]:=AUX2;
       DEC(TAMPILHA);
      END
       ELSE
        IF VETTRAB[POS1].ESQ <> 0 THEN
         BEGIN
          AUX1:=VETTRAB[POS1].ESQ;
          AUX2:=VETTRAB[1].ELE;
          VETTRAB[POS1].ESQ:=0;
          VETTRAB[1].ELE:=AUX1;
          PILHA[TAMPILHA]:=AUX2;
          DEC(TAMPILHA);
         END;
         ORDENA_ARVORE;
         POS1:=TAMPILHA DIV 2;
        END

     ELSE
       IF (VETTRAB[POS1].DIR = 0) AND (VETTRAB[POS1].ESQ = 0) THEN
        BEGIN
         DEC(TAMPILHA);
         POS1:=(TAMPILHA DIV 2);
        END;
   END;

        IF (POS1=0) AND (TAMPILHA =1) AND (MARCA=TRUE) THEN
         BEGIN
         POS1:=1;
         PILHA[TAMPILHA]:=VETTRAB[POS1].ELE;
         DEC(POS1);
         MARCA:=FALSE;
         end;
END;

PROCEDURE TRANSFORMA;
  VAR
    I,J  :  BYTE;
  BEGIN
   I:=1;
  IF CONDE = 2 THEN
  BEGIN
   FOR J:=1 TO (NELEM DIV 2) DO
    BEGIN
     IF (VETTRAB[J].ELE <> 0) AND (J=1) THEN
      BEGIN
       VET[I]:=VETTRAB[J].ELE;
       INC(I);
      END;
     IF VETTRAB[J].ESQ <> 0 THEN
      BEGIN
       VET[I]:=VETTRAB[J].ESQ;
       INC(I);
      END;
     IF VETTRAB[J].DIR <> 0 THEN
      BEGIN
       VET[I]:=VETTRAB[J].DIR;
       INC(I);
      END;
    END;
 END;
    FOR J:=1 TO NELEM DO
    BEGIN
     STR(VET[J],VETSTR[J]);
    END;
   IF CONDE = 3 THEN
    BEGIN
     FOR J:=1 TO NELEM DO
      BEGIN
       STR(PILHA[J],VETSTR[J]);
      END;
    END;
 END;

PROCEDURE INICIAL(VAR COND:INTEGER);
VAR
   N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,TECLA_AT : BYTE;
   TECLA                                           : CHAR;
   MEM                                             : STRING;
BEGIN
   { TELA INICIAL FUNDO E BORDAS }
   SETBKCOLOR(7);
   SETLINESTYLE(0,0,3);
   LINE(1,1,1,480);
   LINE(1,1,640,1);
   LINE(638,1,638,478);
   LINE(1,478,640,478);
   { TITULO }
   SETLINESTYLE(0,0,1);
   LINE(10,10,10,40);
   LINE(10,10,632,10);
   LINE(632,10,632,40);
   LINE(10,40,632,40);
   SETCOLOR(8);
   SETLINESTYLE(0,0,3);
   LINE(8,12,8,42);
   LINE(8,42,630,42);
   SETCOLOR(14);
   SETTEXTSTYLE(7,0,4);
   OUTTEXTXY(150,3,'H E A P S O R T ');
   { CALCULO }
   mem:=' MONTA ARVORE  .:GERA UMA ARVORE BINARIA';
   MENSAGEM(MEM);
   condE:=1;
   tecla_at:=1;
   repeat
      IF CONDE=1 THEN
     BEGIN
      N1:=8; N2:=14; N3:=14;    N10:=14;
      N4:=14; N5:=8; N6:=8;    N11:=8;
      N7:=8; N8:=7; N9:=7;    N12:=7;
     END;

     IF CONDE=2 THEN
     BEGIN
       N1:=14;N2:=8;n3:=14;    N10:=14;
       N4:=8;N5:=14;n6:=8;    N11:=8;
       N7:=7;N8:=8;N9:=7;    N12:=7;

     END;

    IF CONDE=3 THEN
     BEGIN
      N1:=14; N2:=14; N3:=8;   N10:=14;
      N4:=8; N5:=8; N6:=14;   N11:=8;
      N7:=7; N8:=7; N9:=8;   N12:=7;
     END;

    IF CONDE = 4 THEN
      BEGIN
       N1:=14; N2:=14; N3:=14;   N10:=8;
       N4:=8; N5:=8; N6:=8;   N11:=14;
       N7:=7; N8:=7; N9:=7;   N12:=8;
     END;

     SETFILLSTYLE(1,N7);
     BAR(10,60,110,98);
     SETCOLOR(N1);
     SETLINESTYLE(0,0,1);
     RECTANGLE(10,60,110,98);
     SETLINESTYLE(0,0,3);
     SETCOLOR(N4);
     LINE(8,62,8,101);
     LINE(8,101,108,101);
     SETCOLOR(14);
     SETTEXTSTYLE(7,0,1);
     OUTTEXTXY(15,70,'MONTAR');

     SETFILLSTYLE(1,N8);
     BAR(150,60,250,98);
     SETCOLOR(N2);
     SETLINESTYLE(0,0,1);
     RECTANGLE(150,60,250,98);
     SETLINESTYLE(0,0,3);
     SETCOLOR(N5);
     LINE(148,62,148,101);
     LINE(148,101,248,101);
     SETCOLOR(14);
     SETTEXTSTYLE(7,0,1);
     OUTTEXTXY(155,70,'ORDENAR');

     SETFILLSTYLE(1,N9);
     BAR(290,60,390,98);
     SETCOLOR(N3);
     SETLINESTYLE(0,0,1);
     RECTANGLE(290,60,390,98);
     SETLINESTYLE(0,0,3);
     SETCOLOR(N6);
     LINE(288,62,288,101);
     LINE(288,101,388,101);
     SETCOLOR(14);
     SETTEXTSTYLE(7,0,1);
     OUTTEXTXY(295,70,'HEAP');

     SETFILLSTYLE(1,N12);
     BAR(460,60,560,98);
     SETCOLOR(N10);
     SETLINESTYLE(0,0,1);
     RECTANGLE(460,60,560,98);
     SETLINESTYLE(0,0,3);
     SETCOLOR(N11);
     LINE(458,62,458,101);
     LINE(458,101,558,101);
     SETCOLOR(14);
     SETTEXTSTYLE(7,0,1);
     OUTTEXTXY(465,70,'SAIR');
     tecla:=readkey;

      IF TECLA=CHR(77) THEN
       BEGIN
        TECLA_AT:=TECLA_AT+1;
        IF TECLA_AT>4 THEN  TECLA_AT:=1;
       END;

      IF TECLA =CHR(75) THEN
       BEGIN
        TECLA_AT:=TECLA_AT-1;
         IF TECLA_AT<1 THEN
          TECLA_AT:=4;
       END;

       IF TECLA_AT=1 THEN
       BEGIN
        CONDE:=1;
        MEN:='MONTA ARVORE .:GERA UMA ARVORE BINARIA';
        MENSAGEM(MEN);
       END;
       IF TECLA_AT=2 THEN
       BEGIN
        CONDE:=2;
        MEN:='ORDENA ARVORE .:ESTA OPCAO SERA VALIDA SE A ARVORE JA ESTIVER MONTADA';
        MENSAGEM(MEN);
       END;
       IF TECLA_AT=3 THEN
       BEGIN
        CONDE:=3;
        MEN:='MONTA HEAP.:ESTA OPCAO SERA VALIDA SE A ARVORE JA ESTIVER ORDENADA';
        MENSAGEM(MEN);
       END;
       IF TECLA_AT=4 THEN
       BEGIN
        CONDE:=4;
        MEN:='SAI DO SISTEMA E RETORNA AO MS-DOS';
        MENSAGEM(MEN);
       END;

UNTIL TECLA=CHR(13);
END;

PROCEDURE DESENHA;
BEGIN
      WHILE ((CONDE=1) OR (CONDE=2)) AND (AUXVET = TRUE) DO
      BEGIN
       IF CONDE = 1 THEN
        BEGIN
         VETOR;
         TRANSFORMA;
        END;
         SETBKCOLOR(7);
         SETLINESTYLE(0,0,3);
         RECTANGLE(3,3,637,477);
         SETCOLOR(14);
         SETTEXTSTYLE(11,0,4);

         COND:=0;
         { VERIFICA A POSICAO DO CARACTER DENTRO DO CIRCULO }
         REPEAT
            TAM:=LENGTH(VETSTR[1]);
            CASE TAM OF
               1:BEGIN
                    XX:=2;
                    COND:=1;
               END;
               2:BEGIN
                    XX:=6;
                    COND:=1;
               END;
               3:BEGIN
                    XX:=10;
                    COND:=1;
               END;
            END;
         UNTIL COND=1;

         { DESENHA O PRIMEIRO CIRCULO }
         SETCOLOR(14);
         SETTEXTSTYLE(1,0,3);
         OUTTEXTXY(288,170,'Arvore');
         SETCOLOR(8);
         CIRCLE(322,146,16);
         SETLINESTYLE(0,0,1);
         SETCOLOR(15);
         CIRCLE(320,145,16);
         SETCOLOR(7);
         FOR J:=15 DOWNTO 0 DO
            CIRCLE(320,145,J);
         SETCOLOR(14);
         SETTEXTSTYLE(11,0,2);
         OUTTEXTXY(320-xx,144,VETSTR[1]);
         Z:=1;NIV:=0;

         IF NELEM<>1 THEN
         BEGIN
            REPEAT
              IF Z<NELEM THEN
               BEGIN
                  INC(NIV);
               END;
               Z:=Z*2;
            UNTIL Z>NELEM;
         END;

         REF:=1;
         LIM:=1;
         Y:=145;CONT:=1;
         LANT:=1;
         VCONT:=2;
         SETCOLOR(14);
         SETTEXTSTYLE(11,0,3);
         OUTTEXTXY(20,80,'Vetor');
         VX:=20;VX1:=50;VY:=0;

         { DESENHA O PRIMEIRO RETANGULO}
         SETCOLOR(14);
         SETLINESTYLE(0,0,1);
         RECTANGLE(VX,90+VY,VX1,105+VY);
         SETCOLOR(8);
         SETTEXTSTYLE(11,0,1);
         OUTTEXTXY(VX+5,95+VY,VETSTR[1]);
         SETLINESTYLE(0,0,1);
         LINE(VX-1,91+VY,VX-1,106+VY);
         LINE(19,106,49,106);
         VX:=VX+30;VX1:=VX1+30;

         REPEAT
            LIM:=LIM*2;LIMG:=LIM;
            Y:=Y+70;
            IF LIM+REF>NELEM THEN
            BEGIN
               lim:=nELEM-ref;
            end;
            ond:=-1;
            c1:=-1;
            k:=1;
            cont1:=0;
            for j:=1 to lim do
            begin
               cond:=0;
               repeat
                  tam:=length(vetSTR[vcont]);
                  case tam of
                       1:begin
                            xx:=2;
                            cond:=1;
                         end;
                       2:begin
                            xx:=6;
                            cond:=1;
                         end;
                       3:begin
                            Xx:=10;
                            cond:=1;
                         End;
                  end;
               until cond=1;

               { DESENHA DEMAIS VETORES }
               setcolor(14);
               setlinestyle(0,0,1);
               rectangle(vx,90+vy,vx1,105+vy);
               setcolor(8);
               settextstyle(11,0,1);
               outtextxy(vx+5,95+vy,vetSTR[vcont]);
               setlinestyle(0,0,1);
               line(vx-1,106+vy,vx1-1,106+vy);
               vx:=vx+30;vx1:=vx1+30;
               IF SOM=2 THEN
                  line(19,91+vy,19,106+vy);
               SOM:=1;
               if vx1>637 then
               begin
                  vy:=18;
                  vx:=20;
                  vx1:=50;
                  SOM:=2;
               end;
               inc(vcont);
               c1:=c1+2;
               z1:=c1*630;
               z2:=limg*2;
               x:=( z1 div z2)+5;
               setcolor(8);
               setlinestyle(0,0,3);
               circle(x+2,y+1,16);
               setlinestyle(0,0,1);
               setcolor(15);
               circle(x,y,16);
               setcolor(7);
               for i:=15 downto 0 do
                  circle(x,y,i);
               setcolor(14);
               settextstyle(11,0,2);
               outtextxy(x-xx,y-4,vetSTR[ref+j]);
               ond:=ond* -1;
               x1:=((k*630) div (lant*2))+5;
               inc(cont1);
               if cont1=2 then
               begin
                  k:=k+2;
                  cont1:=0;
               end;
               setlinestyle(0,0,1);
               setcolor(14);
               line(x,y-18,x1,y-52);
            End;
            lant:=limg;
            ref:=ref+lim;
            cont:=cont+1;
       until cont>=niv+1;

       AUXVET:=FALSE;

       MEN:='TECLE ENTER PARA CONTINUAR';
       MENSAGEM(MEN);
       READ;READLN;
      END;
END;

 PROCEDURE DESENHA_HEAP;
 VAR
  VX,VY,VY1   : INTEGER;
  I             : BYTE;

  BEGIN
  VX:=275;
  VY:=145;
  VY1:=160;
  SETCOLOR(14);
  SETLINESTYLE(0,0,3);
  RECTANGLE(3,3,637,477);
  SETCOLOR(14);
  SETTEXTSTYLE(11,0,4);
  SETCOLOR(14);
  SETTEXTSTYLE(7,0,4);
  OUTTEXTXY(210,94,'P I L H A');
  FOR I:=1 TO NELEM DO
   BEGIN
    SETCOLOR(14);
    SETLINESTYLE(0,0,1);
    RECTANGLE(VX,VY,VX+30,VY1);
    SETCOLOR(8);
    SETTEXTSTYLE(11,0,1);
    OUTTEXTXY(VX+4,VY+4,VETSTR[I]);
    VY:=VY1;
    VY1:=VY1+15;
     IF VY >= 300 THEN
      BEGIN
       VY:=145;
       VY1:=160;
       VX:=VX+49;
      END;
    END;
   MEN:='TECLE ENTER PARA CONTINUAR';
   MENSAGEM(MEN);
   SETCOLOR(15);
   SETLINESTYLE(0,0,1);
   RECTANGLE(120,350,530,400);
   SETCOLOR(8);{Cor das linhas sombra}
   SETLINESTYLE(0,0,3);{estilo das linhas sombra}
   SETTEXTSTYLE(11,0,4);{estilo do texto}
   LINE(118,362,118,402);
   LINE(118,402,528,402);
   SETFILLSTYLE(1,7);
   OUTTEXTXY(125,360,'PILHA GERADA PELA ORDENACAO DE UMA ARVORE BINARIA');
   OUTTEXTXY(200,380,'ATRAVES DO METODO HEAPSORT.');
 END;

BEGIN
   disp:=detect;
   Initgraph(modo,disp,'');
   CONDE:=1;

  WHILE CONDE<> 4 DO
   BEGIN
      AUXVET:=TRUE;
      setfillstyle(1,7);
      bar(1,1,640,480);
      INICIAL(CONDE);
      IF CONDE = 1 THEN
       BEGIN
        LIMPA_TELA;
        CONDE:=1;
        DESENHA;
        READLN;
        AUXCONDE2:=TRUE;
       END;
       IF CONDE = 2 THEN
        BEGIN
         LIMPA_TELA;
         RELOGIO;
         IF AUXCONDE2 = TRUE THEN
          BEGIN
           CRIA_VET_TRAB;
           ORDENA_ARVORE;
           TRANSFORMA;
           LIMPA_TELA;
           DESENHA;
           AUXCONDE3:=TRUE;
          END;
        END;
       IF CONDE = 3 THEN
        BEGIN
        LIMPA_TELA;
        IF AUXCONDE3 = TRUE THEN
         BEGIN
          MONTA_HEAP;
          TRANSFORMA;
          LIMPA_TELA;
          DESENHA_HEAP;
          TECLA:=READKEY;
         END;
        END;
     END;
   closegraph;
   CLRSCR;
end.


