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
     lista:=nil;
     write('Digite o Nome= ');
     readln(valor);
     new(p);
     p ^.prox:=nil;
     lista:=p;
     p^.nome:=valor;
     dispose(p);
end.






