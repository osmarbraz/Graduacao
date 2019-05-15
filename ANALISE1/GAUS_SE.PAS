Program Estatistica;
Uses Crt;
Var
  E            : Array[1..5,1..4] of real;
  X1,X2,X3,X4     : array[1..1500] of real;
  Aux,Delta,Xa,Xb,Xc,Xd,Erro  : Real;
  L,C,K,Nitera,ci,Nvar : Byte;
  nit : boolean ;
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
  textbackground(0);
  clrscr;
  textbackground(7);
  clear(04,02,77,24);
  TEXTCOLOR(0);
  {clrscr;}
  borda(27,02,55,04);
  textcolor(05);
  gotoxy(28,03);  write('  METODO DE GAUSS SEIDEL   ');
  textcolor(0);
  gotoxy(10,05);  write('Exemplo com 4 variaveis ');
  gotoxy(10,05);   write('Informe o valor de Delta  : ');   read(delta);
  gotoxy(10,06);  write('N§ maximo de iteracoes    : ');   read(Nitera);

  For  L :=1 to 4  do
  begin
    For C := 1 to 4 do
    begin
      Gotoxy(10,09); Write('Elemento (',L,'x',C,')  :  ');readln(E[C,L]);
      clear(27,09,55,09);
    end;

    gotoxy(10,11); write('Valor de  B',L,'    : '); read(E[5,L]);
    clear(10,11,50,11);
  end;

  begin
    Gotoxy(10,13);  write('Informe o valor inicial p/ X1 : '); read(X1[1]);
    Gotoxy(10,14);  write('Informe o valor inicial p/ X2 : '); read(X2[1]);
    Gotoxy(10,15);  write('Informe o valor inicial p/ X3 : '); read(X3[1]);
    Gotoxy(10,16);  write('Informe o valor inicial p/ X4 : '); read(X4[1]);
  end;

    Nit := false;
  k := 1 ;
  while  k <= Nitera  do
  begin
    X1[k+1] := (1/E[1,1]) * (E[5,1] - E[2,1]*X2[k] - E[3,1]*X3[k] - E[4,1]*X4[k]);
    X2[k+1] := (1/E[2,2]) * (E[5,2] - E[1,2]*X1[k+1] - E[3,2]*X3[k] - E[4,2]*X4[k]);
    X3[K+1] := (1/E[3,3]) * (E[5,3] - E[1,3]*X1[K+1] - E[2,3]*X2[K+1] - E[4,3]*X4[k]);
    X4[K+1] := (1/E[4,4]) * (E[5,4] - E[1,4]*X1[K+1] - E[2,4]*X2[K+1]- E[3,4]*X3[K+1]);

    Xa :=  (abs(X1[K+1]-X1[k]));
    Xb :=  (abs(X2[K+1]-X2[k]));
    Xc :=  (abs(X3[K+1]-X3[k]));
    Xd :=  (ABS(X4[k+1]-X4[k]));

    if (Xa > Xb) and (Xa > Xc) AND (Xa > Xd) THEN
    BEGIN
      Erro := Xa;
    end;
    If (Xb > Xa) and (Xb > Xc) and (Xb > Xd) then
    begin
      erro := Xb;
    end;
    if (Xc > Xa) and (Xc > Xb) and (Xc > Xd) then
    begin
      erro := Xc;
    end;
    if (Xd > Xa) and (Xd > Xc) and (Xd > Xc) then
    begin
      erro := Xd;
    end;

    if erro < delta  then
    begin
      gotoxy(10,19);  write('Solucao obtida X = (',X1[K+1]:5:4,' , ',X2[K+1]:5:4,' , ',X3[K+1]:5:4,' , ',X4[K+1]:5:4);
      gotoxy(10,20);  write('Com a precisao de ',Erro:5:5);
      gotoxy(10,21);  write('Com ',K,' iteracoes ');
      nit:=true;
      K   := Nitera;
    end;
    K := K+1;
  end;

  if not nit then
  begin
    gotoxy(10,20);   write('Nao foi encontrada a solucao com ',K-1,' iteracoes.');
  end;

  begin
    gotoxy(20,23);
    write('Precione <ENTER> para sair');
    read(tecla);
  end
END.

