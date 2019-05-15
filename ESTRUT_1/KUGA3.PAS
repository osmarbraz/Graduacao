PROGRAM FILA_E_PILHA;
USES CRT, UNITKUGA;

VAR
   FILA                 : PONTAS;
   INICIOF              : APONTA_FILA;
   PILHA,INICIOP        : APONTA_PILHA;
   TECLA                : CHAR;
   VAZIOPILHA,VAZIOFILA : BOOLEAN;
   VALOR                : STRING;
   CONTADOR             : INTEGER;

BEGIN
     CLRSCR;
     INICIAR_FILA(FILA);
     INICIAR_PILHA(PILHA);
     VAZIOPILHA := TRUE;
     VAZIOFILA := TRUE;
     REPEAT
        WRITE  ('1 - EMPILHA         / ');
        WRITE  ('2 - CONSULTA PILHA  / ');
        WRITE  ('3 - DESEMPILHA      / ');
        WRITELN('ESC=>Sai ');
        WRITE  ('4 - ENFILEIRA       / ');
        WRITE  ('5 - CONSULTA FILA   / ');
        WRITE  ('6 - DESEMFILA       / ');
        WRITELN('7 - Limpa Tela');
        WRITELN('Qual a opcao(1-2-3-4-5)');
        TECLA := READKEY;
        CASE (TECLA) OF
          '1'  :  BEGIN
                       WRITE ('DIGITE O VALOR PILHADO: ');
                       READLN (VALOR);
                       EMPILHAMENTO ( PILHA , VALOR);
                       VAZIOPILHA := FALSE;
                  END;
          '2'  :  BEGIN
                       CONSULTA_PILHA ( PILHA , valor);
                       IF VAZIOPILHA = FALSE THEN
                          WRITELN('CONTEUDO DO TOPO PILHA ',VALOR);
                  END;
          '3'  :  BEGIN
                       DESEMPILHAMENTO (PILHA, VALOR, VAZIOPILHA);
                       IF VAZIOPILHA = FALSE THEN
                          WRITELN('VALOR REMOVIDO DA PILHA ',VALOR);
                  END;
          '4'  :  BEGIN
                       WRITE ('DIGITE O VALOR A SER ENFILEIRADO: ');
                       READLN (VALOR);
                       ENFILEIRA ( FILA,VALOR );
                       VAZIOFILA := FALSE
                  END;
          '5'  :  BEGIN
                       CONSULTA_FILA ( FILA, VALOR);
                       IF VAZIOFILA = FALSE THEN
                          WRITELN('CONTEUDO DO COMECO FILA ',VALOR);
                  END;
          '6'  :  BEGIN
                       DESINFILEIRA (FILA, VALOR, VAZIOFILA);
                       IF VAZIOFILA = FALSE THEN
                          WRITELN('VALOR REMOVIDO DA PILHA ',VALOR);
                  END;
          '7' : BEGIN
                     CLRSCR;
                END;
        end;
        IF (VAZIOPILHA = FALSE)AND(PILHA<>NIL) THEN
          BEGIN
               INICIOP := PILHA;
               CONTADOR := 1;
               WRITELN;
               WRITE('SAIDA E ENTRADA <=>');
               WHILE (INICIOP^.SEGUINTE <> NIL) DO
                     BEGIN
                          WRITE(' P [',CONTADOR,']= ',INICIOP^.DADO);
                          INICIOP := INICIOP^.SEGUINTE;
                          CONTADOR := CONTADOR + 1;
                     END;
          WRITE(' P [',CONTADOR,']= ',INICIOP^.DADO);
        END;
        WRITELN;
        IF (VAZIOFILA = FALSE) AND (FILA.COMECO<>NIL) THEN
          BEGIN
               INICIOF := FILA.COMECO;
               CONTADOR := 1;
               WRITE('SAIDA <=');
               WHILE (INICIOF^.SEGUINTE <> NIL) DO
                     BEGIN
                          WRITE(' F [',CONTADOR,']= ',INICIOF^.DADO);
                          INICIOF := INICIOF^.SEGUINTE;
                          CONTADOR := CONTADOR + 1;
                     END;
           WRITE(' F [',CONTADOR,']= ',INICIOF^.DADO,'<= ENTRADA');
        END;
        TECLA := READKEY;
        WRITELN;
        WRITELN;
     UNTIL TECLA = #27;
END.
