program bolha;
uses crt;

var
vet:array[1..100] of integer;
k,troca,cont,aux,p,i,n:integer;

begin

clrscr;
TEXTCOLOR(10);
gotoxy(15,2);write('*************** METODO DA BOLHA **************');
gotoxy(10,5);write('DIGITE O A QUANTIDADE DE NUMEROS DA TABELA I: ');
readln(n);
writeln;
TEXTCOLOR(15);
gotoxy(25,9);write('TABELA I');

for i:=1 to n do begin
    TEXTCOLOR(15);
    gotoxy(15,i+10);write('digite o ',i,'§ numero : ');
    readln(p);
    vet[i]:=p;
    end;
repeat
troca:=0;
cont:=0;
  repeat
  inc(cont);
    for i:=cont to (n-1) do begin
       if vet[i] > vet[i+1] then begin
         inc(troca);
         aux:=vet[i];
         vet[i]:=vet[i+1];
         vet[i+1]:=aux;
       end;
    end;
    gotoxy(55,9);write('TABELA II (ordenada)');
    for k:=1 to (i+1) do begin
      gotoxy(45,k+10);write('===          ',k,'§ Lugar : ',vet[k],' ');
      delay(50);
    end;
  until cont <= n;
until troca=0;

   readln;
end.



