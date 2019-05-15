(***********************************************************************)
(**        UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL             **)
(**               CURSO DE CIENCIAS DA COMPUTACAO                     **)
(**       ACADEMICO OSMAR DE OLIVEIRA BRAZ JUNIOR CCP - 8579          **)
(**             DISCLIPLIA DE ESTRUTURA DE DADOS I                    **)
(***********************************************************************)

PROGRAM FICHA_ALUNO;
USES CRT;

TYPE
   DOIS = STRING[2];
   FICH =  RECORD
                    NOME : STRING[30];
                    DATA : RECORD
                                 DIA,MES,ANO : DOIS;
                           END;
                    CODIGO    : STRING[7];
                   END;
VAR
   FICHA : FICH;

(***** PROCEDURE DE POSICIONAMENTO DE LEITURA ********)

PROCEDURE LEIA(X,Y : BYTE ; VAR CADEIA :DOIS);
BEGIN
    GOTOXY(X,Y);
    READLN(CADEIA);
END;

(****** PROCEDURE TESTE PARA LOCALIZAR NUMEROS ********)

PROCEDURE TEST (VAR N : CHAR; VAR VAL : BYTE);

VAR
   X : BYTE;
   NE : STRING[1];
BEGIN
     IF (N='0') OR (N='1') OR (N='2') OR (N='3') OR (N='4')
        OR (N='5') OR (N='6') OR (N='7') OR (N='8') OR (N='9') THEN
           VAL := 0
     ELSE
         VAL := 1;
END;


(****** PROCEDURE PARA PREENCHER O NOME *********)

PROCEDURE PREENCHA_NOME(VAR N : FICH);
VAR
   A,TAM,X : INTEGER;
   P,TECLA       : CHAR;

BEGIN
     CLRSCR;
     A:=0;
     WHILE A<> 1 DO
          BEGIN
             WRITE('DIGITE O NOME DO ALUNO :');
             READLN(N.NOME);
             TAM := LENGTH(N.NOME);
             FOR X:= 1 TO TAM DO
                BEGIN
                    P:=N.NOME[X];
                    IF (P='0') OR (P='1') OR (P='2') OR (P='3') OR (P='4')
                       OR (P='5') OR (P='6')
                       OR (P='7') OR (P='8') OR (P='9') THEN
                       A:= 0
                END;
              A:= 1;
              IF A=0 THEN
                 BEGIN
                     WRITE('VOCE TEM QUE ESSE NOME ESTA CERTO ? (S/N)');
                     TECLA := READKEY;
                     TECLA := UPCASE(TECLA);
                     IF TECLA='S' THEN
                         A:=1
                     ELSE
                         WRITELN('PORTANTO DIGITE-O NOVAMENTE!!!!');

                 END;
          END;
END;

(****** PROCEDURE PARA PREENCHER A DATA *********)

PROCEDURE PREENCHA_DATA (VAR D:FICH);
VAR
  A,X,VAL : BYTE;

BEGIN
     A := 0;
     WHILE A <> 1 DO
        BEGIN
             A:=1;
             CLRSCR;
             WRITElN('DIGITE A DATA DE NASCIMENTO');
             WRITELN('DIGITE CADA DATA E PRESSIONE <ENTER>');
             WRITELN('  /  /  ');
             WITH D.DATA DO
                  BEGIN
                       LEIA (1,3,DIA);
                       LEIA (4,3,MES);
                       LEIA (7,3,ANO);
                       IF (DIA[1]<>'0') AND (DIA[1]<>'1') AND (DIA[1]<>'2')
                          AND (DIA[1]<>'3') THEN
                          BEGIN
                             WRITELN('DIA INVALIDO 1 ');
                             A := 0;
                          END
                       ELSE
                          BEGIN
                            TEST(DIA[2],VAL);
                            IF VAL <> 0 THEN
                               BEGIN
                                    WRITELN('DIA INVALIDO 2');
                                     A := 0;
                               END
                            ELSE
                               IF (DIA[1]='3') AND (DIA[2]<>'0') AND
                                  (DIA[2]<>'1') THEN
                                   BEGIN
                                       WRITELN('DIA INVALIDO 3');
                                       A := 0;
                                   END
                              ELSE
                                IF (MES[1]<>'0') AND (MES[1]<>'1') THEN
                                    BEGIN
                                         WRITELN('MES INVALIDO 4');
                                         A:=0;
                                    END
                                 ELSE
                                  IF (MES[1]='1') AND (MES[2]='3') OR (MES[2]='4')
                                    OR (MES[2]='5') OR (MES[2]='6') OR (MES[2]='7')
                                    OR (MES[2]='8') OR (MES[2]='9') THEN
                                          BEGIN
                                            WRITELN('MES INVALIDO 5');
                                            A:=0;
                                          END
                                      ELSE
                                         IF (MES[1]='0') AND (MES[2]='2') AND
                                            (DIA[1]='3') THEN
                                             BEGIN
                                                 WRITELN('DATA INVALIDA FEVEREIDO');
                                                 A:=0;
                                            END
                                         ELSE
                                            BEGIN
                                                 TEST (ANO[1],VAL);
                                                 IF VAL <> 0 THEN
                                                    BEGIN
                                                        WRITELN('ANO INVALIDO 1');
                                                        A:=0;
                                                    END;
                                                 TEST (ANO[2],VAL);
                                                 IF VAL <> 0 THEN
                                                    BEGIN
                                                        WRITELN('ANO INVALIDO 2');
                                                        A:= 0;
                                                    END;
                                             END;

                         END;
                  END;
           IF A=0 THEN
             BEGIN
                WRITELN('PRESSIONE <ENTER> E DIGITE A DATA NOVAMENTE!!!');
                READLN;
             END;

        END;
END;

(****** PROCEDURE PARA PREENCHER O CODIGO *********)

PROCEDURE PREENCHA_CODIGO (VAR C:FICH);
VAR
   B,TAM,VAL,W,TEST_NUM,CHAVE : BYTE;
   CURSO     : STRING[3];

BEGIN
     B := 0;
     WHILE B <> 1 DO
         BEGIN
             B:=1;
             WRITE('DIGITE SEU CODIGO : ');
             READLN(C.CODIGO);
             TAM := LENGTH (C.CODIGO);
             IF (TAM <>7) THEN
                BEGIN
                   WRITELN('CODIGO INVALIDO');
                   B:=0;
                END
             ELSE
                BEGIN
                    CURSO := UPCASE(C.CODIGO[1]) + UPCASE(C.CODIGO[2])
                             + UPCASE(C.CODIGO[3]);
                    IF (CURSO<>'CCP') AND (CURSO<>'ECV') AND (CURSO<>'QUI') AND
                        (CURSO<>'CCO') AND (CURSO<>'CIE') AND (CURSO<>'CIE') THEN
                         BEGIN
                            WRITELN('CODIGO DO CURSO INVALIDO');
                            B:=0;
                         END
                    ELSE
                        BEGIN
                             TEST_NUM := 1;
                             FOR W := 4 TO 7 DO
                                BEGIN
                                    TEST(C.CODIGO[W],VAL);
                                    IF VAL <> 0 THEN
                                       TEST_NUM := 0
                                END;
                             IF TEST_NUM = 0 THEN
                                BEGIN
                                   WRITELN('CODIGO NUMERICO INVALIDO ');
                                   B:=0;
                                END;
                        END;

             END;
         IF B=0 THEN
            BEGIN
               WRITELN;
               WRITELN('SEU CODIGO ESTA INVALIDO DIGITE NOVAMENTE');
               WRITELN('PRESSIONE <ENTER>');
               READLN;
            END;
         END;
END;

(*** PROCEDURE PREENCHA *******)

PROCEDURE PREENCHA(VAR F : FICH);
VAR
    A : BYTE;
    TECLA : CHAR;

BEGIN
     A:= 1;
     WHILE A<>0 DO
       BEGIN
          PREENCHA_NOME(F);
          PREENCHA_DATA(F);
          PREENCHA_CODIGO(F);
          WRITELN('VOCE DESEJA FAZER UMA NOVA FICHA (S/N) ?');
          TECLA :=READKEY;
          TECLA := UPCASE(TECLA);
          IF TECLA = 'S' THEN
             A:=1
          ELSE
             A:=0;
       END;
       WRITELN;
       WRITELN('SUA FICHA E A SEGUINTE :');
       WRITELN('NOME DO ALUNO      :',F.NOME);
       WRITELN('DATA DE NASCIMENTO : ',F.DATA.DIA,'/',F.DATA.MES,'/',F.DATA.ANO);
       WRITELN('CODIGO DO CURSO    : ',F.CODIGO);
       TECLA := READKEY;

END;


(*** PROGRAMA PRINCIPAL****)

BEGIN
     CLRSCR;
     PREENCHA(FICHA);
END.