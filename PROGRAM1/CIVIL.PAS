PROGRAM CIVIL;
USES CRT;
VAR
   X : INTEGER;
PROCEDURE AREIA;
VAR
    X,ROP,B,BP,ROF : REAL;

BEGIN
      CLRSCR;
      WRITELN('----- CONSIDERA�OES DO TERZACK E PECK PARA AREIA ------');
      WRITELN;
      WRITELN('        �       � 2');
      WRITELN('�f = �p � 2 . B � ');
      WRITELN('        ������� � ');
      WRITELN('        � B + Bp�');
      WRITELN('        �       �');
      WRITELN;
      WRITELN('ENTRE COM �P');
      READLN(ROP);
      WRITELN('ENTRE COM B');
      READLN(B);
      WRITELN('ENTRE COM Bp');
      READLN(BP);
      X:= SQR((2*B)/(B+BP));
      ROF := ROP *(X);
      WRITE('CONSIDERA�OES DE TERZACK PARA AREIA �f  = ',ROF:0:2);
      REPEAT UNTIL KEYPRESSED;
END;
PROCEDURE ARGILA;
VAR
   ROF,ROP,B,BP :REAL;

BEGIN
     CLRSCR;
     WRITELN('---- CONSIDERA�OES DE TERZACK E PECK PARA ARGILA -----');
     WRITELN;
     WRITELN('        �    � ');
     WRITELN('�f = �p � B  � ');
     WRITELN('        ���� � ');
     WRITELN('        � Bp � ');
     WRITELN('        �    � ');
     WRITELN(' ENTRE COM �p');
     READLN(ROP);
     WRITELN('ENTRE COM B');
     READLN(B);
     WRITELN('ENTRE COM BP');
     READLN(BP);
     ROF := ROP * (B/BP);
     WRITELN;
     WRITELN('CONSIDERA�OES DE TERZACK PARA ARGILA �f = ',ROF:0:2);
     REPEAT UNTIL KEYPRESSED;
END;
PROCEDURE MENU;

BEGIN
     CLRSCR;
     WRITELN(' ----------- MENU PRINCIPAL ----------------');
     WRITELN;
     WRITELN(' CONSIDERA�OES DE TERZAGHI E PECK PARA:');
     WRITELN;
     WRITELN(' 1 --------  AREIA');
     WRITELN(' 2 --------  ARGILA');
     WRITELN(' 3 --------  FIM');
END;
BEGIN
     CLRSCR;
     REPEAT
          MENU;
          READLN(X);
          CASE X OF
             1 : AREIA;
             2 : ARGILA;
             END;
     UNTIL X = 3;
END.