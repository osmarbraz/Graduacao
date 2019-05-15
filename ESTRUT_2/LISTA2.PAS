Program teste_lista;
uses crt;
type
    ap_no=^no;
    no=  record
             nome: string;
             prox: ap_no;
         end;
var
  lista,p : ap_no;
  valor   : string;

begin
     {inclusao de um segundo elemento na primeira posicao}

     clrscr;
     lista:=nil;
     write('Digite o Nome= ');
     readln(valor);
     new(p);
     p^.prox:=nil;
     lista:=p;
     p^.nome:=valor;
     write('Digite o Nome2= ');
     readln(valor);
     new(p);
     p^.prox:=lista;
     lista:=p;
     p^.nome:=valor;
end.






