program briot_ruffini;
uses crt;
var
     a,d:array[0..50] of real;
     x,c,p,b:real;
     h,i:integer;
     g:integer;
     tecla:char;
begin
repeat
  clrscr;
  write('digite o grau do polinomio:');
  readln(h);
  write('digite o ponto p(x)');
  read(p);
  writeln('Entre com os indices de x ');
     for i:=h downto 0 do
          begin
           write('indice de x na ',i,' e : ');
           read(a[i]);
           end;
           b:=a[g];
           c:=b*p;
           d[g]:=b;
          for i:=g-1 downto 0 do
             begin
               d[i]:=c+a[i];
               c:=d[i]*p;
               end;
               clrscr;
               for i:=h downto 1 do
                   begin
                     writeln('indice de x na ',i-1,'e : ',d[i]:2:2);
                   end;
                   writeln('p(',p:2:00,') e : ',d[0]:3:2);
                   write('novo calculo(s/n)');
                   tecla:=readkey;
       until (tecla='N')or(tecla='n');
 end.
