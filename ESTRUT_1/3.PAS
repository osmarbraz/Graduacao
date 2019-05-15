program insercao;
uses crt;

var
vet2,vet:array[1..100] of integer;
pos1,pos,achou,k,l,j,menor,i,n,p:integer;

begin

clrscr;
TEXTCOLOR(10);
gotoxy(15,2);write('*************** METODO DA INSER€AO **************');
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

   achou:=0;
   for j:=1 to (i-1) do
        if (vet[j] > p) and (achou = 0) then begin
           inc(achou);
           pos:=j;
           k:=i;
           repeat
               dec(k);
               vet[k+1]:=vet[k];
           until k = pos;

           vet[pos]:=p;


        end;

   for l:=1 to i do begin
       TEXTCOLOR(14);
       gotoxy(55,9);write('TABELA II (ordenada)');
       gotoxy(45,l+10);write('===        ',l,' § Lugar :',vet[l],' ');
   end;
end;
readln;
end.

