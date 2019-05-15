PROGRAM MEDIA_DO_ALUNO;
USES CRT;
VAR
   NOME,DISCIPLINA              : STRING;
   N1,N2,N3,SOMA,MEDIA,QUARTA   : REAL;
   CHAVE                        : CHAR;
BEGIN
   CLRSCR;
   WINDOW(1,1,78,6);
   TEXTBACKGROUND(13);
   CLRSCR;

   WINDOW(3,2,80,8);
   TEXTBACKGROUND(15);
   TEXTCOLOR(0);
   CLRSCR;
   GOTOXY(8,2);
   WRITE('T R A B A L H O  D E  A N A L I S E  D E  A L G O R I T M O ');
   GOTOXY(18,4);
   WRITE('SOLICITADO PELA PROFESSORA : CRISTINA');
   GOTOXY(10,6);
   WRITE('DIGITE AS NOTAS N1, N2 E N3 PARA O CALCULO DA MEDIA');
   WINDOW(1,8,80,25);
   TEXTBACKGROUND(0);
   TEXTCOLOR(15);
   CLRSCR;
   CHAVE := 'S';
   WHILE (CHAVE<>'N') AND (CHAVE<>'n') DO
      BEGIN
        CLRSCR;
        WRITELN;
        WRITE('QUAL O NOME DO ALUNO :');
        READLN(NOME);
        WRITE('QUAL A DISCIPLINA :');
        READLN(DISCIPLINA);
        WRITE('ENTRE COM A PRIMEIRA NOTA: ');
        READLN(N1);
        WRITE('ENTRE COM A SEGUNDA NOTA: ');
        READLN(N2);
        WRITE('ENTRE COM A TERCEIRA NOTA: ');
        READLN(N3);
        WRITELN;
        SOMA := (N1+N2+N3);
        MEDIA := SOMA/3;
        IF MEDIA > 7 THEN
          BEGIN
          WRITE('O ALUNO ',NOME,' FOI APROVADO NA DISCIPLINA ',DISCIPLINA,' COM MEDIA ',MEDIA:0:2);
          END
        ELSE
           QUARTA := (20 - SOMA);
           IF MEDIA < 7 THEN
              IF QUARTA = 0 THEN
                 BEGIN
                    WRITE('O ALUNO NECESSITA SO ASSINAR A PROVA');
                 END
              ELSE
                   WRITE('O ALUNO ',NOME,' PRECISA TIRAR NA QUARTA PROVA: ',QUARTA:0:2);

        GOTOXY(19,15);
        WRITE('DESEJA FAZER OUTRA CONSULTA (S/N)');
        CHAVE := READKEY;
        CLRSCR;
      END;
END.

