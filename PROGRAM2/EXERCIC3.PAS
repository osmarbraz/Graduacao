PROGRAM EXERCICIO_3;
USES CRT;
VAR
    N,E,T : STRING [25];
    TECLA : CHAR;
BEGIN
    CLRSCR;
    WRITE('NOME     :');
    READLN(N);
    WRITE('ENDERECO :');
    READLN(E);
    WRITE('TELEFONE :');
    READLN(T);
    WRITELN;
    WRITELN('NOME     :',N);
    WRITELN('ENDERECO :',E);
    WRITELN('TELEFONE :',T);
    TECLA := READKEY;
END.