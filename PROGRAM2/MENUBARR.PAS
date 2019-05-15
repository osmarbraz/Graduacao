PROGRAM MENU_BARRA;
USES CRT;
CONST
     CIMA = 72;
     BAXO = 80;
VAR
   NMO  :ARRAY[1..4] OF STRING;
   T    :CHAR;
   L,N  :INTEGER;

BEGIN
     L := 4;
     N := 1;
     NMO[1] := 'BRAHMA';
     NMO[2] := 'SKOL';
     NMO[3] := 'ANTARTICA';
     NMO[4] := 'KAYSER';
     REPEAT
          TEXTBACKGROUND (0);
          CLRSCR;
          TEXTCOLOR (0);
          TEXTBACKGROUND (15);
          WINDOW (3,3,30,8);
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
          T := READKEY;

          CASE ORD(T) OF

          CIMA : BEGIN
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
                     WINDOW (3,3,30,8);
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
                     WINDOW (4,L,28,L);
                     CLRSCR;
                     WRITE (NMO[N]);
                     T := READKEY;
                 END;
          BAXO : BEGIN
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
                      WINDOW (3,3,30,8);
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
                      T := READKEY
                 END;
        END;
    UNTIL T = #27
END.