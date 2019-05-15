{********************************************************************}
{**  UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL -   17-03-94   **}
{**  CURSO DE CIENCIAS DA COMPUTACAO                               **}
{**  PROF : CLAYTON BONELLI  - PROGRAMACAO II                      **}
{**  ALUNO : OSMAR DE OLIVEIRA BRAZ JUNIOR - CCP 8579              **}
{********************************************************************}

PROGRAM FUNCINARIOS;
USES CRT;
TYPE
    FUNCIONARIO = RECORD
                    NOME     : STRING[50];
                    ENDERECO : RECORD
                                 RUA     : STRING[50];
                                 NUMERO  : INTEGER;
                                 BAIRRO  : STRING[20];
                                 CIDADE  : STRING[30];
                                 ESTADO  : STRING[30];
                                 CEP     : STRING[10];
                               END;
                    PROFISSAO : RECORD
                                   CARGO   : RECORD
                                                DEPARTAMENTO : STRING[30];
                                                FUNCAO       : STRING[30];
                                             END;
                                   SALARIO : RECORD
                                                BRUTO           : REAL;
                                                DESCONTO        : REAL;
                                                SALARIOFAMILIA  : REAL;
                                             END;
                                END;
                    DEPENDENTES : RECORD
                                     NUMERO    : BYTE;
                                     DESCRICAO : ARRAY [1..50] OF RECORD
                                                                    NOME  : STRING[50];
                                                                    IDADE : BYTE;
                                                                    FILHO : CHAR;
                                                                  END;
                                  END;
                  END;
VAR
   FUNC                              : ARRAY[1..10] OF FUNCIONARIO;
   AUX                               : FUNCIONARIO;
   NUNDEP,CONT,NUM_DEP_FILHO,MENORES : BYTE;
   X,N,Y,Z,TAMANHO,LINHA,CHAVE       : INTEGER;
   SALARIOLIQUIDO                    : ARRAY[1..10] OF REAL;
   NOME_CONTA                        : ARRAY[1..10] OF STRING[50];
   AUXA,SALFAM                       : REAL;
   AUXB                              : STRING[50];
   TECLA                             : CHAR;
BEGIN
     CLRSCR;
     GOTOXY (19,12);
     WRITE ('QUAL O NUMERO DE FUNCIONARIOS : ');
     READLN (N);
     FOR X:= 1 TO N DO
        BEGIN

{*********************** LEITURA DOS DADOS *****************************}

             CLRSCR;
             GOTOXY (20,1);
             WRITELN ('FICHA DO FUNCIONARIO NUMERO - ',X);
             WRITELN;
             GOTOXY (1,3);
             WRITE ('QUAL O NOME DO FUNCIONARIO : ');
             READLN (FUNC[X].NOME);
             WRITELN;
             WRITELN ('---- ENDERECO -----');
             WRITE('RUA    : ');
             READLN (FUNC[X].ENDERECO.RUA);
             WRITE ('NUMERO : ');
             READLN (FUNC[X].ENDERECO.NUMERO);
             WRITE ('BAIRRO : ');
             READLN (FUNC[X].ENDERECO.BAIRRO);
             WRITE ('CIDADE : ');
             READLN (FUNC[X].ENDERECO.CIDADE);
             WRITE ('ESTADO : ');
             READLN (FUNC[X].ENDERECO.ESTADO);
             WRITE ('CEP    : ');
             READLN (FUNC[X].ENDERECO.CEP);
             WRITELN;
             WRITELN ('***** PROFISSAO *****');
             WRITE ('DEPARTAMENTO : ');
             READLN (FUNC[X].PROFISSAO.CARGO.DEPARTAMENTO);
             WRITE ('FUNCAO       : ');
             READLN (FUNC[X].PROFISSAO.CARGO.FUNCAO);
             WRITE ('SALARIO BRUTO   : ');
             READLN (FUNC[X].PROFISSAO.SALARIO.BRUTO);
             WRITE ('DESCONTO   %    : ');
             READLN (FUNC[X].PROFISSAO.SALARIO.DESCONTO);
             WRITE ('SALARIO FAMILIA : ');
             READLN (FUNC[X].PROFISSAO.SALARIO.SALARIOFAMILIA);
             WRITELN;
             WRITELN ('##### DEPENDENTES #####');
             WRITE ('NUMERO DE DEPENDENTES : ');
             READLN (FUNC[X].DEPENDENTES.NUMERO);
             LINHA := 2;
             FOR NUNDEP := 1 TO FUNC[X].DEPENDENTES.NUMERO DO
                 BEGIN
                      WINDOW (41,3,80,25);
                      GOTOXY (1,LINHA);
                      WRITELN ('DEPENDENTE - ',NUNDEP);
                      WRITE ('NOME         : ');
                      READLN (FUNC[X].DEPENDENTES.DESCRICAO[NUNDEP].NOME);
                      WRITE ('IDADE        : ');
                      READLN (FUNC[X].DEPENDENTES.DESCRICAO[NUNDEP].IDADE);
                      WRITE ('E FILHO (S/N): ');
                      FUNC[X].DEPENDENTES.DESCRICAO[NUNDEP].FILHO := READKEY;
                      WRITELN(FUNC[X].DEPENDENTES.DESCRICAO[NUNDEP].FILHO);
                      LINHA := LINHA + 5;
                 END;
             CLRSCR;
             WINDOW (1,1,80,25);
         END;
         CLRSCR;

{******************** ORDENACAO CRESCENTE DO NOME ************************}

        FOR X := 1 TO N-1 DO
            FOR Y := X+1 TO N DO
                IF FUNC[X].NOME > FUNC[Y].NOME THEN
                   BEGIN
                      AUX := FUNC[X];
                      FUNC[X] := FUNC[Y];
                      FUNC[Y] := AUX;
                   END;

{********************** IMPRESSAO ORDENADA DO NOME ************************}

       WRITELN;
       WRITELN('**** ORDENACAO DOS NOMES ****');
       FOR X:= 1 TO N DO
           BEGIN
              WRITELN;
              WRITELN ('NOME : ',FUNC[X].NOME);
              TECLA := READKEY;
           END;
       TECLA := READKEY;

{********************* CALCULO DO SALARIO LIQUIDO **********************}

        FOR X:= 1 TO N DO
           BEGIN
               NUM_DEP_FILHO := 0;
               FOR Y:= 1 TO FUNC[X].DEPENDENTES.NUMERO DO
                  BEGIN
                      FUNC[X].DEPENDENTES.DESCRICAO[Y].FILHO := UPCASE (FUNC[X].DEPENDENTES.DESCRICAO[Y].FILHO);
                      IF FUNC[X].DEPENDENTES.DESCRICAO[Y].FILHO = 'S' THEN
                         NUM_DEP_FILHO :=  NUM_DEP_FILHO + 1;
                  END;
               SALFAM := FUNC[X].PROFISSAO.SALARIO.SALARIOFAMILIA * NUM_DEP_FILHO;
               SALARIOLIQUIDO[X] := (FUNC[X].PROFISSAO.SALARIO.BRUTO - (FUNC[X].PROFISSAO.SALARIO.BRUTO *
               (FUNC[X].PROFISSAO.SALARIO.DESCONTO/100))) +  SALFAM;
           END;

{***************** IMPRESSAO NOME E SALARIO LIQUIDO **********************}

        WRITELN;
        WRITELN('***** NOME E SALARIO LIQUIDO *****');
        FOR X := 1 TO N DO
            BEGIN
              WRITELN;
              WRITELN('NOME : ',FUNC[X].NOME,' : SALARIO LIQUIDO = ',SALARIOLIQUIDO[X]:0:2);
              TECLA := READKEY;
            END;
        TECLA := READKEY;

{************* RELATORIO DOS FUNCIONARIOS DA CONTABILIDADE *************}

       CHAVE := 0;
       CONT := 0;
       FOR X:= 1 TO N DO
         BEGIN
           MENORES := 0;
           FOR Y := 1 TO FUNC[X].DEPENDENTES.NUMERO DO
               IF FUNC[X].DEPENDENTES.DESCRICAO[Y].FILHO = 'S' THEN
                  IF FUNC[X].DEPENDENTES.DESCRICAO[Y].IDADE < 18 THEN
                     MENORES := MENORES + 1;

           {****** FORMA  MAISCULA ******}

           TAMANHO:= LENGTH (FUNC[X].PROFISSAO.CARGO.DEPARTAMENTO);
           FOR Z := 1 TO TAMANHO DO
               FUNC[X].PROFISSAO.CARGO.DEPARTAMENTO[Z]:=UPCASE (FUNC[X].PROFISSAO.CARGO.DEPARTAMENTO[Z]);

           IF (FUNC[X].PROFISSAO.CARGO.DEPARTAMENTO ='CONTABILIDADE') AND (MENORES > 2) THEN
              BEGIN
                 CONT := CONT + 1;
                 NOME_CONTA[CONT] := FUNC[X].NOME;
                 CHAVE := 1;
              END;
         END;

{*IMPRESAO DOS FUNCIONARIOS DA CONTABILIDADE COM MAIS DE 2 FILHOS <18 ANOS*}

       IF CHAVE <> 0 THEN
         BEGIN
             WRITELN;
             WRITELN('**** FUNCIONARIOS DA CONTABILIDADE COM MAIS DE 2 FILHOS < 18 ANOS ****');
             FOR X:= 1 TO CONT DO
                BEGIN
                    WRITELN;
                    WRITELN('NOME : ',NOME_CONTA[X]);
                 END;
             TECLA := READKEY;
         END
       ELSE
          BEGIN
              WRITELN;
              WRITELN('NAO EXISTE FUNCIONARIOS DA CONTABILIDADE COM MAIS DE ');
              WRITELN('2 FILHOS MENORES DE 18 ANOS');
          END;

{************** ORDENACAO DESCRESCENTE PELO SALARIO BRUTO *****************}

         FOR X:= 1 TO N - 1 DO
            FOR Y:= X + 1 TO N DO
                IF FUNC[X].PROFISSAO.SALARIO.BRUTO < FUNC[Y].PROFISSAO.SALARIO.BRUTO THEN
                   BEGIN
                     AUXA := FUNC[X].PROFISSAO.SALARIO.BRUTO;
                     FUNC[X].PROFISSAO.SALARIO.BRUTO := FUNC[Y].PROFISSAO.SALARIO.BRUTO;
                     FUNC[Y].PROFISSAO.SALARIO.BRUTO := AUXA;
                     AUXB := FUNC[X].NOME;
                     FUNC[X].NOME := FUNC[Y].NOME;
                     FUNC[Y].NOME := AUXB;
                   END;

{************* IMPRESSAO ORDENADA DO NOME E SALARIO BRUTO ****************}

       WRITELN;
       WRITELN('**** NOME E SALARIO BRUTO ORDENADOS DECRESCENTEMENTE ****');
       FOR X:= 1 TO N DO
          BEGIN
               WRITELN;
               WRITELN('NOME : ',FUNC[X].NOME,' SALARIO BRUTO : ',FUNC[X].PROFISSAO.SALARIO.BRUTO:0:2);
          END;
       TECLA := READKEY;
END.
