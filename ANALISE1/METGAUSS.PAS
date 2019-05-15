Program Estatistica;
Uses Crt;
Var
  E            : Array[1..4,1..3] of real;
  X            : array[1..3] of real;
  Aux          : Real;
  L,C,N,li,ci  : Byte;
  tecla        : char;

procedure Matriz(Ci,Li,Cf,Lf:byte);
var
  K : byte;

begin
  For  K := Li to Lf do
  begin
    gotoxy(ci,k);    write('³');
    gotoxy(cf,K);  write('³');
    gotoxy(Cf-8,k);    write(':');
  end;

  Gotoxy(Ci,Li);  write('Ú');
  gotoxy(Cf,Li);  write('¿');
  gotoxy(Ci,Lf);  write('À');
  gotoxy(Cf,Lf);  write('Ù');
end;

procedure borda(Ci,Li,Cf,LF : byte);
var
  K : byte;

begin
  For  K := Li to Lf do
  begin
    gotoxy(ci,k);    write('³');
    gotoxy(cf,K);  write('³');
  end;


  for K := Ci to Cf do
  begin
    Gotoxy(k,li);  write('Ä');
    gotoxy(k,lf);  write('Ä');
  end;


  Gotoxy(Ci,Li);  write('Ú');
  gotoxy(Cf,Li);  write('¿');
  gotoxy(Ci,Lf);  write('À');
  gotoxy(Cf,Lf);  write('Ù');
end;

procedure clear(Ci,Li,Cf,Lf : byte);
var
  k,L : byte;

begin
  for L := Li to Lf do
  begin
    for K := Ci to Cf-1 do
    begin
      gotoxy(K,L);  write(' ');
    end;
  end;
end;



begin
  clrscr;
  textbackground(7);
  textcolor(0);
  borda(27,03,45,05);
  gotoxy(29,04);  write('METODO DE GAUSS ');
  gotoxy(10,07);  write('Exemplo com 3 variaveis');

  matriz(05,13,37,19);

  Li := 14;
  For  L :=1 to 3  do
  begin
    Ci :=  07 ;
    For C := 1 to 3 do
    begin
      clear(25,09,55,09);
      Gotoxy(10,09); Write('Elemento (',L,'x',C,')  :  ');readln(E[C,L]);
      Gotoxy(Ci,Li); write(E[C,L]:5:2);
      Inc(Ci,8);
    end;
    gotoxy(10,10); write('Valor da Igualdade :' ); read(E[4,L]);
    gotoxy(10,10); write('                                   ');
    Gotoxy(Ci,Li); write(E[4,L]:5:2);
    inc(Li,2);
  end;



  Aux := E[1,2]*(-1) / (E[1,1]);
  for C := 1 to 4 do
    E[C,2] := (E[C,1] * aux) + E[C,2];

  Aux := E[1,3]*(-1) / (E[1,1]);
  for C := 1 to 4 do
    E[C,3] := (E[C,1]* aux) + E[C,3];


  Aux := E[2,3]*(-1) / (E[2,2]);
  for C := 2 to 4 do
    E[C,3] := (E[C,2] * aux) + E[C,3];

  matriz(45,13,77,19);

  li := 14;
  For  L := 1 to 3 do
  begin
    ci := 47;
    For C := 1 to 4 do
    begin
      Gotoxy(Ci,Li); write(E[C,L]:5:2);
      Ci := Ci+8;
    end;
    Li := Li+2;
  end;




  X[3] := (E[4,3]) / (E[3,3]);
  X[2] := (E[4,2] + (E[3,2]* X[3]* (-1))) / (E[2,2]);
  X[1] := (E[4,1] + (E[3,1]* X[3]* (-1)) + (E[2,1]*X[2]*(-1))) / (E[1,1]);

  Gotoxy(18,23);  write('Solucao  X  = { ',X[1]:5:2,' , ',X[2]:5:2,', ',X[3]:5:2,' }');
  readln(tecla);
  clrscr;
end.

