program teste;

uses crt;
type
  ap_nodo = ^nodo;
  nodo = record
         n : string[20];
         ant,prox : ap_nodo;
       end;

var
   lista : ap_nodo;
   posicao,i : word;
   nome : string[20];

procedure inclui(var lista : ap_nodo; nome : string);
var
  novo,atual : ap_nodo;
begin
     new(novo);
     novo^.n := nome;
     novo^.ant := nil;
     novo^.prox := nil;
     if lista = nil then
       lista := novo
     else
     begin
       atual := lista;
       while atual^.prox <> nil do
       begin
          atual := atual^.prox;
       end;
       atual^.prox := novo;
       novo^.ant := atual;
     end;
end;

procedure listagem(lista : ap_nodo;pos : word);
var
  cont : word;
  aux  : ap_nodo;
begin
   cont := 1;
   aux := lista;
   while (aux^.prox <> nil) and (cont <> pos) do
   begin
      aux := aux^.prox;
      inc(cont);
   end;
   if cont <> posicao then
      write('Posicao nao incluida na lista')
   else
      writeln('=====> ',aux^.n);
end;

procedure list_geral(lista : ap_nodo);
var
   aaa: ap_nodo;
begin
    aaa:= lista;
while aaa <> nil do
  begin
    writeln('nome eh : ', aaa^.n);
    aaa:= aaa^.prox;
  end;
end;

begin     {  do principal   }
    clrscr;
    lista:=nil;

    for i := 1 to 5 do
    begin
       write('Entre com o nome ', i, ' = ');
       readln(nome);
       inclui(lista,nome);
       writeln('Incluido ...');
    end; { for }

    write('Entre com a posicao a ser lida : ');
    readln(posicao);
    listagem(lista,posicao);
    {write('lista limpa');}
    list_geral(lista);
    readln;
end.
