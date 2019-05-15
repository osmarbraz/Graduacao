Program G_Seidel;
uses crt;
type
    matriz = array[1..10,1..10] of real;
    vetor = array[1..10] of real;
var
   tecla: char;
   cont,i,j,col,lin,k,y,posi: byte;
   erroinf,maior, divisor, erro: real;
   mat1, mat2 : matriz;
   vet1,vet2 : vetor;

begin
   clrscr;
   writeln;
   writeln('              ษอออออออออออออออออออออออออออออออออออออออออออออออออป');
   writeln('              บ           METODO   DE   GAUSS - SEIDEL          บ');
   writeln('              ศอออออออออออออออออออออออออออออออออออออออออออออออออผ');
   gotoxy(06,06);
   write('Numero de Linhas : ');
   readln(lin);
   gotoxy(06,08);
   write('No. iteracoes : ');
   readln(cont);
   gotoxy(48,08);
   write('Erro : ');
   readln(erroinf);
   window(4,12,80,25);
   clrscr;
   k := 0;  {inicializacao do contador de iteracoes}
   erro := 9999999;  {inicializacao do erro}
   for i := 1 to lin do
       begin
         {***** LEITURA DOS ELEMENTOS DA MATRIZ *****}
         col := 3;
         for j := 1 to (lin+1) do
             begin
               if j > lin then
                  begin
                    gotoxy(col,i);
                    writeln(' = ' );
                    gotoxy(col+5,i);
                    readln(mat1[i,j]);
                  end
               else
                  begin
                    gotoxy(col,i);
                    readln(mat1[i,j]);
                    inc(col,8);
                  end;
             end;
       end;
       {***** LEITURA DOS PONTOS INICIAIS *****}
   col := 9; y:=9;
   gotoxy(15,7);
   write('Pontos Iniciais : ');
   for i := 1 to lin do
       begin
         gotoxy(col,y);
         readln(vet1[i]);
         vet2[i] := vet1[i];
         inc(col,8);
       end;
   while (erro > erroinf) and ( k < cont) do
   begin
     k:=k+1;   { INCREMENTA O CONTADOR DE ITERACOES }
     for i:=1 to lin do
        begin
          for j := 1 to (lin+1) do
            if i = j then
               divisor := mat1[i,j]
            else
              if j <= lin then
              begin
                 mat2[i,j] := mat1[i,j]*(-1);
                 vet1[i] := vet1[i]+mat2[i,j]*vet1[j];
              end;
            vet1[i] := (vet1[i]+mat1[i,j])/divisor;
     end;
     maior := 0;
     for i := 1 to lin do
        if (vet1[i] > maior) then
        begin
           maior := vet1[i];
           posi := i;
        end;
        erro := abs(vet1[posi]-vet2[posi]);
             for i:=1 to lin do
                 vet2[i] := vet1[i];
         end;
     writeln('Com ',k,' iteracoes e com um erro de ', erro:8:6);
     gotoxy(15,19);
     col := y; y:=20;
     writeln(' VETOR SOLUCAO: ');
     for i:= 1 to lin do
       begin
         gotoxy(col,y);
         write(vet1[i]:8:3);
         inc(col,8);
       end;
     tecla:=readkey;
end.