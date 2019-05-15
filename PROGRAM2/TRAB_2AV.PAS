(**************************************************************************)
(* UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL - TUBARAO-SC - 09/06/94 *)
(* TRABALHO DE 2 AVALIACAO DE PROGRAMACAO DE COMPUTADORES II              *)
(* PROFESSOR CLAYTON BONELLI                                              *)
(* ACADEMICOS OSMAR DE OLIVEIRA BRAZ JUNIOR - 8579                        *)
(*         E  LUSICLER DE SOUZA MOLON - 3920                              *)
(**************************************************************************)

PROGRAM trabalho_de_2_avaliacao;
USES CRT;
TYPE
    registro = RECORD
                        proximo  : INTEGER;
                        anterior : INTEGER;
                        nome     : STRING[20];
                        telefone : STRING[13];
                        cpf      : STRING[20];
                  END;
VAR
   aux                     : registro;
   arq                     : FILE OF registro;
   primeiro,ultimo         : INTEGER;


(**************************************************************************)

PROCEDURE ordena (VAR primeiro,ultimo,indice : INTEGER ; aux : registro);
VAR
   feito      : BOOLEAN;
   reg,temp   : REGISTRO;
   seguinte   : INTEGER;

BEGIN
     feito := FALSE;
     IF (primeiro = -1) THEN
        BEGIN
             primeiro := 0;
             ultimo := 0;
             aux.proximo := -1;
             aux.anterior := -1;
             SEEK (arq,indice);
             WRITE (arq,aux);
        END
     ELSE
       BEGIN
         SEEK (arq,primeiro);
         READ (arq,reg);
         IF (aux.nome < reg.nome) THEN
            BEGIN
                 reg.anterior := indice;
                 aux.proximo := primeiro;
                 aux.anterior := -1;
                 primeiro := indice;
                 SEEK (arq,aux.proximo);
                 WRITE (arq,reg);
                 SEEK (arq,primeiro);
                 WRITE (arq,aux);
            END
         ELSE
             BEGIN
                  SEEK (arq,ultimo);
                  READ (arq,reg);
                  IF (aux.nome > reg.nome) THEN
                     BEGIN
                          reg.proximo := indice;
                          aux.anterior := ultimo;
                          aux.proximo := -1;
                          ultimo := indice;
                          SEEK (arq,aux.anterior);
                          WRITE (arq,reg);
                          SEEK (arq,reg.proximo);
                          WRITE (arq,aux);
                     END
                  ELSE
                      BEGIN
                           seguinte := primeiro;
                           WHILE (NOT feito) DO
                                 BEGIN
                                      SEEK (arq,seguinte);
                                      READ (arq,temp);
                                      SEEK (arq,temp.proximo);
                                      READ (arq,reg);
                                      IF (aux.nome  > temp.nome)
                                         AND (aux.nome < reg.nome) THEN
                                         BEGIN
                                              aux.anterior := reg.anterior;
                                              aux.proximo := temp.proximo;
                                              temp.proximo := indice;
                                              reg.anterior := indice;
                                              SEEK (arq,aux.anterior);
                                              WRITE (arq,temp);
                                              SEEK (arq,aux.proximo);
                                              WRITE (arq,reg);
                                              SEEK (arq,indice);
                                              WRITE (arq,aux);
                                              feito := TRUE;
                                         END;
                                      seguinte := temp.proximo;
                                 END;

                      END;
             END;
       END;
END;

(**************************************************************************)

PROCEDURE inclusao (VAR primeiro,ultimo : INTEGER);
VAR
   tecla    : CHAR;
   indice   : INTEGER;
BEGIN
     REPEAT
           indice := FILESIZE(arq);
           SEEK (arq,indice);
           WRITE ('QUAL O NOME ? ');
           READLN (aux.nome);
           WRITE ('QUAL O TELEFONE ? ');
           READLN (aux.telefone);
           WRITE ('QUAL O CPF ? ');
           READLN (aux.cpf);
           ORDENA (primeiro,ultimo,indice,aux);
           WRITE ('DIGITE "S" PARA CONTINUAR E "N" PARA SAIR - ');
           READLN (tecla);
     UNTIL tecla ='N';
END;

(**************************************************************************)

PROCEDURE exclusao (VAR primeiro,ultimo : INTEGER);
VAR
    tecla           : CHAR;
    nome            : STRING;
    feito           : BOOLEAN;
    reg,aux         : REGISTRO;
    seguinte        : INTEGER;
BEGIN
     REPEAT
           CLRSCR;
           WRITE ('QUAL O NOME A SER EXCLUIDO = ');
           READLN (nome);
           seguinte := primeiro;
           feito := FALSE;
           WHILE (NOT feito) AND (seguinte <> -1) DO
                 BEGIN
                      SEEK (arq,seguinte);
                      READ (arq,reg);
                      IF (reg.nome = nome) THEN
                         feito := TRUE
                      ELSE
                          seguinte := reg.proximo;
                 END;
           IF (seguinte <> - 1) THEN
              BEGIN
                   IF (seguinte = primeiro) THEN
                      BEGIN
                           SEEK(arq,primeiro);
                           primeiro := reg.proximo;
                           reg.proximo := -1;
                           WRITE(arq,reg);
                           SEEK (arq,primeiro);
                           READ (arq,aux);
                           aux.anterior := reg.anterior;
                           SEEK (arq,primeiro);
                           WRITE (arq,aux);

                      END
                   ELSE
                       IF (seguinte = ultimo) THEN
                          BEGIN
                               SEEK(arq,ultimo);
                               ultimo := reg.anterior;
                               reg.anterior := -1;
                               WRITE(arq,reg);
                               SEEK (arq,ultimo);
                               READ (arq,aux);
                               aux.proximo := reg.proximo;
                               SEEK (arq,ultimo);
                               WRITE (arq,aux);
                          END
                       ELSE
                           BEGIN
                                SEEK (arq,reg.proximo);
                                READ (arq,aux);
                                aux.anterior := reg.anterior;
                                SEEK (arq,reg.proximo);
                                WRITE (arq,aux);
                                SEEK (arq,reg.anterior);
                                READ (arq,aux);
                                aux.proximo := reg.proximo;
                                SEEK (arq,reg.anterior);
                                WRITE (arq,aux);
                           END;
              END
           ELSE
              WRITELN ('ESTE NOME NAO EXISTE');
           WRITELN ('DIGITE "S" PARA CONTINUAR E "N" PARA SAIR');
           READLN (tecla);
     UNTIL tecla = 'N';
END;

(**************************************************************************)

PROCEDURE listagem (primeiro,ultimo : INTEGER);
VAR
   opcao,tecla     : CHAR;
   seguinte        : INTEGER;
   reg             : REGISTRO;

BEGIN
     REPEAT
        CLRSCR;
        WRITELN ('"C" ORDENA CRESCENTEMENTE');
        WRITELN ('"D" ORDENA DESCRECENTEMENTE');
        WRITELN ('"N" PARA SAIR');
        READLN (opcao);
        IF (opcao = 'C') THEN
           BEGIN
                seguinte := primeiro;
                WHILE (seguinte <> -1) DO
                      BEGIN
                           SEEK (arq,seguinte);
                           READ (arq,reg);
                           WRITE ('NOME - ',reg.nome);
                           WRITE (' / TELEFONE - ',reg.telefone);
                           WRITELN (' / CPF - ',reg.cpf);
                           seguinte := reg.proximo;
                      END;
               WRITELN;
               WRITELN ('APERTE <ENTER> PARA CONTINUAR');
               tecla := READKEY;
           END
        ELSE
            IF (opcao = 'D') THEN
               BEGIN
                    seguinte := ultimo;
                    WHILE (seguinte <> -1) DO
                          BEGIN
                               SEEK (arq,seguinte);
                               READ (arq,reg);
                               WRITE ('NOME - ',reg.nome);
                               WRITE (' / TELEFONE - ',reg.telefone);
                               WRITELN (' / CPF - ',reg.cpf);
                               seguinte := reg.anterior;
                          END;
                    WRITELN;
                    WRITELN('APERTE <ENTER> PARA CONTINUAR');
                    tecla := READKEY;
               END;
     UNTIL opcao = 'N';
END;

(**************************************************************************)

PROCEDURE menu;
VAR
   opcao   : CHAR;
BEGIN
     REPEAT
           CLRSCR;
           WRITELN ('DIGITE "1" PARA INCLUSAO');
           WRITELN ('DIGITE "2" PARA EXCLUSAO');
           WRITELN ('DIGITE "3" PARA LISTAGEM');
           WRITELN ('DIGITE "4" PARA FIM');
           WRITELN;
           WRITE ('ESCOLHA UMA OPCAO ');
           READLN (opcao);
           CASE opcao OF

                  '1'    : BEGIN
                                CLRSCR;
                                inclusao (primeiro,ultimo);
                           END;
                  '2'    : BEGIN
                                CLRSCR;
                                exclusao (primeiro,ultimo);
                           END;
                  '3'    : BEGIN
                                CLRSCR;
                                listagem(primeiro,ultimo);
                           END;
           END;
     UNTIL opcao = '4';
END;

(**************************************************************************)

PROCEDURE localiza (VAR primeiro,ultimo : INTEGER);
VAR
   menor,maior : string[20];
   aux         : registro;
   tecla       : CHAR;
   indice      : INTEGER;
BEGIN
     SEEK (arq,0);
     IF EOF (arq) THEN
        BEGIN
             WRITELN (' O SEU ARQUIVO ESTA VAZIO');
             WRITELN ('APERTE <ENTER> PARA CONTINUAR');
             tecla := READKEY;
        END
     ELSE
         BEGIN
              menor := 'ZZZ';
              maior := 'AAA';
              WHILE NOT EOF (arq) DO
                    BEGIN
                         indice := FILEPOS(arq);
                         READ (arq,aux);
                         IF (aux.nome > maior) AND (aux.proximo = -1)
                            AND (aux.anterior <> -1) THEN
                            BEGIN
                                 maior := aux.nome;
                                 ultimo := indice;
                            END;
                         IF (aux.nome < menor) AND (aux.anterior = -1)
                            AND (aux.proximo <> -1 ) THEN
                            BEGIN
                                 menor := aux.nome;
                                 primeiro := indice;
                            END;
                    END;
         END;
END;

(************************* PROGRAMA PRINCIPAL ******************************)

BEGIN
     CLRSCR;
     ASSIGN (arq,'DADOS.DAT');
     {$I-}
     RESET(arq);
     IF IORESULT <> 0 THEN
        REWRITE (arq);
     {$I+}
     primeiro := -1;
     ultimo := -1;
     localiza (Primeiro,Ultimo);
     menu;
     CLOSE (arq);
END.
