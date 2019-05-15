Program teste_lista;
uses crt;
type
    ap_no=^no;
    no =  record
             dado: string;
             prox: ap_no;
         end;

    ap_descritor = ^DESCRITOR;
    descritor= record
                   i,f :ap_NO;
                   n   :integer;
                   X   : AP_DESCRITOR;
                end;

var
  VAZIO : BOOLEAN;
  lista,p : ap_no;
  valor   : string;
  d       : AP_DEscritor;
  tecla   : char;
  CONT    : INTEGER;

procedure criar (var d : AP_descritor);
begin
    new(d);
    d^.i :=nil;
    d^.n :=0;
    d^.f :=nil;
end;

procedure insere_esq (VAR d:ap_descritor; VAR valor:string);
var
  p:ap_no;
begin
    new(p);
    p^.dado:=valor;
    if d^.n=0 then
       begin
          d^.i:=p;            {lista vazia}
          d^.f:=p;
          d^.n:=1;
          p^.prox:=nil;
       end
    else
        begin
             p^.prox:=d^.i;   {lista cheia}
             d^.i:=p;
             d^.n:=d^.n+1;
        end;
end;

procedure insere_dir (VAR d:ap_descritor; VAR valor:string);
var
   p,q: ap_no;

begin
     new(p);
     p^.dado:=valor;
     p^.prox:=nil;
     if d^.n=0 then
        begin
             d^.i:=p;          {lista vazia}
             d^.f:=p;
             d^.n:=1;
        end
      else
          begin
               q:=d^.f;        {lista cheia}
               d^.f:=p;
               q^.prox:=p;
               d^.n:=d^.n+1;
          end;
end;

procedure remove_esq (VAR d:ap_descritor;VAR  valor:string);
var
  p:ap_no;

begin
    if d^.n=0 then            {testa se esta vazia}
      begin
           VAZIO := TRUE;
           WRITELN;
           writeln('lista esta vazia');
           TECLA := READKEY;
      end
    else
       begin                   {lista nao vazia, remove}
           p:=d^.i;
           valor:=p^.dado;
           d^.i:=p^.prox;
           d^.n:=d^.n-1;
           dispose(p);
           if d^.n=0 then      {testa se a lista ficou vazia}
              begin
                   d^.f:=nil;
              end;
       end;
end;

procedure remove_dir (VAR d:ap_descritor; VAR valor:string);
var
  p,q    : ap_no;

begin
     if d^.n=0 then
        begin
             VAZIO := TRUE;
             WRITELN;
             writeln('lista esta vazia');
             TECLA := READKEY;
        end
      else
       BEGIN
         P := D^.I;
         if d^.n=1 then
            begin
                 VALOR := P^.DADO;
                 d^.i:=nil;
                 d^.f:=nil;
                 d^.n:=0;
            end
         else
            begin
              while p^.prox <> nil do
                   begin
                       q:=p;
                       p:=p^.prox;
                   end;
              VALOR := P^.DADO;
              d^.f:=q;
              q^.prox:=nil;
              d^.n:=d^.n-1;
            end;
        DISPOSE(P);
       END;
end;

(************ PROGRAMA PRINCIPAL ****************)

begin
     clrscr;

     criar( d );
     repeat
        VAZIO := FALSE;
        writeln('1 - Insere direita');
        writeln('2 - Insere esquerda');
        writeln('3 - Remove esquerda');
        writeln('4 - Remove direita');
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
          '2'  :  BEGIN
                       write('digite o valor :');
                       readln(valor);
                       insere_esq ( d ,valor);
                  END;
          '3'  :  BEGIN
                       remove_esq ( d ,valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA ESQUERDA ',VALOR);
                  END;
          '4'  :  BEGIN
                       remove_dir ( d ,valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA DIREITA ',VALOR);
                  END;
        end;

        writeln('VALOR DO DESCRITOR ',d^.n);
        IF (VAZIO <> TRUE) AND (D^.N <> 0) THEN
          BEGIN
               P := D^.I;
               CONT := 1;
               WRITELN;
               WHILE (P^.PROX <> NIL) DO
                     BEGIN
                          WRITE(' ELE [',CONT,']= ',P^.DADO);
                          P := P^.PROX;
                          CONT := CONT + 1;
                     END;
        WRITE(' ELE [',CONT,']= ',P^.DADO);
        END;
        TECLA := READKEY;
        WRITELN;
        WRITELN;
     until tecla = #27;
end.