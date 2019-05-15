PROGRAM MEDIA_DE_NOTAS;
USES CRT;
VAR
   MELHOR_ALUNO,NOME_NOTA2,NOME                : STRING [12];
   MAIOR_MEDIA,MELHOR_NOTA2,NOTA1,NOTA2,NOTA3  : REAL;
   SOMA,MEDIA,SOMA_NOTA1,MEDIA_NOTA1           : REAL;
   NUMERO_ALUNO,CONT,CONT1                     : INTEGER;
BEGIN
     CLRSCR;
     MELHOR_ALUNO := 'AA';
     MAIOR_MEDIA := 00;
     MELHOR_NOTA2 := 00;
     NOME_NOTA2 := 'AA';
     NUMERO_ALUNO := 0;
     CONT1 := 0;
     WRITELN ('ESCREVA O NOME DO ALUNO E SUAS 3 NOTAS');
     READLN (NOME);
     WHILE NOME <> 'AAAA' DO
        BEGIN
           READLN (NOTA1);
           READLN (NOTA2);
           READLN (NOTA3);
           SOMA := NOTA1 + NOTA2 + NOTA3;
           MEDIA := SOMA / 3;
           WRITELN ('MEDIA DO ALUNO ',NOME,' = ',MEDIA);
           IF MEDIA >= 5 THEN
              WRITELN ('APROVADO')
           ELSE
              WRITELN ('REPROVADO');
           IF  MEDIA > MAIOR_MEDIA THEN
               BEGIN
                   MELHOR_ALUNO := NOME;
                   MAIOR_MEDIA := MEDIA;
               END;
           IF NOTA2 > MELHOR_NOTA2 THEN
              BEGIN
                   MELHOR_NOTA2 := NOTA2;
                   NOME_NOTA2 := NOME;
              END;
           NUMERO_ALUNO := NUMERO_ALUNO + 1;
           SOMA_NOTA1 := SOMA_NOTA1 + NOTA1;
           CONT := 0;
           IF MEDIA > 4 THEN
              IF NOTA1 > 7 THEN
                 CONT := CONT + 1;
              IF NOTA2 > 7 THEN
                 CONT := CONT + 1;
              IF NOTA3 > 7 THEN;
           IF CONT = 1 THEN
             CONT1 := CONT1 + 1;
           WRITELN ('ESCREVA O NOME DO ALUNO E SUAS 3 NOTAS');
           READLN (NOME)
        END;
     MEDIA_NOTA1 := SOMA_NOTA1 / NUMERO_ALUNO;
     WRITELN (' MELHOR MEDIA ALUNO ',MELHOR_ALUNO,' COM MEDIA ',MAIOR_MEDIA);
     WRITELN (' MELHOR NOTA 2 ALUNO ',NOME_NOTA2,' COM NOTA ',MELHOR_NOTA2);
     WRITELN (' MEDIA DA NOTA 1 = ',MEDIA_NOTA1);
     WRITELN (' NUMERO DE ALUNOS COM MEDIA MAIOR QUE 4 E PELO MENOS UMA NOTA MAIOR QUE 7 = ',CONT1);
     REPEAT UNTIL KEYPRESSED
END.