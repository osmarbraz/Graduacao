PROGRAM MENU_BARRA;
USES CRT;
CONST
     CIMA = 72;
     BAXO = 80;
     DIRE = 77;
     ESQU = 75;
VAR
   NMO  :ARRAY[1..8] OF STRING;
   T    :CHAR;
   L,N  :INTEGER;

PROCEDURE PARACIMA;
                BEGIN
                     IF L = 4  THEN
                        BEGIN
                             L := L + 3;
                             N := N + 3;
                        END
                      ELSE
                         BEGIN
                              L := L - 1;
                              N := N - 1;
                         END;

                     TEXTBACKGROUND (15);
                     WINDOW (3,3,28,8);
                     CLRSCR;
                     GOTOXY (2,2);
                     WRITE (NMO[1]);
                     GOTOXY (2,3);
                     WRITE(NMO[2]);
                     GOTOXY (2,4);
                     WRITE (NMO[3]);
                     GOTOXY (2,5);
                     WRITE (NMO[4]);
                     TEXTBACKGROUND(RED);
                     WINDOW (4,L,27,L);
                     CLRSCR;
                     WRITE (NMO[N]);
                     T := READKEY;
                 END;

PROCEDURE PARABAIXO;
                 BEGIN
                      IF L = 7  THEN
                        BEGIN
                             L := L - 3;
                             N := N - 3;
                        END
                      ELSE
                         BEGIN
                              L := L + 1;
                              N := N + 1;
                         END;
                      TEXTBACKGROUND (15);
                      WINDOW (3,3,28,8);
                      CLRSCR;
                      GOTOXY (2,2);
                      WRITE (NMO[1]);
                      GOTOXY (2,3);
                      WRITE (NMO[2]);
                      GOTOXY (2,4);
                      WRITE (NMO[3]);
                      GOTOXY (2,5);
                      WRITE (NMO[4]);
                      TEXTBACKGROUND (RED);
                      WINDOW (4,L,28,L);
                      CLRSCR;
                      WRITE (NMO[N]);
                      T  := READKEY
                 END;


BEGIN
     L := 4;
     N := 1;
     NMO[1] := 'BRAHMA';
     NMO[2] := 'SKOL';
     NMO[3] := 'ANTARTICA';
     NMO[4] := 'KAYSER';
     NMO[5] := 'SCHINCARIOL';
     NMO[6] := 'BELCO';
     NMO[7] := 'CARACU';
     NMO[8] := 'MALTNOJENTA';

     REPEAT

          TEXTBACKGROUND (0);
          CLRSCR;
          TEXTCOLOR (15);
          GOTOXY (20,1);
          WRITE ('QUAL VOCE PREFERE ?');
          TEXTCOLOR (0);
          TEXTBACKGROUND (15);
          WINDOW (3,3,60,8);
          CLRSCR;
          GOTOXY (2,2);
          WRITE (NMO[1]);
          GOTOXY (2,3);
          WRITE (NMO[2]);
          GOTOXY (2,4);
          WRITE (NMO[3]);
          GOTOXY (2,5);
          WRITE (NMO[4]);
          GOTOXY (27,2);
          WRITE (NMO[5]);
          GOTOXY (27,3);
          WRITE (NMO[6]);
          GOTOXY (27,4);
          WRITE (NMO[7]);
          GOTOXY (27,5);
          WRITE (NMO[8]);
          TEXTBACKGROUND (RED);
          WINDOW (4,L,28,L);
          CLRSCR;
          WRITE (NMO[N]);
          T := READKEY;

          CASE ORD(T) OF

          CIMA : PARACIMA;
          BAXO : PARABAIXO;
          DIRE : BEGIN
                      TEXTBACKGROUND (15);
                      CLRSCR;
                      GOTOXY (27,2);
                      WRITE (NMO[5]);
                      GOTOXY (27,3);
                      WRITE (NMO[6]);
                      GOTOXY (27,4);
                      WRITE (NMO[7]);
                      GOTOXY (27,5);
                      WRITE (NMO[8]);
                      TEXTBACKGROUND (RED);
                      WINDOW (29,L,48,L);
                      CLRSCR;
                      WRITE (NMO[N+4]);
                      T := READKEY
                 END;

         END;
    UNTIL T = #27
END.