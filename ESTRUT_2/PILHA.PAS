PROGRAM TESTE_PILHA;
USES CRT;
TYPE
   AP_PILHA = ^PILHA;
   PILHA = RECORD
                 INFO : STRING;
                 SEG   : AP_PILHA;
           END;

VAR
   P,T,X  : AP_PILHA;
   i,j    : STRING;
   TECLA  : CHAR;
   CONT   : INTEGER;
   VAZIO  : BOOLEAN;

(************** PROCEDURE PARA INICIAR UMA PILHA *********************)

PROCEDURE INICIAR (VAR P: AP_PILHA);
BEGIN
     P:=NIL;
END;

(********* PROCEDURE PARA COLOCAR ELEMENTO NO TOPO DA PILHA ************)

PROCEDURE EMPILHAMENTO (VAR P: AP_PILHA; VAR i: STRING);
BEGIN
     NEW(T);
     T^.INFO  := i;
     T^.SEG   := P;
     P        := T;
     T        := NIL;
END;

(******** PROCEDURE PARA RETIRAR ELEMENTO DO TOPO DA PILHA **********)

PROCEDURE DESEMPILHAMENTO (VAR P: AP_PILHA; VAR j: STRING);
BEGIN
     IF (P = NIL) THEN
       BEGIN
           VAZIO := TRUE;
           WRITELN ('PILHA VAZIA');
       END
     ELSE
        IF P^.SEG = NIL THEN
           BEGIN
               J := P^.INFO;
               P := NIL;
           END
        ELSE
            BEGIN
                 T      := P;
                 J      := P^.INFO;
                 P      := P^.SEG;
                 T^.SEG := NIL;
                 DISPOSE (T);
        END;
END;

(************** PROCEDURE PARA CONSULTAR O TOPO DA PILHA *************)

PROCEDURE CONSULTA (VAR P: AP_PILHA; VAR J: STRING);
BEGIN
     IF P = NIL THEN
       BEGIN
           VAZIO:=TRUE;
           WRITELN('PILHA VAZIA');
       END
     ELSE
        j := P^.INFO;
END;

(************ PROGRAMA PRINCIPAL ****************)

BEGIN
     CLRSCR;
     INICIAR ( P );
     repeat
        VAZIO := FALSE;
        WRITELN ('1   - Empilha Topo');
        WRITELN ('2   - Desempilha Topo');
        WRITELN ('3   - Consulta Topo');
        WRITELN ('ESC - Sai para S.O.');
        WRITELN;
        WRITELN ('Qual a opcao');
        TECLA := READKEY;

        case (TECLA) of
          '1'  :  begin
                       WRITE ('DIGITE O VALOR :');
                       READLN (I);
                       EMPILHAMENTO ( P ,I );
                       VAZIO := FALSE;
                  END;
          '2'  :  BEGIN
                       DESEMPILHAMENTO ( P ,J );
                       IF (VAZIO <> TRUE) THEN
                             WRITELN('VALOR REMOVIDO DO TOPO = ',J);

                  END;
          '3'  :  BEGIN
                       CONSULTA ( P , J );
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR DO TOPO = ',j);
                  END;
        end;
        IF (P <> NIL) THEN
          BEGIN
               CONT := 1;
               X := P;
               WHILE (X <> NIL) DO
                     BEGIN
                          WRITE(' ELE [',CONT,']= ',X^.INFO);
                          X := X^.SEG;
                          CONT := CONT + 1;
                     END;
          END;
        TECLA := READKEY;
        WRITELN;
        WRITELN;
     UNTIL TECLA = #27;
END.