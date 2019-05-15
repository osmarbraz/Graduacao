Program teste_lista;
uses crt;
type
    ap_no=^no;
    no=  record
             dado: string;
             prox: ap_no;
             ant:  ap_no;
         end;

    ap_descritor=^descritor;
    descritor= record
                   i,f:ap_descritor;
                   n:integer;
                end;

var
  lista,p : ap_no;
  valor   : string;
  d       : ap_descritor;

procedure criar (d:ap_descritor);
begin
    new(d);
    d^.i:=nil;
    d^.n:=0;
    d^.f:=nil;
end;
procedure insere_esq (d:ap_descritor; valor:string);
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

procedure insere_dir (d:ap_descritor; valor:string);
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

procedure remove_esq (d:ap_descritor; valor:string);
var
  p:ap_no;

begin
    if d^.n=0 then            {testa se esta vazia}
      begin
           writeln('lista esta vazia');
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

procedure remove_dir (d:ap_descritor; valor:string);
var
  p,q    : ap_no;

begin
     if d^.n=0 then
        begin
             writeln('lista esta vazia');
        end
      else
         if d^.n=1 then
            begin
                 p:=d^.i;
                 valor:=p^.dado;
                 d^.i:=nil;
                 d^.f:=nil;
                 d^.n:=0;
                 dispose(p);
            end
         else
            begin
              p:=d^.i;
              while p^.prox <> nil do
                   begin
                       q:=p;
                       p:=p^.prox;
                   end;
              d^.f:=q;
              q^.prox:=nil;
              valor:=p^.dado;
              d^.n:=d^.n-1;
              dispose(p);
            end;
end;


