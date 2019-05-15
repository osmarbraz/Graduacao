(**************************************************************************)
(*     BY OSMAR DE OLIVEIRA BRAZ JUNIOR  EM 09/06/94 TUBARAO - SC         *)
(**************************************************************************)

UNIT MY_WAY;

INTERFACE

  PROCEDURE beep1 (freq,time :INTEGER);
  PROCEDURE beep;
  PROCEDURE janelaD (c1,l1,c2,l2 :INTEGER);
  PROCEDURE janelaS (c1,l1,c2,l2 :INTEGER);
  PROCEDURE janelaDS (c1,l1,c2,l2 :INTEGER);
  PROCEDURE janelaSD (c1,l1,c2,l2 :INTEGER);
  PROCEDURE cursor (x,y : BYTE);
  PROCEDURE cursor_on;
  PROCEDURE cursor_off;
  PROCEDURE cursor_cheio;
  PROCEDURE data (x1,y1 : INTEGER);
  PROCEDURE Hora (x1,y1:INTEGER);
  PROCEDURE LinhaSimples (x1,y1,tam : INTEGER);
  PROCEDURE LinhaDupla (x1,y1,tam : INTEGER);
  PROCEDURE Centrar (y1:integer;texto:string);
  PROCEDURE escreva (x,y : BYTE; cadeia : string);
  PROCEDURE maiscula (VAR cadeia : STRING);


IMPLEMENTATION

USES DOS,CRT;

VAR
   R     : Registers;


(**************************************************************************)

PROCEDURE beep1( freq,time :INTEGER );
BEGIN
  SOUND(freq);
  DELAY(time);
  NOSOUND;
END;

(**************************************************************************)

PROCEDURE beep;
BEGIN
  SOUND(1000);
  DELAY(1000);
  NOSOUND;
END;

(**************************************************************************)

PROCEDURE janelad(c1,l1,c2,l2 :INTEGER);
VAR
  l,c :INTEGER;
BEGIN
     WINDOW(1,1,80,25);
     GOTOXY(c1,l1);
     WRITE('É');
     GOTOXY(c2,l1);
     WRITE('»');
     GOTOXY(c1,l2);
     WRITE('È');
     GOTOXY(c2,l2);
     WRITE('¼');
     FOR c:=c1+1 TO c2-1 DO
         BEGIN
              GOTOXY(c,l1);
              WRITE('Í');
              GOTOXY(c,l2);
              WRITE('Í');
         END;
     FOR l:=l1+1 TO l2-1 DO
         BEGIN
              GOTOXY(c1,l);
              WRITE('º');
              GOTOXY(c2,l);
              WRITE('º');
         END;
     WINDOW(c1+1,l1+1,c2-1,l2-1);
END;

(**************************************************************************)

PROCEDURE janelaS(c1,l1,c2,l2 :INTEGER);
VAR
  l,c :INTEGER;
BEGIN
     WINDOW(1,1,80,25);
     GOTOXY(c1,l1);
     WRITE('Ú');
     GOTOXY(c2,l1);
     WRITE('¿');
     GOTOXY(c1,l2);
     WRITE('À');
     GOTOXY(c2,l2);
     WRITE('Ù');
     FOR c:=c1+1 TO c2-1 DO
         BEGIN
              GOTOXY(c,l1);
              WRITE('Ä');
              GOTOXY(c,l2);
              WRITE('Ä');
         END;
     FOR l:=l1+1 TO l2-1 DO
         BEGIN
              GOTOXY(c1,l);
              WRITE('³');
              GOTOXY(c2,l);
              WRITE('³');
         END;
     WINDOW(c1+1,l1+1,c2-1,l2-1);
END;

(**************************************************************************)

PROCEDURE janelaDS(c1,l1,c2,l2 :INTEGER);
VAR
  l,c :INTEGER;
BEGIN
  WINDOW(1,1,80,25);
  GOTOXY(c1,l1);
  WRITE('Õ');
  GOTOXY(c2,l1);
  WRITE('¸');
  GOTOXY(c1,l2);
  WRITE('Ô');
  GOTOXY(c2,l2);
  WRITE('¾');
  FOR c:=c1+1 TO c2-1 DO
     BEGIN
          GOTOXY(c,l1);
          WRITE('Í');
          GOTOXY(c,l2);
          WRITE('Í');
     END;
  FOR l:=l1+1 TO l2-1 DO
      BEGIN
           GOTOXY(c1,l);
           WRITE('³');
           GOTOXY(c2,l);
           WRITE('³');
      END;
  WINDOW(c1+1,l1+1,c2-1,l2-1);
END;

(**************************************************************************)

PROCEDURE janelaSD (c1,l1,c2,l2 :INTEGER);
VAR
  l,c :INTEGER;
BEGIN
  WINDOW (1,1,80,25);
  GOTOXY (c1,l1);
  WRITE ('Ö');
  GOTOXY (c2,l1);
  WRITE ('·');
  GOTOXY (c1,l2);
  WRITE ('Ó');
  GOTOXY (c2,l2);
  WRITE ('½');
  FOR c:=c1+1 TO c2-1 DO
     BEGIN
          GOTOXY (c,l1);
          WRITE ('Ä');
          GOTOXY (c,l2);
          WRITE ('Ä');
     END;
  FOR l:=l1+1 TO l2-1 DO
      BEGIN
           GOTOXY (c1,l);
           WRITE ('º');
           GOTOXY (c2,l);
           WRITE ('º');
      END;
  WINDOW (c1+1,l1+1,c2-1,l2-1);
END;

(**************************************************************************)

PROCEDURE Cursor(x,y:BYTE);
BEGIN
    R.ah:=1;
    R.ch:=x;
    R.cl:=y;
    Intr(16,R);
END;

(**************************************************************************)

PROCEDURE Cursor_on;
BEGIN
   Cursor(6,7);
END;

(**************************************************************************)

PROCEDURE Cursor_off;
BEGIN
   Cursor(8,0);
END;

(**************************************************************************)

PROCEDURE Cursor_Cheio;
BEGIN
   Cursor(0,7);
END;

(**************************************************************************)

PROCEDURE Data(x1,y1:INTEGER);
VAR
       ano,mes,dia,diasemana : WORD;
BEGIN
       GETDATE (ano,mes,dia,diasemana);
       GOTOXY (x1,y1);
       WRITELN (dia,'/',mes,'/',ano);
END;

(**************************************************************************)

PROCEDURE Hora(x1,y1:INTEGER);
VAR
      hora,minuto,segundos,decsegundos : WORD;
BEGIN
      GETTIME (hora,minuto,segundos,decsegundos);
      GOTOXY (x1,y1);
      WRITELN (hora,':',minuto,':',segundos);
END;

(**************************************************************************)

PROCEDURE LinhaSimples(x1,y1,tam:INTEGER);
VAR
      wc : INTEGER;
BEGIN
      GOTOXY (x1,y1);
      FOR wc:=1 TO tam DO
        WRITE(CHR(196));
END;

(**************************************************************************)

PROCEDURE LinhaDupla(x1,y1,tam:INTEGER);
VAR
     wc : INTEGER;
BEGIN
       GOTOXY (x1,y1);
       FOR wc:=1 TO tam DO
         WRITE (CHR(205));
END;

(**************************************************************************)

PROCEDURE Centrar(y1:INTEGER;texto:STRING);
VAR
    x2 : INTEGER;
BEGIN
          x2 := ROUND ((78-LENGTH(texto))/2);
          GOTOXY (x2,y1);
          WRITELN (texto);
END;

(**************************************************************************)

PROCEDURE escreva (x,y : BYTE ; cadeia : STRING);
BEGIN
     GOTOXY (x,y);
     WRITE (cadeia);
END;

(**************************************************************************)

PROCEDURE leitura (VAR caracter : char);
BEGIN
     caracter := READKEY;
     caracter := UPCASE(caracter);
END;

(**************************************************************************)

PROCEDURE maiscula (VAR cadeia : STRING);
VAR
   tam,x : WORD;
BEGIN
     READLN(CADEIA);
     tam := LENGTH(cadeia);
     FOR x:= 1 TO tam DO
         cadeia[x] := UPCASE(cadeia[x]);
END;


END.
