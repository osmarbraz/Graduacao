{ UNISUL - Universidade do Sul de Santa Catarina
  PESQUISA OPERACIONAL  - SIMPLEX METODO I
 }

PROGRAM METODO_SIMPLEX;
USES CRT;

VAR
  M,N,M1,M2,H,H1,L,C,J1,S,D,OP,R,L0                  :BYTE;
   tecla                                             :CHAR;
  OPCAO                                              :STRING[3];
  LIN,COL,I,J,LPIVO,CPIVO,CONT,LCONT,CCONT,LQX,CVB   :BYTE;
  A,VET,X                                            :ARRAY[0..30,0..30] OF REAL;
  AB,BI,Q,N10,AF                                     :ARRAY[0..30] OF REAL;
  PIVO,MCN,MVDAUX,MVD,QX,F,V                         :REAL;
  Y,T,ESCOLHA,ULT,TESTE                              :BOOLEAN;
  PRE                                                :REAL;
  K,RE ,VA,LINHA,COLUNA                              :INTEGER;


{******** ENTRADA DE DADOS ***********}
PROCEDURE LERDADOS;
 BEGIN
       RE:=N;
       VA:=M;

{********H= COLUNA VARIAVEIS, I= LINHA  RESTRICOES**************}
   FOR I:=1 TO 10 DO
     N10[I]:=0;

{***** INICIALIZANDO *****}
    FOR H:=0 TO 30 DO
      FOR I:=0 TO 30 DO
        BEGIN
            VET[H,I]:=0;
         END;

{ COLOCANDO COEFICIENTE DAS VARIAVEIS }
    FOR H:=0 TO 30 DO
      FOR I:=0 TO 30 DO
        BEGIN
			VET[H,I]:=A[I,H]
         END;

{  *******   INICIALIZANDO PRIMEIRA POSICAO  **** }
        VET[0,0]:=0;
        FOR H:=1  TO  VA+RE  DO
        VET[H,0]:=H;
        R:=VA+1;
         FOR I:=1 TO RE DO
          BEGIN
           VET[0,I]:=R;
            R:=R+1;
          END;

END;

PROCEDURE FINAL;
VAR
   VAR1:BYTE;
   MENOR :REAL;
BEGIN
	CLRSCR;
		WINDOW(1,1,80,25);
		TEXTBACKGROUND(12);
		GOTOXY(23,09);
		WRITELN('O VALOR DE Q(X) E =  ',VET[VA+RE+1,RE+1]:2:2);
	FOR I:=1 TO RE DO
	   BEGIN
		   WRITELN(' X',VET[0,I]:1:0,'= ',VET[RE+VA+1,I]:2:2);
       END;
        TECLA:=READKEY;
        HALT;
END;

{ CALCULANDO O PIVOTIAMENTO}

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
END;

{ PROCERANDO O MENOR NA COLUNA DO MENOR_QX
     OBJETIVA ENCONTRAR A LINHA DO PIVO }

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
         PRE:=10000000;
	 VET[COLUNA,I]:=INT((VET[COLUNA,I])*PRE)/PRE;
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
		   WINDOW(1,1,80,25);
		   TEXTBACKGROUND(12);
		   GOTOXY(25,12);
			 WRITE(' O PROBLEMA NAO TEM SOLUCAO ');
                         tecla:=readkey;
                        HALT;
		   END;
END;



{ PROCURA MENOR EM Q(X), VET[VERIAVEL,RE+1]
    ENCONTRA A COLUNA COM O MENOR VALOR }

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
{		  TECLA:=READKEY;}
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
							 window (1,1,80,25);
							 textbackground(12);
							 GOTOXY(25,12);
							 WRITE('O PROBLEMA TEM INFITAS SOLUCOES');
							 TECLA:=READKEY;
							 FINAL;
							 HALT;
						  END
						ELSE
						 BEGIN
							 window (1,1,80,25);
							 textbackground(12);
							 GOTOXY(25,12);
							 WRITE('O PROBLEMA TEM UNICA SOLUCAO ');
							 TECLA:=READKEY;
                             FINAL;
                             HALT;
                         END
                    END;
               END;
            END;

       IF MENOR=0 THEN
           FINAL;
{      TECLA:=READKEY;}

END;



FUNCTION SETUPCASE(ST:STRING):STRING;

VAR A,B : BYTE;
    AUX : STRING;
BEGIN {1}
AUX:='';
A:=LENGTH(ST);
FOR B:=1 TO A DO
  AUX:=AUX+UPCASE(ST[B]);
SETUPCASE:=AUX;
END; {1}


PROCEDURE VAR_FOLGA(VAR COL,J1:BYTE;ULT:BOOLEAN);

VAR K,Y : BYTE;
BEGIN {2}
   FOR K:=1 TO N DO
     BEGIN  {3}
        IF ULT=TRUE THEN
           BEGIN{4}
              GOTOXY(COL,LIN);
              WRITE('0');
              A[I,J1]:=0;
           END
        ELSE
           BEGIN
              IF K=I THEN
                BEGIN
                   GOTOXY(COL,LIN);
                   WRITE('1');
                   A[I,J1]:=1;
                END
              ELSE
                 BEGIN
                    GOTOXY(COL,LIN);
                    WRITE('0');
                    A[I,J1]:=0;
                 END;
           END;
        COL:= COL+8;
        J1:= J1+1;
     END;
END;

{*************************************}
{        PROGRAMA PRINCIPAL           }
{*************************************}
BEGIN {1}
 FOR I:=0 TO 30 DO
   FOR H:=0  TO 30  DO
     A[I,H]:=0;

  CLRSCR;
  WINDOW(1,1,80,25);
  TEXTBACKGROUND(15);
  CLRSCR;
  WINDOW(11,9,67,17);
  TEXTBACKGROUND(12);
    REPEAT  {R1}
      REPEAT  {R2}
        CLRSCR;
        GOTOXY(8,2);
        WRITELN('MAXIMIZAR OU MINIMIZAR (MAX/MIN)? :');
        GOTOXY(44,2);
        READLN(OPCAO);
      UNTIL (SETUPCASE(OPCAO)='MAX') OR (SETUPCASE(OPCAO)='MIN');{R2}
      IF SETUPCASE(OPCAO) = 'MAX' THEN ESCOLHA:=TRUE
      ELSE ESCOLHA:=FALSE;
      GOTOXY(8,4);
      WRITELN('RESTRICOES : ');
      GOTOXY(23,4);
      READLN(N);
      GOTOXY(8,6);
      WRITELN('VARIAVEIS : ');
      GOTOXY(23,6);
      READLN(M);
      CLRSCR;
      WINDOW(9,4,73,22);
      TEXTBACKGROUND(12);
      CLRSCR;
      GOTOXY(12,2);
      WRITELN('PREENCHA A TABELA COM OS COEFICIENTES !');
      COL:=1;
      LIN:=4;
      L:=N+1;
      C:=M+L;
  {   CRIA PRIMEIRA LINHA DO TABELA   }
      FOR H:=1 TO (C+1) DO
        BEGIN {1}
         IF H=1 THEN
            BEGIN {2}
              GOTOXY(COL,LIN);
              WRITE('VB');
              COL:=5;
            END   {2}
         ELSE
          IF H=(C+1) THEN
            BEGIN   {3}
             GOTOXY(COL,LIN);
             WRITE('bi');
             COL:=1;
             LIN:=6
            END     {3}
          ELSE
            BEGIN   {4}
               GOTOXY(COL,LIN);
               WRITE('x',H-1);
               AF[H-1]:=H-1;
               COL:=COL+8;
            END;  {4}
        END;    {3}
  {   CRIA PRIMEIRA COLUNA DO TABLEAUS   }
      M1:=C-M;
      M2:=M+1;
      FOR H1:=1 TO M1 DO
        BEGIN     {5}
          IF H1=M1 THEN
            BEGIN  {6}
              GOTOXY(COL,LIN);
              WRITE('Qx');
              LIN:=6;
              COL:=5;
            END      {6}
          ELSE
            BEGIN      {7}
             GOTOXY(COL,LIN);
             WRITE('x',M2);
             AB[H1]:=M2;
             M2:=M2+1;
             LIN:=LIN+2;
            END;        {7}
        END;            {5}
  {   CARREGA AS INFORMA€åES DO TABLEAUS PARA O ARRAY A:   }
      ULT:=FALSE;    {R1}
      FOR I:=1 TO N+1 DO
        BEGIN          {7}
          FOR J:=1 TO (C-N) DO
            BEGIN        {8}
              IF I <> N+1 THEN
                BEGIN      {9}
                  IF J =(C-N) THEN
                    BEGIN    {10}
                      J1:=J;
                      VAR_FOLGA(COL,J1,ULT);
                      GOTOXY(COL,LIN);
                      READLN(A[I,J1]);
                      COL:=5;
                    END       {10}
                  ELSE
                    BEGIN       {11}
                      GOTOXY(COL,LIN);
                      READLN(A[I,J]);
                      COL:=COL+8;
                    END;       {11}
                END         {9}
              ELSE
                BEGIN       {12}
                  IF J = (C-N) THEN
                    BEGIN      {13}
                      J1:=J;
                      VAR_FOLGA(COL,J1,ULT);
                      GOTOXY(COL,LIN);
                      WRITE('Qx=0');
                      A[I,J1]:=0;
                      COL:=10;
                      LIN:=LIN+1;
                    END        {13}
                  ELSE
                    BEGIN         {14}
                      GOTOXY(COL,LIN);
                      READLN(V);
                      IF ESCOLHA THEN V:=(-1)*V;
                      A[I,J]:=V;
                      COL:=COL+8;
                    END;   {14}
                END;     {  12}
            END;          {8}
          LIN:=LIN+2;
         END;               {7}

      GOTOXY(COL,LIN);
      WRITE('      < PRESSIONE QUALQUER TECLA !!! >');

      TESTE:=FALSE;

     LERDADOS;
     L0:=1;
     WHILE L0=1 DO
        BEGIN
           CLRSCR;
	    WINDOW(1,1,80,25);
           TEXTBACKGROUND(12);


       MENOR_QX;
       MINIMO;
       CALCULO;
       END;

   UNTIL MCN >= 0;

END.