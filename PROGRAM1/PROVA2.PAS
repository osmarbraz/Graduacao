{ ESTE PROGRAMA TEM POR OBJETIVO : }
{ - DETERMINAR O NOME E O CURSO DO ALUNO MAIS NOVO }
{ - QUAL A PORCENTAGEM DE ALUNOS DE COMPUTACAO COM A IDADE ENTRE 30 E }
{ 40 ANOS E DESTE QUANTOS FORAM APROVADOS }
{ - QUANTOS FORAM O ALUNOS REPROVADOS }

{ VARIAVEIS DE ENTRADA : }
{   NOME    : NOME DO ALUNO }
{   CURSO   : CURSO DO ALUNO }
{   IDADE   : IDADE DO ALUNO }
{   MEDIA   : MEDIA DO ALUNO }

{ VARIAVEIS DE SAIDA : }
{  NOME_NOVO : NOME DO ALUNO MAIS NOVO }
{ CURSO_NOVO : CURSO DO ALUNO MAIS NOVO }
{     PERC   : PERCENTAGEM DOS ALUNOS DE CCP COM IDADE ENTRE 30 E 40 ANOS}
{ REPROVADO  : NUMERO DE ALUNO REPROVADOS (MEDIA < 7) }

{ PROCESSAMENTO : }
{  PERC := (COMPUT/CONT)* 100 }
{  CONT  : NUMERO DE ALUNOS DE COMPUTACAO }
{ COMPUT : NUMERO DE ALUNOS DE COMPUTACAO COM IDADE ENTRE 30 E 40 ANOS }



PROGRAM PROVA_3;
USES CRT;
VAR
    NOME,CURSO,CURSO_NOVO,NOME_NOVO                  : STRING;
    IDADE,MENOR_IDADE,CONT,COMPUT,APROVADO,REPROVADO : INTEGER;
    MEDIA,PERC                                       : REAL;

BEGIN
     CLRSCR;
     PERC := 0;
     CONT := 0;
     COMPUT := 0;
     APROVADO := 0;
     REPROVADO := 0;

     {**** LEITURA DOS DADOS DE ENTRADA ****}

     WRITE ('DIGITE O NOME : ');
     READLN (NOME);
     WRITE ('QUAL O CURSO : ');
     READLN (CURSO);
     WRITE ('QUAL A IDADE : ');
     READLN  (IDADE);
     WRITE ('QUAL A MEDIA FINAL : ');
     READLN (MEDIA);
     MENOR_IDADE := IDADE;
     NOME_NOVO := NOME;
     CURSO_NOVO := CURSO;
     WHILE NOME <> '*' DO
           BEGIN

              {**** PROCURA O NOME E O CURSO DO ALUNO MAIS NOVO ****}

              IF  IDADE < MENOR_IDADE  THEN
                  BEGIN
                  MENOR_IDADE := IDADE;
                  CURSO_NOVO  := CURSO;
                  NOME_NOVO   := NOME;
                  END;

              {**** CONTA O NUMERO DE ALUNOS DE COMPUTACAO ****}

              IF CURSO = 'COMPUTACAO' THEN
                 BEGIN
                 CONT := CONT + 1;

                 {**** CONTA O NUMERO DE ALUNOS DE COMPUTACAO COM IDADE ****}
                 {**** COM IDADE ENTRE 30 E 40 ANOS ****}

                 IF (IDADE >= 30) AND (IDADE<=40) THEN
                    BEGIN
                    COMPUT := COMPUT + 1;
                    IF MEDIA >= 7 THEN
                       APROVADO := APROVADO + 1;
                    END;
                 END;

              {**** CONTA O NUMERO DE ALUNOS REPROVADOS ****}

              IF MEDIA < 7 THEN
                 REPROVADO := REPROVADO + 1;

              {**** LEITURA DOS DADOS DE ENTRADA ****}
              {**** CARTAO BANDEIRA E "*" ****}

              WRITELN ('PARA SAIR DIGITE NOME "*" ');
              WRITE ('QUAL O NOME : ');
              READLN (NOME);
              WRITE ('QUAL O CURSO : ');
              READLN (CURSO);
              WRITE ('QUAL A IDADE : ');
              READLN  (IDADE);
              WRITE ('QUAL A MEDIA FINAL : ');
              READLN (MEDIA);
           END;

           {**** IMPRESSAO DAS SAIDAS ****}

           WRITELN ('O ALUNO MAIS NOVO E ',NOME_NOVO,' DO CURSO ',CURSO_NOVO);
           PERC := (COMPUT/CONT) * 100;
           WRITELN ('A PERCENTAGEM DOS ALUNOS DE COMPUTACAO COM IDADE ENTRE 30 E 40 ANOS E ',PERC:0:0,'%');
           WRITELN ('E DESTES ',APROVADO,' FORAM APROVADOS');
           WRITELN ('O NUMERO DE REPROVADOS FOI DE : ',REPROVADO);
END.
