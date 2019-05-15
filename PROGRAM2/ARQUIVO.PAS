(**************************************************************************)
(* UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL - TUBARAO-SC - 09/06/94 *)
(* TRABALHO DE 2 AVALIACAO DE PROGRAMACAO DE COMPUTADORES II              *)
(* PROFESSOR CLAYTON BONELLI                                              *)
(* ACADEMICOS OSMAR DE OLIVEIRA BRAZ JUNIOR - 8579                        *)
(*         E  LUSICLER DE SOUZA MOLON - 3920                              *)
(**************************************************************************)

PROGRAM trabalho_de_2_avaliacao;
USES CRT,DOS;
TYPE
    registro = RECORD
                        proximo  : INTEGER;
                        anterior : INTEGER;
                        nome     : STRING[20];
                        telefone : STRING[13];
                        cpf      : STRING[20];
                  END;

VAR
   R                       : REGISTERS;
   aux                     : registro;
   arq                     : FILE OF registro;
   primeiro,ultimo         : INTEGER;

(**************************************************************************)

PROCEDURE beep (freq,time :INTEGER );
BEGIN
     SOUND (freq);
     DELAY (time);
     NOSOUND;
END;

(**************************************************************************)

PROCEDURE Cursor_ON;
BEGIN
    R.ah:=1;
    R.ch:=6;
    R.cl:=7;
    Intr(16,R);
END;

(**************************************************************************)

PROCEDURE Cursor_OFF;
BEGIN
    R.ah:=1;
    R.ch:=8;
    R.cl:=0;
    Intr(16,R);
END;

(**************************************************************************)

PROCEDURE windows (c1,l1,c2,l2 : INTEGER);
VAR
   l,c :INTEGER;
BEGIN
     WINDOW (1,1,80,25);
     GOTOXY (c1,l1);
     WRITE ('É');
     GOTOXY (C2,L1);
     WRITE ('»');
     GOTOXY (c1,l2);
     WRITE ('È');
     GOTOXY (c2,l2);
     WRITE ('¼');
     FOR c:=c1+1 TO c2-1 DO
         BEGIN
              GOTOXY (c,l1);
              WRITE ('Í');
              GOTOXY (c,l2);
              WRITE ('Í');
         END;
     FOR L:=l1+1 TO l2-1 DO
         BEGIN
              GOTOXY (c1,l);
              WRITE ('º');
              GOTOXY (c2,l);
              WRITE ('º');
         END;
     WINDOW (c1+1,l1+1,c2-1,l2-1);
END;

(***************************************************************************)

PROCEDURE escreva (x,y : BYTE ; cadeia : STRING);
BEGIN
     GOTOXY (x,y);
     WRITE (cadeia);
END;

(**************************************************************************)

PROCEDURE LEITURA (VAR caracter : CHAR);
BEGIN
     caracter := READKEY;
     caracter := UPCASE(caracter);
END;

(**************************************************************************)

PROCEDURE maiscula (VAR aux : registro);
VAR
   tam,x  : WORD;
BEGIN
    READLN (aux.nome);
    tam := LENGTH (aux.nome);
    FOR x:= 1 TO tam DO
        aux.nome[x] := UPCASE (aux.nome[x]);
END;

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
     beep (2000,100);
     cursor_ON;
     REPEAT
           windows (2,2,79,25);
           CLRSCR;
           windows (11,5,68,17);
           CLRSCR;
           indice := FILESIZE(arq);
           SEEK (arq,indice);
           escreva (17,1,'>>> INCLUSAO DE DADOS <<<');
           escreva (3,4,'NOME = ');
           maiscula (aux);
           escreva (3,5,'TELEFONE = ');
           READLN (aux.telefone);
           escreva (3,6,'CPF = ');
           READLN (aux.cpf);
           ordena (primeiro,ultimo,indice,aux);
           windows (15,16,64,18);
           CLRSCR;
           escreva (4,1,'TECLE "S" PARA CONTINUAR E "N" PARA SAIR ');
           leitura (tecla);
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
     beep (2000,100);
     cursor_ON;
     REPEAT
           windows (2,2,79,25);
           CLRSCR;
           windows (11,5,68,17);
           CLRSCR;
           escreva (17,1,'>>> EXCLUSAO DE DADOS <<< ');
           escreva (5,3,'DIGITE O NOME A SE EXCLUIDO E PRESSIONE <ENTER>');
           escreva (5,5,'NOME = ');
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
                           SEEK (arq,primeiro);
                           primeiro := reg.proximo;
                           reg.proximo := -1;
                           WRITE (arq,reg);
                           SEEK (arq,primeiro);
                           READ (arq,aux);
                           aux.anterior := reg.anterior;
                           SEEK (arq,primeiro);
                           WRITE (arq,aux);
                      END
                   ELSE
                       IF (seguinte = ultimo) THEN
                          BEGIN
                               SEEK (arq,ultimo);
                               ultimo := reg.anterior;
                               reg.anterior := -1;
                               WRITE (arq,reg);
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
               BEGIN
                    escreva (13,8,'--- ESTE NOME NAO EXISTE!!! ---');
               END;
           windows (15,16,64,18);
           CLRSCR;
           escreva (4,1,'TECLE "S" PARA CONTINUAR E "N" PARA SAIR ');
           leitura (tecla);
     UNTIL tecla = 'N';
END;

(**************************************************************************)

PROCEDURE listagem (primeiro,ultimo : INTEGER);
VAR
   opcao,tecla         : CHAR;
   seguinte            : INTEGER;
   reg                 : REGISTRO;
BEGIN
     beep (2000,100);
     cursor_ON;
     REPEAT
        windows (2,2,79,25);
        CLRSCR;
        windows (11,5,67,13);
        CLRSCR;
        escreva (15,1,'>>> LISTAGEM DE DADOS <<<');
        escreva (12,3,'"C" ORDENA CRESCENTEMENTE');
        escreva (12,4,'"D" ORDENA DESCRECENTEMENTE');
        escreva (12,5,'"N" PARA RETONAR AO MENU PRINCIPAL');
        windows (25,12,51,14);
        CLRSCR;
        escreva (6,1,'TECLE A OPCAO ');
        leitura (opcao);
        IF (opcao = 'C') THEN
           BEGIN
                windows (8,11,70,23);
                CLRSCR;
                seguinte := primeiro;
                WHILE (seguinte <> -1) DO
                      BEGIN
                           SEEK (arq,seguinte);
                           READ (arq,reg);
                           WRITE ('  NOME - ',reg.nome);
                           WRITE ('  TELEFONE - ',reg.telefone);
                           WRITELN ('  CPF - ',reg.cpf);
                           seguinte := reg.proximo;
                      END;
               WRITELN;
               WRITELN ('    Aperte Qualquer Tecla para Continuar...');
               tecla := READKEY;
           END
        ELSE
            IF (opcao = 'D') THEN
               BEGIN
                    windows (8,11,70,23);
                    CLRSCR;
                    seguinte := ultimo;
                    WHILE (seguinte <> -1) DO
                          BEGIN
                               SEEK (arq,seguinte);
                               READ (arq,reg);
                               WRITE ('  NOME - ',reg.nome);
                               WRITE (' / TELEFONE - ',reg.telefone);
                               WRITELN (' / CPF - ',reg.cpf);
                               seguinte := reg.anterior;
                          END;
                    WRITELN;
                    WRITELN ('    Aperte Qualquer Tecla para Continuar...');
                    tecla := READKEY;
               END;
     UNTIL opcao = 'N';
END;

(************************************************************************)

PROCEDURE fim;
BEGIN
     windows (2,2,79,25);
     CLRSCR;
     windows (27,8,50,14);
     escreva (8,3,'THE END');
     beep (1000,100);
     DELAY (1000);
     window (1,1,80,25);
     CLRSCR;
END;

(**************************************************************************)

PROCEDURE menu;
VAR
   opcao   : CHAR;
BEGIN
     REPEAT
           cursor_OFF;
           windows (2,2,79,25);
           CLRSCR;
           windows (16,7,63,16);
           escreva (15,3,'"1" PARA INCLUSAO');
           escreva (15,4,'"2" PARA EXCLUSAO');
           escreva (15,5,'"3" PARA LISTAGEM');
           escreva (15,6,'"4" PARA FIM');
           windows (23,6,56,8);
           CLRSCR;
           escreva (5,1,'>>>  MENU PRINCIPAL  <<<');
           windows (13,20,67,23);
           CLRSCR;
           escreva (13,1,'BY OSMAR DE OLIVEIRA BRAZ');
           escreva (13,2,'AND LUSICLER DE SOUZA MOLON');
           windows (23,15,56,17);
           CLRSCR;
           escreva (7,1,'ESCOLHA UMA OPCAO ');
           OPCAO := READKEY;
           CASE opcao OF

                  '1'    : inclusao (primeiro,ultimo);
                  '2'    : exclusao (primeiro,ultimo);
                  '3'    : listagem(primeiro,ultimo);
                  '4'    : fim;

           END;
     UNTIL opcao = '4';
END;

(**************************************************************************)

PROCEDURE localiza (VAR primeiro,ultimo : INTEGER);
VAR
   menor,maior    : STRING[20];
   aux            : registro;
   tecla          : CHAR;
   indice         : INTEGER;
BEGIN
     cursor_OFF;
     SEEK (arq,0);
     IF EOF (arq) THEN
        BEGIN
             windows (2,2,79,25);
             CLRSCR;
             windows (16,9,63,15);
             beep (1000,100);
             escreva (10,2,'  O SEU ARQUIVO ESTA VAZIO');
             escreva (10,4,'APERTE <ENTER> PARA CONTINUAR');
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
     RESET (arq);
     IF IORESULT <> 0 THEN
        REWRITE (arq);
     {$I+}
     primeiro := -1;
     ultimo := -1;
     localiza (Primeiro,Ultimo);
     menu;
     CLOSE (arq);
END.

