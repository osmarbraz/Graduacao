PROGRAM TRABALHO_DE_PROGRAMACAO;
USES CRT;
VAR
    NOME,NOMEC,NOMESENHA,ACAO,CARTAO                                   : STRING;
    NUMEROSENHA,CONTAC,CHAVE,CHAVE1,CONTA                              : INTEGER;
    VALOR,SALDO_ANTERIOR,TOTAL_RETIRADA,TOTAL_DEPOSITO,SALDO           : REAL;
BEGIN
     CLRSCR;
     TOTAL_DEPOSITO := 0;
     TOTAL_RETIRADA := 0;
     SALDO := 0;
     VALOR := 0;
     WRITELN ('     SISTEMA MECANIZADO DE CONTA DE CLIENTES');
     WRITELN ('TRANSACOES POSSIVEIS : CONTA NOVA, DEPOSITO, RETIRADA');
     WRITELN;
     WRITE ('*** PROCESSAMENTO DIARIO ***');
     WRITELN;
     WRITE ('NOME DO CLIENTE    : ');
     READLN (NOME);
     WHILE NOME <> '*' DO
            BEGIN
                 WRITE ('NUMERO DA CONTA    : ');
                 READLN (CONTA);
                 WRITE ('ACAO               : ');
                 READLN (ACAO);
                 WRITE ('QUAL O VALOR       : ');
                 READLN (VALOR);
                 NOMESENHA := NOME;
                 NUMEROSENHA := CONTA;
                 CARTAO := 'S';
                 CHAVE1 := 1;
                 TOTAL_RETIRADA := 0;
                 TOTAL_DEPOSITO := 0;
                 IF ACAO =  'CONTA NOVA' THEN
                    BEGIN
                         WRITELN;
                         WRITELN (' *** CONTA NOVA ***');
                         WRITELN ('NOME DO CLIENTE    : ',NOME);
                         WRITELN ('NUMERO DA CONTA    : ',CONTA);
                         WRITELN ('SALDO DO CLIENTE   : ',VALOR:0:2);
                    END
                 ELSE
                    IF (ACAO='DEPOSITO') OR (ACAO='RETIRADA') THEN
                      BEGIN
                         WHILE CARTAO <> 'N' DO
                             BEGIN
                                 IF ACAO = 'DEPOSITO' THEN
                                    IF NUMEROSENHA = CONTA  THEN
                                       IF NOMESENHA = NOME THEN
                                           TOTAL_DEPOSITO := TOTAL_DEPOSITO + VALOR
                                       ELSE
                                           BEGIN
                                              WRITELN;
                                              WRITELN ('>> NOME DO CLIENTE NAO CORRESPONDE COM O DO REGISTRO ANTERIOR << ');
                                              WRITELN ('>>           CORRIJA O ERRO E REPITA A OPERACAO               <<');
                                              CHAVE1 := 0;
                                           END
                                    ELSE
                                       BEGIN
                                          WRITELN;
                                          WRITELN ('>> NUMERO DA CONTA NAO CORRESPONDE COM O DO REGISTRO ANTERIOR  <<');
                                          WRITELN ('>>             CORRIJA O ERRO E REPITA A OPERACAO              <<');
                                          CHAVE1 := 0;
                                       END;
                                 IF ACAO = 'RETIRADA' THEN
                                   IF NUMEROSENHA = CONTA THEN
                                      IF NOMESENHA = NOME THEN
                                          TOTAL_RETIRADA := TOTAL_RETIRADA + VALOR
                                      ELSE
                                          BEGIN
                                               WRITELN;
                                               WRITELN ('>> NOME DO CLIENTE NAO CORRESPONDE COM O DO REGISTRO ANTERIOR<<');
                                               WRITELN ('>>             CORRIJA O ERRO E REPITA A OPERACAO            <<');
                                               CHAVE1 := 0;
                                          END
                                   ELSE
                                       BEGIN
                                           WRITELN;
                                           WRITELN ('>> NUMERO DA CONTA NAO CORRESPONDE COM O DO REGISTRO ANTERIOR <<');
                                           WRITELN ('>>            CORRIJA O ERRO E REPITA A OPERACAO              <<');
                                           CHAVE1 := 0;
                                       END;
                                 IF (ACAO <> 'DEPOSITO') AND (ACAO <> 'RETIRADA') THEN
                                    BEGIN
                                         WRITELN;
                                         WRITELN (' --> NAO EXISTE ESTA OPERACAO, CORRIJA O ERRO E REPITA OPERACAO <--');
                                         CHAVE1 := 0;
                                    END;
                                 IF CHAVE1 = 1 THEN
                                 BEGIN
                                    WRITELN;
                                    WRITE ('--- EXITE MAIS ALGUM CARTAO DESTE CLIENTE (S/N) ? ');
                                    READLN (CARTAO);
                                 END;
                                 CHAVE1 := 1;
                                 IF CARTAO = 'S' THEN
                                    BEGIN
                                      WRITELN;
                                      WRITELN ('*** PROCESSAMENTO DIARIO ***');
                                      WRITE ('NOME DO CLIENTE    : ');
                                      READLN (NOME);
                                      WRITE ('NUMERO DA CONTA    : ');
                                      READLN (CONTA);
                                      WRITE ('ACAO               : ');
                                      READLN (ACAO);
                                      WRITE ('QUAL O VALOR       : ');
                                      READLN (VALOR);
                                    END;

                             END;
                        CHAVE := 1;
                        WHILE CHAVE <> 0 DO
                          BEGIN
                             WRITELN;
                             WRITELN ('*** INFORMACOES CLIENTE DIA ANTERIOR ***');
                             WRITE ('NOME DO CLIENTE    : ');
                             READLN (NOMEC);
                             WRITE ('NUMERO DA CONTA    : ');
                             READLN (CONTAC);
                             WRITE ('SALDO ANTERIOR     : ');
                             READLN (SALDO_ANTERIOR);
                             IF NUMEROSENHA = CONTAC THEN
                                IF NOMESENHA = NOMEC THEN
                                  BEGIN
                                      CHAVE := 0;
                                      SALDO := SALDO_ANTERIOR + TOTAL_DEPOSITO - TOTAL_RETIRADA;
                                      WRITELN;
                                      WRITELN ('*** INFORMACOES PROCESSADAS DO DIA ***');
                                      WRITELN ('CLIENTE          : ',NOMEC);
                                      WRITELN ('CONTA NUM        : ',CONTAC);
                                      WRITELN ('SALDO ATUAL      : ',SALDO:0:2);
                                  END
                                ELSE
                                   BEGIN
                                        WRITELN;
                                        WRITELN ('>> NOME DO CLIENTE NAO CORRESPONDE COM O DA CONTA <<');
                                        WRITELN ('>>       CORRIJA O ERRO E REPITA A OPERACAO       <<');
                                   END
                             ELSE
                                 BEGIN
                                      WRITELN;
                                      WRITELN ('>> NUMERO DA CONTA DO CLIENTE NAO CORRESPONDE COM O DA CONTA <<');
                                      WRITELN ('>>           CORRIJA O ERRO E REPITA A OPERACAO              <<');
                                 END;
                          END;
                      END
                    ELSE
                       BEGIN
                       WRITELN;
                       WRITELN ('>> NAO EXITE ESTA OPERACAO <<');
                       END;
              WRITELN;
              WRITELN ('*** PROCESSAMENTO DIARIO NOVO CLIENTE ***');
              WRITELN ('PARA SAIR DIGITE NOME <*>') ;
              WRITE ('NOME DO CLIENTE    : ');
              READLN (NOME);
            END;
END.