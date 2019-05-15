Program Ordena_lista;
uses crt;
type
    ap_no=^no;
    no =  record
             dado: string;
             prox: ap_no;
         end;

    descritor= record
                   i,f :ap_NO;
                   n   :integer;
                end;

var
  Vazio   : Boolean;
  lista,p : ap_no;
  valor   : string;
  d       : Descritor;
  tecla   : char;
  Cont    : Integer;

(******** CRIA O DESCRITOR E INICIALIZA SEUS APONTADORES E VARIAVEIS ******)
procedure criar (var d : descritor);
begin
    d.i :=nil;
    d.n :=0;
    d.f :=nil;
end;

(*********** PROCEDURE PARA INSERIR NA ESQUERDA DA LISTA ******************)
procedure insere_esq (VAR d:descritor; VAR valor:string);
var
  p:ap_no;
begin
    new(p);
    p^.dado:=valor;
    if d.n=0 then
       begin
          d.i:=p;            {lista vazia}
          d.f:=p;
          d.n:=1;
          p^.prox:=nil;
       end
    else
        begin
             p^.prox:=d.i;   {lista cheia}
             d.i:=p;
             d.n:=d.n+1;
        end;
end;

(************* PROCEDURE PARA INSERIR NA DIREITA DA LISTA ******************)
procedure insere_dir (VAR d:descritor; VAR valor:string);
var
   p,q: ap_no;

begin
     new(p);
     p^.dado:=valor;
     p^.prox:=nil;
     if d.n=0 then
        begin
             d.i:=p;          {lista vazia}
             d.f:=p;
             d.n:=1;
        end
      else
          begin
               q:=d.f;        {lista cheia}
               d.f:=p;
               q^.prox:=p;
               d.n:=d.n+1;
          end;
end;

(********** PROCEDURE PARA REMOVER ELEMENTO DA ESQUERDA DA LISTA ***********)
procedure remove_esq (VAR d:descritor;VAR  valor:string);
var
  p:ap_no;

begin
    if d.n=0 then            {testa se esta vazia}
      begin
           VAZIO := TRUE;
           WRITELN;
           writeln('lista esta vazia');
           TECLA := READKEY;
      end
    else
       begin                   {lista nao vazia, remove}
           p:=d.i;
           valor:=p^.dado;
           d.i:=p^.prox;
           d.n:=d.n-1;
           dispose(p);
           if d.n=0 then      {testa se a lista ficou vazia}
              begin
                   d.f:=nil;
              end;
       end;
end;

(********** PROCEDURE PARA REMOVER ELEMENTO DA DIREITA DA LISTA ************)
procedure remove_dir (VAR d:descritor; VAR valor:string);
var
  p,q    : ap_no;

begin
     if d.n=0 then
        begin
             VAZIO := TRUE;
             WRITELN;
             writeln('lista esta vazia');
             TECLA := READKEY;
        end
      else
       BEGIN
         P := d.I;
         if d.n=1 then
            begin
                 VALOR := P^.DADO;
                 d.i:=nil;
                 d.f:=nil;
                 d.n:=0;
            end
         else
            begin
              while p^.prox <> nil do
                   begin
                       q:=p;
                       p:=p^.prox;
                   end;
              VALOR := P^.DADO;
              d.f:=q;
              q^.prox:=nil;
              d.n:=d.n-1;
            end;
        DISPOSE(P);
       END;
end;

(************* PROCEDURE ORDENA LISTA SIMPLESMENTE ENCADEADA **************)
Procedure ORDENA;
var
     lsup, j, bolha     : integer;
     primeiro, segundo  : ap_NO;
     aux                : string;

Begin
     For J:= 1 TO D.N DO
        begin
           P := D.I;
           WHILE (P^.PROX <> NIL) DO
              Begin
                 LSUP := D.N;
                 REPEAT
                    Bolha := 0;
                    Primeiro := P;
                    Segundo := P^.PROX;
                    BEGIN
                       IF primeiro^.dado > segundo^.dado THEN
                          BEGIN
                             AUX := primeiro^.dado;
                             primeiro^.dado := segundo^.dado;
                             segundo^.dado := AUX;
                             Bolha := J;
                          END;
                    END;
                    LSUP := Bolha;
           UNTIL LSUP <= 1;
           P := P^.prox;
        end;
    end;
end;

(**************************** PROGRAMA PRINCIPAL **************************)
begin
     clrscr;
     criar( d );
     repeat
        VAZIO := FALSE;
        writeln('1 - Insere direita');
        writeln('2 - Insere esquerda');
        writeln('3 - Remove esquerda');
        writeln('4 - Remove direita');
        writeln('5 - Ordena');
        writeln('ESC -Sai para S.O.');
        writeln;
        writeln('Qual a opcao');
        tecla := readkey;
        case (tecla) of

          '1'  :  begin
                       write('digite o valor :');
                       readln(valor);
                       insere_dir ( d ,valor);
                  end;
          '2'  :  begin
                       write('digite o valor :');
                       readln(valor);
                       insere_esq ( d ,valor);
                  end;
          '3'  :  begin
                       remove_esq ( d ,valor);
                       if vazio <> true then
                          writeln('VALOR REMOVIDO DA ESQUERDA ',valor);
                  end;
          '4'  :  begin
                       remove_dir ( d ,valor);
                       if vazio <> true then
                          writeln('VALOR REMOVIDO DA DIREITA ',valor);
                  end;
          '5'  :  begin
                       ordena;
                  end;

        end;

(**************** MOSTRA OS ELEMENTOS DA LISTA ***************************)
        writeln('VALOR DO DESCRITOR ',d.n);
        if (vazio <> true) and (d.n <> 0) then
          begin
               P := D.I;
               cont := 1;
               writeln;
               while (p^.prox <> nil) do
                     begin
                          write(' ELE [',cont,']= ',p^.dado);
                          p := p^.prox;
                          cont := cont + 1;
                     END;
        write(' ELE [',cont,']= ',p^.dado);
        END;
        tecla := readkey;
        writeln;
        writeln;
     until tecla = #27;
end.