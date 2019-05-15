
UNIT WINDRT;
INTERFACE
  PROCEDURE BEEP1(FREQ,TIME :INTEGER);
  PROCEDURE BEEP;
  PROCEDURE WINDOWS(C1,L1,C2,L2 :INTEGER);
  PROCEDURE JANELAD(X1,Y1,X2,Y2 :INTEGER);
  PROCEDURE JANELA(X1,Y1,X2,Y2 :INTEGER);
  PROCEDURE CURSOR_ON;
  PROCEDURE CURSOR_OF;

IMPLEMENTATION
 USES DOS,CRT;
type
 T = ARRAY[1..4000] OF CHAR;
    D = record
         WMin,Wmax : word;
        end;

Var
   video : T absolute $b800:0000;
   R     : Registers;
   tela  : array [1..16] of T;
   coord : array [1..16] of D;
   wc,cw   : integer;
     j_ativ :integer;


PROCEDURE BEEP1( FREQ,TIME :INTEGER );
BEGIN
  SOUND(FREQ);
  DELAY(TIME);
  NOSOUND;
END;
PROCEDURE BEEP;
BEGIN
  SOUND(1000);
  DELAY(1000);
  NOSOUND;
END;
PROCEDURE WINDOWS(C1,L1,C2,L2 :INTEGER);
VAR
  L,C :INTEGER;
BEGIN
  WINDOW(1,1,80,25);
  GOTOXY(C1,L1);
  WRITE('É');
  GOTOXY(C2,L1);
  WRITE('»');
  GOTOXY(C1,L2);
  WRITE('È');
  GOTOXY(C2,L2);
  WRITE('¼');
  FOR C:=C1+1 TO C2-1 DO
     BEGIN
     GOTOXY(C,L1);
      WRITE('Í');
     GOTOXY(C,L2);
     WRITE('Í');
     END;
  FOR L:=L1+1 TO L2-1 DO
    BEGIN
      GOTOXY(C1,L);
      WRITE('º');
      GOTOXY(C2,L);
      WRITE('º');
     END;
    WINDOW(C1+1,L1+1,C2-1,L2-1);
END;
PROCEDURE JANELAD(x1,y1,x2,y2:integer);
var
  wc,cw : integer;
begin
   inc(j_ativ);
   tela[j_ativ]:=video;
   Window(x1,y1,x2,y2+1);
   Write(chr(201));
   for cw:=x1+1 to x2-1 do
      write(chr(205));
   Write(chr(187));
   for wc:=y1+1 to y2-1 do
      begin
        write(chr(186));
        for cw:=x1+1 to x2-1 do
          Write(' ');
        Write(chr(186));
      end;
  write(chr(200));
  for cw:=x1+1 to x2-1 do
     write(chr(205));
  write(chr(188));
  Window(x1+1,y1+1,x2-1,y2-1);
  coord[j_ativ].WMAx := WindMax;
  coord[j_ativ].WMin := WindMin;
end;
PROCEDURE JANELA(x1,y1,x2,y2:integer);
var
  wc,cw : integer;
begin
   inc(j_ativ);
   tela[j_ativ]:=video;
   Window(x1,y1,x2,y2+1);
   Write(chr(213));
   for cw:=x1+1 to x2-1 do
      write(chr(205));
   Write(chr(184));
   for wc:=y1+1 to y2-1 do
      begin
        write(chr(179));
        for cw:=x1+1 to x2-1 do
          Write(' ');
        Write(chr(179));
      end;
  write(chr(212));
  for cw:=x1+1 to x2-1 do
     write(chr(205));
  write(chr(190));
  Window(x1+1,y1+1,x2-1,y2-1);
  coord[j_ativ].WMAx := WindMax;
  coord[j_ativ].WMin := WindMin;
end;

PROCEDURE CURSOR_OF;
BEGIN
  R.AH:=1;
  R.CH:=12;
  R.CL:=5;
    INTR(16,R);
END;

PROCEDURE CURSOR_ON;
BEGIN
   R.AH:=1;
   R.CH:=6;
   R.CL:=7;
     INTR(16,R);
END;


END.