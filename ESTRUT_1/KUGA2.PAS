PROGRAM lista_simplesmente_encadeada;
USES crt;
TYPE
    APONTA_NODO =^NODO;
    NODO    = record
                DADO    : string;
                PROXIMO : APONTA_NODO;
              end;

    APONTADOR_DESCRITOR = ^DESCRITORES;
    DESCRITORES= record
                    INICIO,FIM       : APONTA_NODO;
                    NUMERO_ELEMENTOS : integer;
                    APONTA           : APONTADOR_DESCRITOR;
                 end;

VAR
  VAZIO             : BOOLEAN;
  LISTA             : APONTA_NODO;
  VALOR             : STRING;
  DESCRITOR         : APONTADOR_DESCRITOR;
  TECLA             : CHAR;
  CONTADOR,POSICAO  : INTEGER;

procedure criar (var DESCRITOR : APONTADOR_DESCRITOR);
begin
    NEW(DESCRITOR);
    DESCRITOR^.INICIO := nil;
    DESCRITOR^.NUMERO_ELEMENTOS :=0;
    DESCRITOR^.FIM := nil;
end;

procedure insere_esq (VAR DESCRITOR:APONTADOR_DESCRITOR; VAR valor:string);
begin
    NEW(LISTA);
    LISTA^.DADO := VALOR;
    if DESCRITOR^.NUMERO_ELEMENTOS = 0 then
       begin
          DESCRITOR^.INICIO := LISTA;            {lista vazia}
          DESCRITOR^.FIM    := LISTA;
          DESCRITOR^.NUMERO_ELEMENTOS := 1;
          LISTA^.PROXIMO := NIL;
       end
    else
        begin
             LISTA^.PROXIMO := DESCRITOR^.INICIO;   {lista cheia}
             DESCRITOR^.INICIO := LISTA;
             DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS+1;
        end;
end;

procedure insere_dir (VAR DESCRITOR:APONTADOR_DESCRITOR; VAR valor:string);
var
   AUXILIAR: APONTA_NODO;
begin
     NEW (LISTA);
     LISTA^.DADO := VALOR;
     LISTA^.PROximo := NIL;
     if DESCRITOR^.NUMERO_ELEMENTOS = 0 then
        begin
             DESCRITOR^.INICIO := LISTA;          {lista vazia}
             DESCRITOR^.FIM := LISTA;
             DESCRITOR^.NUMERO_ELEMENTOS := 1;
        end
      else
          begin
               AUXILIAR := DESCRITOR^.FIM;        {lista cheia}
               DESCRITOR^.FIM := LISTA;
               AUXILIAR^.PROximo := LISTA;
               DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS + 1;
          end;
end;

procedure insere_meio (VAR DESCRITOR:APONTADOR_DESCRITOR;
                            VAR valor:string; POSICAO :INTEGER);
var
   AUXILIAR, ATUAL        : APONTA_NODO;
   CONTADOR1              : integer;
begin
     NEW(LISTA);
     LISTA^.dado := VALOR;
     if DESCRITOR^.NUMERO_ELEMENTOS=0 then
        begin
             DESCRITOR^.INICIO:=LISTA;          {lista vazia}
             DESCRITOR^.FIM:=LISTA;
             DESCRITOR^.NUMERO_ELEMENTOS:=1;
             LISTA^.PROXIMO := NIL;
         end
      else
         if DESCRITOR^.NUMERO_ELEMENTOS=1 then
            begin
            AUXILIAR := DESCRITOR^.FIM;        {lista com um elemento}
            DESCRITOR^.FIM   := LISTA;
            AUXILIAR^.PROximo:= LISTA;
            DESCRITOR^.NUMERO_ELEMENTOS   := DESCRITOR^.NUMERO_ELEMENTOS+1;
            end
         else
            begin
              ATUAL := DESCRITOR^.INICIO;
              CONTADOR1 := 1;
              while CONTADOR1 <> POSICAO-1 do
                    begin
                         atual := atual^.PROXIMO;
                         CONTADOR1 := CONTADOR1 + 1;
                    end;
             AUXILIAR := atual^.PROximo;
             LISTA^.PROximo := AUXILIAR;
             atual^.PROximo := LISTA; { insere no meio}
             DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS+1;
          end;
end;

procedure remove_meio (VAR DESCRITOR:APONTADOR_DESCRITOR;
                            VAR valor:string; POSICAO :INTEGER);
var
   AUXILIAR, ATUAL        : APONTA_NODO;
   CONTADOR1              : integer;
begin
     ATUAL := DESCRITOR^.INICIO;
     CONTADOR1 := 1;
     while CONTADOR1 <> POSICAO-1 do
           begin
                atual := atual^.PROXIMO;
                CONTADOR1 := CONTADOR1 + 1;
           end;
     AUXILIAR := atual^.PROximo;
     valor := auxiliar^.dado;
     atual^.PROximo := auxiliar^.proximo;
     DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS-1;
     dispose(auxiliar);
end;

procedure remove_esq (VAR DESCRITOR:APONTADOR_DESCRITOR;VAR  valor:string);
begin
    if DESCRITOR^.NUMERO_ELEMENTOS=0 then            {testa se esta vazia}
      begin
           VAZIO := TRUE;
           WRITELN;
           WRITELN ('lista esta vazia');
           TECLA := READKEY;
      end
    else
       begin                   {lista nao vazia, remove}
           LISTA := DESCRITOR^.INICIO;
           VALOR := LISTA^.dado;
           DESCRITOR^.INICIO := LISTA^.PROximo;
           DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS-1;
           DISPOSE (LISTA);
           if DESCRITOR^.NUMERO_ELEMENTOS = 0 then {testa se a lista ficou vazia}
              begin
                   DESCRITOR^.FIM := nil;
              end;
       end;
end;

procedure remove_dir (VAR DESCRITOR:APONTADOR_DESCRITOR; VAR valor:string);
var
  AUXILIAR    : APONTA_NODO;
begin
     if DESCRITOR^.NUMERO_ELEMENTOS = 0 then
        begin
             VAZIO := TRUE;
             WRITELN;
             WRITELN ('lista esta vazia');
             TECLA := READKEY;
        end
      else
       BEGIN
         LISTA := DESCRITOR^.INICIO;
         if DESCRITOR^.NUMERO_ELEMENTOS = 1 then
            begin
                 VALOR := LISTA^.DADO;
                 DESCRITOR^.INICIO := nil;
                 DESCRITOR^.FIM := nil;
                 DESCRITOR^.NUMERO_ELEMENTOS := 0;
            end
         else
            begin
              while LISTA^.PROximo <> nil do
                   begin
                       AUXILIAR := LISTA;
                       LISTA := LISTA^.PROximo;
                   end;
              VALOR := LISTA^.DADO;
              DESCRITOR^.FIM := AUXILIAR;
              AUXILIAR^.PROximo := nil;
              DESCRITOR^.NUMERO_ELEMENTOS := DESCRITOR^.NUMERO_ELEMENTOS - 1;
            end;
        DISPOSE(LISTA);
       END;
end;

(************ PROGRAMA PRINCIPAL ****************)

begin
     CLRSCR;
     CRIAR ( DESCRITOR );
     repeat
        VAZIO := FALSE;
        write  ('1 - Insere direita  / ');
        write  ('2 - Insere esquerda / ');
        write  ('3 - Remove esquerda / ');
        writeln('ESC=>Sai ');
        write  ('4 - Remove direita  / ');
        write  ('5 - Insere no meio  / ');
        write  ('6 - Remove do Meio  / ');
        writeln('7 - Limpa Tela');
        writeln('Qual a opcao(1-2-3-4-5)');
        tecla := readkey;
        case (tecla) of
          '1'  :  begin
                       write ('digite o valor : ');
                       readln (valor);
                       insere_dir ( DESCRITOR, valor);
                  end;
          '2'  :  BEGIN
                       write ('digite o valor : ');
                       readln (valor);
                       insere_esq ( DESCRITOR, valor);
                  END;
          '3'  :  BEGIN
                       remove_esq ( DESCRITOR, valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA ESQUERDA ',VALOR);
                  END;
          '4'  :  BEGIN
                       remove_dir ( DESCRITOR, valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA DIREITA ',VALOR);
                  END;
          '5'  :  BEGIN
                       write ('digite o valor a ser inserido no meio : ');
                       readln (valor);
                       WRITE ('digite a posicao para fazer a inclusao : ');
                       readln (posicao);
                       IF (POSICAO>1) AND (POSICAO<=DESCRITOR^.NUMERO_ELEMENTOS) THEN
                           insere_meio ( DESCRITOR , VALOR, POSICAO)
                       ELSE
                           WRITELN('POSICAO INVALIDA!!!!!');
                  end;
          '6'  :  BEGIN
                       WRITE ('digite a posicao do elemento a ser excluido : ');
                       readln (posicao);
                       IF (POSICAO>1) AND (POSICAO<DESCRITOR^.NUMERO_ELEMENTOS) THEN
                           BEGIN
                                remove_meio ( DESCRITOR , VALOR, POSICAO);
                                WRITELN('VALOR REMOVIDO DA POSICAO ',POSICAO,' =  ',VALOR);
                           END
                       ELSE
                           WRITELN('POSICAO DE REMOCAO INVALIDA!!!!!');
                  end;
          '7' : BEGIN
                     CLRSCR;
                END;
        end;
        WRITELN('Valor do Descritor ‚ ', DESCRITOR^.NUMERO_ELEMENTOS);
        IF (VAZIO <> TRUE) AND (DESCRITOR^.NUMERO_ELEMENTOS <> 0) THEN
          BEGIN
               LISTA := DESCRITOR^.INICIO;
               CONTADOR := 1;
               WRITELN;
               WHILE (LISTA^.PROximo <> NIL) DO
                     BEGIN
                          WRITE(' ELE [',CONTADOR,']= ',LISTA^.DADO);
                          LISTA := LISTA^.PROximo;
                          CONTADOR := CONTADOR + 1;
                     END;
        WRITE(' ELE [',CONTADOR,']= ',LISTA^.DADO);
        END;
        TECLA := READKEY;
        WRITELN;
     until tecla = #27;
END.