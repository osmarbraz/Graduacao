{*************************************************************************}
{* Aluno : Osmar de Oliveira Braz junior  CCP -8579                      *}
{* Exercicio de Programacao II                     10/03/94              *}
{* Professor : Clayton Bonelli                                           *}
{* Este programa ordena um vetor X  com N campos do tipo RECORD          *}
{*************************************************************************}


PROGRAM ILUSTRA_RECORD;
USES CRT;
TYPE CAMPOS =  RECORD

                                    NOME     : STRING[50];
                                    SEMESTRE : STRING[10];
                                    SALA     : STRING[5];
                                    CURSO    : STRING[15];
                                    NOTA     : ARRAY [1..6] OF REAL;
                                    ENDERECO : RECORD
                                                     RUA     : STRING[50];
                                                     BAIRRO  : STRING[15];
                                                     CIDADE  : STRING[15];
                                                     ESTADO  : STRING[15];
                                                     CEP     : STRING[9];
                                               END;
                END;
VAR
   ALUNO        : ARRAY [1..50] OF CAMPOS;
   AUX          : CAMPOS;
   X,Y,N        : INTEGER;
   TECLA        : CHAR;
BEGIN
     CLRSCR;
     WRITE ('QUAL O NUMERO DE ALUNOS : ');
     READLN (N);
     FOR X := 1 TO N DO
        BEGIN
             WRITELN;
             WRITELN ('DIGITE OS DADOS DO ALUNO - ',X);
             WRITE ('DIGITE O NOME     : ');
             READLN (ALUNO[X].NOME);
             WRITE ('DIGITE O SEMESTRE : ');
             READLN (ALUNO[X].SEMESTRE);
             WRITE ('DIGITE A SALA     : ');
             READLN (ALUNO[X].SALA);
             WRITE ('DIGITE O CURSO    : ');
             READLN (ALUNO[X].CURSO);
             FOR Y := 1 TO 6 DO
                 BEGIN
                      WRITE ('DIGITE A NOTA - ',Y,' = ');
                      READLN (ALUNO[X].NOTA[Y]);
                 END;
             WRITELN ('-- ENDERECO --');
             WRITE ('DIGITE A RUA    : ');
             READLN(ALUNO[X].ENDERECO.RUA);
             WRITE ('DIGITE O BAIRRO : ');
             READLN (ALUNO[X].ENDERECO.BAIRRO);
             WRITE ('DIGITE A CIDADE : ');
             READLN (ALUNO[X].ENDERECO.CIDADE);
             WRITE ('DIGITE O ESTADO : ');
             READLN (ALUNO[X].ENDERECO.ESTADO);
             WRITE ('DIGITE O CEP : ');
             READLN (ALUNO[X].ENDERECO.CEP);
        END;

        {***** ORDENACAO DOS CAMPOS *****}

        FOR X := 1 TO N - 1 DO
           FOR Y := 2 TO N DO
               IF ALUNO[X].NOME > ALUNO[Y].NOME THEN
                  BEGIN

                        AUX := ALUNO[X];
                        ALUNO[X] := ALUNO[Y];
                        ALUNO[Y] := AUX;



                  END;
        FOR X := 1 TO N DO
           BEGIN
                 WRITELN;
                 WRITELN ('ALUNO    : ',ALUNO[X].NOME);
                 WRITELN ('SEMESTRE : ',ALUNO[X].SEMESTRE);
                 WRITELN ('SALA     : ',ALUNO[X].SALA);
                 WRITELN ('CURSO    : ',ALUNO[X].CURSO);
                 FOR Y := 1 TO 6 DO
                          WRITELN('NOTAS - ',Y,' = ',ALUNO[X].NOTA[Y]:0:0);
                 WRITELN ('RUA     : ',ALUNO[X].ENDERECO.RUA);
                 WRITELN ('BAIRRO  : ',ALUNO[X].ENDERECO.BAIRRO);
                 WRITELN ('CIDADE  : ',ALUNO[X].ENDERECO.CIDADE);
                 WRITELN ('ESTADO  : ',ALUNO[X].ENDERECO.ESTADO);
                 WRITELN ('CEP     : ',ALUNO[X].ENDERECO.CEP);
                 TECLA := READKEY;
           END;
        TECLA := READKEY;
END.