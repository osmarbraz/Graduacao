PROGRAM EXERCICIO_1_A;
USES CRT;
VAR
  A,B,C,X1 : REAL;
  TECLA    : CHAR;
BEGIN
    CLRSCR;
    WRITELN('DIGITE OS VALORES');
    WRITE ('A= ');
    READLN (A);
    WRITE ('B= ');
    READLN(B);
    WRITE ('C= ');
    READLN (C);
    X1 := (-B-(EXP(LN(B)*3))-4*A*C) / (SQR(2*A/B+1)) + SQR (1/2*A);
    WRITELN ('X1= ', X1:0:2);
    TECLA := READKEY;
 END.
