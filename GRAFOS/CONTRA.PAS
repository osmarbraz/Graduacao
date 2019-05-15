Program Grafos;

uses crt,dos,uFunc,uVideo;

Type
    Vetor   = array [1..30,1..30] of byte;
    Matriz  = Record
                   A : array[1..30,1..30] of byte;
              End;
    Arquivo = File of Matriz;
Var
    Tecla,
    Sair                          : Char;
    Arq                           : Arquivo;
    Reg                           : Matriz;
    Nome,Chave                    : String[50];
    Ordem,X,D,Conta,Opcao,Cont,
    Linha,Coluna,Lin,Col,Soma,Aux : INTEGER;
    F,N,A,V,R,Q,M                 : Vetor;
    Y                             : Array[1..30,1..30] of Char;


BEGIN
     CLRSCR;

{]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] LEITURA DA MATRIZ ]]]]]]]]]]]]]]]]]]]]]]]]]]]}

    Repeat
      clrscr;
      textcolor(15);
      textbackground(6);

(******************* tamanho da matriz ************************************)
      WriteXY(10,15,'DIGITE O TAMANHO DA MATRIZ : ',$F+$60);
      gotoxy(40,15);readLN(ORDEM);

(******************** nome do arquivos ************************************)
      pWriteXY(10,17,'DIGITE O NOME DO ARQUIVO : ');
      gotoxy(40,17);readln(nome);

(****************** acessa o arquivo **************************************)
      assign(arq,nome);
      {$I-}
      reset(arq);
      {$I+}

(**** se nao existir arquivos prepara o arquivo para inserir a matriz ***)
      if ioresult <> 0 then
      begin
        clrscr;
        Rewrite(arq);
        lin:=10;
        Col:=15;
        for Linha:=1 to ordem do
        Begin
          gotoxy(col,lin-2);
          write('.',linha);
          col:=col+4;
        end;
        For Linha:=1 to ordem do
        begin
          col:=15;
          if ordem >=9 then
          begin
            gotoxy(ordem*5,lin);
            write('.',linha);
          end
          else
          begin
            gotoxy(ordem*6,lin);
            write('.',linha);
          end;
        for Coluna:=1 to ordem do
        Begin
          with reg do
          begin
            gotoxy(col,lin);
            read(a[linha,coluna]);
            v[linha,coluna]:=a[linha,coluna];
            col:=col+4;
          end;
        end;
        lin:=lin+1;
      end;
      Seek(arq,filesize(arq));
      write(arq,reg);
      gotoxy(10,23);
      write('Pressine qualquer tecla para continuar');
    end

    else
     begin
      clrscr;
      assign(arq,nome);
      reset(arq);
      seek(arq,0);
      while(not eof(arq)) do
      begin
        read(arq,reg);
        with reg do
        begin
          for linha:=1 to ordem do
          for coluna:=1 to ordem do
          v[linha,coluna] := a[linha,coluna];
        end;
      end;

(***************conStroi a matriz adjacente*****************************)
      lin:=10;
      col:=15;
      gotoxy(15,5);
      write('Matriz adjacente');
      for linha:=1 to ordem do
      begin
        gotoxy(col,lin-2);
        write('.',linha);
        col:=col+4;
      end;
      for linha:=1 to ordem do
      begin
        col:=15;
        if ordem >=9 then
        begin
          gotoxy(ordem*5,lin);
          write('.',linha);
        end
        else
        begin
          gotoxy(ordem*7,lin);
          write('.',linha);
        end;
        for coluna:=1 to ordem do
        begin
          gotoxy(col,lin);
          write(v[linha,coluna]);
          col:=col+4;
        end;
        lin:=lin+1;
      end;
    end;
gotoxy(10,24);
write('Pressione ENTER');
{end;}
tecla:= readkey;
close(arq);

{[[[[[[[[[[[[[[[[[[[[[[[[[ GERANDO A MATRIZ ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]}

       for Linha:=1 to ordem do
       for Coluna:=1 to ordem do
          begin
             R[Linha,Coluna]:=0;
             Y[Linha,Coluna]:='F';
          end;

for linha:=1 to ordem do
BEGIN
  conta:=1;
  While conta<=ordem  do
  Begin
    if conta=Linha then
      R[Linha,conta]:=1;
    if (R[Linha,conta]=1) and (Y[Linha,conta]='F') then
      Begin
        for D:=1 TO ordem do
        IF v[conta,D]=1 then
             R[Linha,D]:=1;
             Y[Linha,conta]:='V';
             conta:=1;
       End
       Else
          conta:=conta+1;
  End;
End;

{[[[[[[[[[[[[[[[[[[[[[[[ MOSTRANDO A MATRIZ R ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]}
clrscr;
PUSHWIN(2,2,75,24,$0+$70,MARGEM2,TRUE);
lin :=10;
col :=15;
PwriteXY(15,5,'Matriz R de acessibilidade');
for linha:=1 to ordem do
   begin
     TEXTBACKGROUND(7);
     TEXTCOLOR(0);
     gotoxy(col,lin-2);
     Write('.',linha);
     col:=col+4;
   end;
for linha:=1 to ordem do
begin
  col:=15;
  if ordem >=9 then
  begin
    gotoxy(ordem*5,lin);
    write('.',linha);
  end
  else
  begin
    gotoxy(ordem*7,lin);
    write('.',linha);
  end;
  for coluna:=1 to ordem do
  begin
    gotoxy(col,lin);
    write (R[Linha,Coluna]);
    col:=col+4;
   end;
   lin:=lin+1;
end;
gotoxy(10,24);
write('Pressione ENTER');
tecla:=readkey;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ GERANDO A TRANSPORTA ]]]]]]]]]]]]]]]]]]]]}

For Linha:=1 to ordem do
for Coluna:=1 to ordem do
    Q[Coluna,Linha]:=R[Linha,Coluna];

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ MOSTRANDO A MATRIZ Q [[[[[[[[[[[[[[[[[[[[[[[[}

clrscr;
PUSHWIN(2,2,75,24,$0+$70,MARGEM2,TRUE);
lin:=10;
col:=15;
PwriteXY(25,5,' Matriz Q');
for linha:=1 to ordem do
  Begin
    for coluna:=1 to ordem do
      begin
        TEXTBACKGROUND(7);
        TEXTCOLOR(0);
        GOTOXY(COL,LIN);
        write(Q[Linha,Coluna]);
        col:=col+4;
      end;
      lin:=lin+1;
      col:=15;
  end;
  tecla:=readkey;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ MULTIPLICANDO Q * R ]]]]]]]]]]]]]]]]]]]]]]] }
for linha:=1 to ordem do
for coluna:=1 to ordem do
    Begin
      m[linha,coluna]:=0;
      N[Linha,Coluna]:=0;
      if (r[linha,coluna]=1) and (q[linha,coluna]=1) then
         Begin
           M[linha,coluna]:=1;
           N[Linha,Coluna]:=1;
         End;
    end;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ ZERANDO A MATRIZ AUXILIAR ]]]]]]]]]]]]]]]]]]]]}
for linha:=1 to ordem do
for coluna:=1 to ordem do
    f[linha,coluna]:=0;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ CALCULANDO OS COMPONENTES ]]]]]]]]]]]]]]]]]]}
    conta:=0;
    for linha:=1 to ordem do
        begin
            if m[linha,1]<>9 then
            begin
               conta:=conta+1;
               f[conta,linha]:=linha;
               for d:=linha+1 to ordem do
                  begin
                  if m[d,1]<>9 then
                  begin
                     coluna:=1;
                     while (coluna<ordem+1) do
                     if (m[linha,coluna]=m[d,coluna]) then
                        coluna:=coluna+1
                     else
                        coluna:=ordem+10;
                     if coluna=(ordem+1) then
                     begin
                       f[conta,d]:=d;
                       m[d,1]:=9;
                     end;
                  end;
               end;
            end;
        end;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ MOSTRANDO OS COMPONENTES FORTES ]]]]]]]]]]]]}
clrscr;
PUSHWIN(2,2,75,24,$0+$70,MARGEM2,TRUE);
lin:=5;
col:=10;
gotoxy(10,03);
writeln('COMPONENTES FORTES DO GRAFO CONDENSADO');
for linha:=1 to conta do
  begin
    gotoxy(col,lin);
    write('X',linha,'* = {');
    col:=col+8;
    for coluna:=1 to ordem do
    begin
      if f[Linha,Coluna]<>0 then
      begin
        gotoxy(col,lin);
        write ('x',f[linha,coluna],' ');
        writeln('}');
        col:=col+4;
      end;
    end;
    lin:=lin+2;
    col:=10;
end;

{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[ CALCULANDO A BASE [[[[[[[[[[[[[[[[[[[[[[[[[[}
    linha:=1;
    lin:=18;
    col:=5;
    while linha<=conta do
    begin
       coluna:=1;
       while coluna<=ordem do
       begin
           soma:=0;
           if f[linha,coluna]=0 then coluna:=coluna+1
           else
           begin
              aux:=f[linha,coluna];
              soma:=0;
              for d:=1 to ordem do
                 if Q[AUX,D]=N[AUX,D] then
                 soma:=soma+1;
               if soma=ordem then
               begin
                 gotoxy(col,lin);
                 write('BASE  ');
                 write('X',Linha,'* = {');
                 for d:=1 to ordem do
                   if f[Linha,D]<>0 then
                      write('x',F[Linha,D],' ');
                      coluna:=ordem+1;
                      write('}');
                      lin:=lin+1;
                      writeln;
               end
               else
               Linha:=Linha+1;
       end;
    end;
    linha:=linha+1;
end;

{****************************** CALCULANDO A CONTRA-BASE *******************}
linha:=1;
while linha<= conta do
begin
   coluna:=1;
   while coluna<= ordem do
   begin
      if f[linha,coluna]=0 then
      coluna:=coluna+1
      else
      begin
         soma:=0;
         for d:=1 to ordem do
         soma:=soma+q[coluna,d];
         if soma=ordem then
            coluna:=coluna+1
         else
         Coluna:=ordem+10;
      end;
    end;
    if coluna=ordem+1 then
      begin
        gotoxy(col,lin);
        write('CONTRABASE  ');
        write('X',Linha,'* = {');
        for d:=1 to ordem do
          IF F[Linha,D]<>0 then
             write('x',f[linha,d],' ');
             write('}');
             lin:=lin+1;
             linha:=linha+1;
      end
      else
       linha:=linha+1;
end;
tecla:=readkey;
gotoxy(40,24);
write('Sair do sistema [S/N]');
sair:=readkey;
POPWIN;
POPWIN;
POPWIN;
until UPCASE(sair)='S';
end.