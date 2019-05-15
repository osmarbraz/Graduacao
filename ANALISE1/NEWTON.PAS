program newton;
   uses crt;
   var
      ch                            :char;
      nit,nmax                      :word;
      erro,tol,x0,x1                :real;


   procedure leitura(var nmax:word;var tol,x0:real);
      begin
         clrscr;
         write('Digite o numero maximo de itera‡oes: ');
         readln(nmax);
         writeln;
         write('Digite a tolerancia: ');
         readln(tol);
         writeln;
         write('Digite o ponto inicial: ');
         readln(x0);
         writeln;
      end;


   procedure saida(var nit:word; var erro,tol,x0 :real);
      begin
         if (erro <= tol) then
         begin
            write('A raiz aproximada ‚ = ',x0:8:4);
            writeln(' com ',nit:2,' itera‡oes erro = ',erro:8:4);
         end
         else
         begin
            write('NÆo encontrei a raiz com ',nit:2,' itera‡oes');
            writeln('( x = ',x0:8:4,'   erro = ',erro:8:4,')');
         end;
      end;

{                                               -x2
 **************  Processo para a funcao f(x) = e    - x **************
 *** Para calculo de outra formula, basta substituir na function FUN ,
 bem como, a sua derivada, na function DERFUN ************************
                                                                      }

    function fun (var x : real):real;
      begin
         fun := exp(-x*x) - x;
      end;

{
 ***** A function " derfun " representa a derivada da funcao f *****
                                                                   }

    function derfun(var x:real):real;
      begin
         derfun := -2*x*exp(-x*x) - 1;
      end;

    {$i apres.pas}
    begin
      capa_de_trabalho;
      leitura(nmax,tol,x0);
      nit := 0;                         {inicializa o contador}
      repeat
         nit  := nit+1;                 {incrementa o numero de iteracoes}
         x1   := x0-fun(x0)/derfun(x0); {calcula o proximo valor de x}
         erro := abs(x1-x0);            {calcula erro, p/ verificar condicao}
         x0   := x1;
      until (nit >= nmax) or (erro <= tol);
      saida(nit, erro, tol, x0);
      readln;
   end.