program selecao_direta;
uses crt;
var
vet2,vet:array[1..100] of integer;

marc,j,menor,i,n,p:integer;


begin

clrscr;
TEXTCOLOR(10);
gotoxy(10,2);write('****************** METODO DA SELECAO DIRETA ********************');
gotoxy(15,5);write('DIGITE A QUANTIDADE DE NUMEROS DA TABELA I : ');
readln(n);
writeln;
for i:=1 to n do begin
TEXTCOLOR(15);
    gotoxy(15,9);write('TABELA I');
    gotoxy(10,i+10);write('digite o ',i,' n§ : ');
    readln(p);
    vet[i]:=p;
    end;

for j:=1 to n do begin
    menor:=9999;
    for i:=1 to n do begin
        while vet[i] < menor do begin
           menor:=vet[i];
           marc:=i;
           end;
        end;
     vet[marc]:=9999;
     vet2[j]:=menor;
     end;

for i:=1 to n do begin
    gotoxy(50,9);write('TABELA II (ordenada)');
    gotoxy(40,i+10);write('===       ',i,'§ Lugar : ',vet2[i]);
    end;
readln;

end.


