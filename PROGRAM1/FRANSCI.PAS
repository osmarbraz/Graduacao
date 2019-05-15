PROGRAM TRABALHO_DE_PROGRAMACAO;
USES CRT;
VAR
   NOME,NOMED,NOMESENHA,ACAO                            : STRING;
   CONTA,CONTAD,NUMEROSENHA,CHAVE                       : INTEGER;
   SALDO_ANTERIOR,SALDO_ATUAL,VALOR,DEPOSITO,RETIRADA   : REAL;
   TECLA                                                : CHAR;

BEGIN
     CLRSCR;
     WRITELN ('                SISTEMA MECANIZADO DE CONTAS ');
     WRITELN ('        TRANSACOES POSSIVEIS "DEPOSITO" E "RETIRADA" ');
     WRITELN;
     WINDOW (1,4,80,25);
     WRITELN ('****************     PROCESSAMENTO DIARIO     ****************');
     WRITELN ('***  PARA ENCERRAR PROCESSAMENTO DIGITE NOME "*" E <ENTER> ***');
     WRITELN;
     WRITE ('NOME DO CLIENTE       : ');
     READLN (NOME);
     WHILE NOME <> '*' DO
           BEGIN
                WRITE ('NUMERO DA CONTA       : ');
                READLN (CONTA);
                WRITE ('SALDO ANTERIOR        : ');
                READLN (SALDO_ANTERIOR);
                NUMEROSENHA := CONTA;
                NOMESENHA := NOME;
                RETIRADA := 0;
                DEPOSITO := 0;
                WRITELN;
                WRITELN ('******* TRANSACOES DIARIAS DO CLIENTE <',NOME,'> CONTA <',CONTA,'> ******');
                WINDOW (1,13,80,25);
                WRITE ('NOME DO CLIENTE       : ');
                READLN (NOMED);
                WHILE NOMED <> '&' DO
                      BEGIN
                           WRITE ('NUMERO DA CONTA       : ');
                           READLN (CONTAD);
                           WRITE ('ACAO                  : ');
                           READLN (ACAO);
                           WRITE ('VALOR                 : ');
                           READLN (VALOR);
                           CHAVE := 0;
                           IF ACAO ='DEPOSITO' THEN
                             IF NUMEROSENHA = CONTAD THEN
                               IF NOMESENHA = NOMED THEN
                                  DEPOSITO := DEPOSITO + VALOR
                               ELSE
                                  BEGIN
                                  WRITELN;
                                  WRITELN ('>> NOME NAO CORRESPONDE COM O DA CONTA <<');
                                  WRITELN ('>>  CORRIJA O ERRO E REPITA A OPERACAO <<');
                                  WRITELN ('>>      OU SAIA DIGITANDO NOME "&"     <<');
                                  CHAVE := 1;
                                  END
                             ELSE
                                 BEGIN
                                 WRITELN;
                                 WRITELN ('>> NUMERO NAO CORRESPONDE COM O DA CONTA <<');
                                 WRITELN ('>>   CORRIJA O ERRO E REPITA A OPERACAO  <<');
                                 WRITELN ('>>       OU SAIA DIGITANDO NOME "&"      <<');
                                 CHAVE := 1;
                                 END;

                           IF ACAO = 'RETIRADA' THEN
                              IF NUMEROSENHA = CONTAD THEN
                                 IF NOMESENHA = NOMED THEN
                                    RETIRADA := RETIRADA + VALOR
                                 ELSE
                                     BEGIN
                                          WRITELN;
                                          WRITELN ('>> NOME NAO CORRESPONDE COM O DA CONTA <<');
                                          WRITELN ('>>  CORRIJA O ERRO E REPITA A OPERACAO <<');
                                          WRITELN ('>>       OU SAIA DIGITANDO NOME "&"    <<');
                                          CHAVE := 1;
                                     END
                              ELSE
                                  BEGIN
                                       WRITELN;
                                       WRITELN ('>> NUMERO NAO CORRESPONDE COM O DA CONTA <<');
                                       WRITELN ('>>  CORRIJA O ERRO E REPITA A OPERACAO   <<');
                                       WRITELN ('>>       OU SAIA DIGITANDO NOME "&"      <<');
                                       CHAVE := 1;
                                  END;
                         IF (ACAO <> 'DEPOSITO') AND (ACAO <> 'RETIRADA') THEN
                            BEGIN
                                 WRITELN;
                                 WRITELN ('---     NAO EXISTE ESTA OPERACAO !!!     ---');
                                 WRITELN ('---  CORRIJA O ERRO E REPITA A OPERACAO  ---');
                                 WRITELN ('---      OU SAIA  DIGITANDO NOME "&"     ---');
                                 CHAVE := 1;
                                 END;
                         IF CHAVE = 0 THEN
                            BEGIN
                            WRITELN;
                            WRITELN ('-- PARA ENCERRAR OS REGISTROS DIARIOS ENTRE COM NOME "&" E <ENTER> --');
                            END;
                         WRITELN;
                         WRITE ('NOME DO CLIENTE       : ');
                         READLN (NOMED);
                         CHAVE := 0;
                      END;

                SALDO_ATUAL := SALDO_ANTERIOR + DEPOSITO - RETIRADA;
                CLRSCR;
                WINDOW (1,10,80,25);
                WRITELN;
                WRITELN ('*****************  INFORMACOES PROCESSADAS  *****************');
                WRITELN;
                WRITELN ('NOME DO CLIENTE            : ',NOME);
                WRITELN ('NUMERO DA CONTA            : ',CONTA);
                WRITELN ('SALDO ANTERIOR             : CR$ ',SALDO_ANTERIOR:0:2);
                WRITELN ('TOTAL DE DEPOSITOS         : CR$ ',DEPOSITO:0:2);
                WRITELN ('TOTAL DE RETIRADAS         : CR$ ',RETIRADA:0:2);
                WRITELN ('SALDO ATUAL                : CR$ ',SALDO_ATUAL:0:2);
                WRITELN;
                WRITELN ('APERTE QUALQUER TECLA PARA CONTINUAR O PROCESSAMENTO DIARIO');
                TECLA := READKEY;
                CLRSCR;
                WINDOW (1,4,80,25);
                CLRSCR;
                WRITELN ('****************     PROCESSAMENTO DIARIO     ****************');
                WRITELN ('***  PARA ENCERRAR PROCESSAMENTO DIGITE NOME "*" E <ENTER> ***');
                WRITELN;
                WRITE ('NOME DO CLIENTE       : ');
                READLN (NOME);
           END;

END.







