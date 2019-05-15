
PROGRAM EXERCICIOS_1_A;
USES CRT;
VAR
   A,B,C,D,E,F, X1: REAL;
   TECLA          : CHAR;
BEGIN
    CLRSCR;
    WRITELN('DIGITE OS VALORES');
    WRITE ('A = ');
    READLN (A);
    WRITE ('B = ');
    READLN (B);
    WRITE ('C = ');
    READLN (C);
    WRITE ('D = ');
    READLN (D);
    WRITE ('E = ');
    READLN(E);
    WRITE ('F = ');
    READLN (F);
    X1 := (A+B/C) / (D-2*E/F) + 4 * A;
    WRITELN('X1= ',X1:0:2);
    TECLA := READKEY
END.