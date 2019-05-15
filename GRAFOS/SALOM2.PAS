Program Brom_Kerbosch;
Uses crt;

Type
     conjunto = set of byte;
     vet_conjunto = array[0..49] of conjunto;
     vetor = array[0..49] of byte;

Label Inicio, Passo_1, Passo_2, Passo_3, Passo_4, Passo_5, Passo_6, Fim;

Var
    conj_max, conj_v_lk, conj_e_p, conj_e_n, sucessor : vet_conjunto;
    conj_aux : conjunto;
    m, n, l, k, i, n_vert, cont, x, lin, lin1,  elemento : byte;
    Xik : vetor;
    flag : boolean;
    opcao : char;


Procedure tela_dois;
begin
     gotoxy(3,25);
     write(CHR(192));
     gotoxy(77,25);
     write(CHR(217));
     m:=25;
     For n:=4 to 76 do
     begin
         gotoxy(n,m);
         write(CHR(196));
     end;
     m:=3;
     repeat
           For n:=22 to 24 do
           begin
                gotoxy(m,n);
                write(CHR(179));
           end;
           m:=m+74;
     until m > 77;
End;


Procedure compl_dois;
begin
     For n:=5 to 78 do
     begin
          gotoxy(n,2);
          write(CHR(223));
     end;
     for n:=2 to 23 do
     begin
          gotoxy(79,n);
          write(CHR(219));
     end;
End;


Procedure  tela_um;
begin
     gotoxy(3,3);
     write(CHR(218));
     gotoxy(3,22);
     write(CHR(192));
     gotoxy(77,3);
     write(CHR(191));
     gotoxy(77,22);
     write(CHR(217));
     m:=3;
     repeat
           For n:=4 to 76 do
           begin
                gotoxy(n,m);
                write(CHR(196));
           end;
           m:=m+19;
     until m > 23;
     m:=3;
     repeat
           For n:=4 to 21 do
           begin
                gotoxy(m,n);
                write(CHR(179));
           end;
           m:=m+74;
     until m > 78;
End;


Procedure compl_um;
begin
     For n:=5 to 79 do
     begin
          gotoxy(n,23);
          write(CHR(223));
     end;
     For n:=4 to 22 do
     begin
          gotoxy(79,n);
          write(CHR(219));
     end;
End;


Procedure apresentacao;
begin
     gotoxy (10,5);
     write('ALUNAS: ANGELICA KEMPER');
     gotoxy(10,6);
     write('        ELISANDRA GUIZONI');
     gotoxy(10,7);
     write('        ELISANGELA BONGIOLO');
     gotoxy(10,8);
     write('        JULIANA ZEFERINO ');
     gotoxy(10,10);
     write('DISCIPLINA: TEORIA DE GRAFOS');
     gotoxy(10,12);
     write('PROFESSOR: SALOMAO');
     gotoxy(10,14);
     write('OBJETIVO: DADO O NUMERO DE VERTICES DE UM GRAFO E OS');
     gotoxy(10,15);
     write('          SUCESSORES  DE   CADA  VERTICE,  ENCONTRAR  ');
     gotoxy(10,16);
     write('          TODOS OS  CONJUNTOS INDEPENDENTES MAXIMAIS ');
     gotoxy(10,17);
     write('          DO GRAFO ORIGINAL.');
     gotoxy(34,20);
     write('TECLE ENTER PARA CONTINUAR...');
     repeat until keypressed;
End;


Procedure Primeiro_elem (var conj_aux : conjunto; var Xik : vetor);
{Procedure para encontrar o primeiro elemento do conjunto e
 selecionar o Xik}

Var
   flag : boolean;
Begin
     flag:=false;
     i:=0;
     while (not flag) and (i <= n_vert) do
     begin
          inc(i);
          if (i in conj_aux) then
          begin
               flag:=true;
               Xik[k+1]:=i;
          end;
     end;
End;


Function Intersecao_vazia : boolean;
{Procedure para verificar se a intersecao de E+ com os sucessores de X deu
vazia, no passo 5. Caso vazia, executa o passo 6}

Var
   flag : boolean;
Begin
      flag:=false;
      for i:=1 to n_vert do
      begin
           if (i in conj_e_n[k]) then
           begin
                conj_aux:=sucessor[i] * conj_e_p[k];
                if conj_aux=[] then
                   flag:=true;
           end;
      end;
      if flag then
         Intersecao_vazia:=true
      else
          Intersecao_vazia:=false;
End;


Procedure Unico_elem(var cont, x : byte);
{Procedure para verificar se o conjunto so tem um elemento, no passo 2
caso tenha apenas 1 elemento, executa a procedure Primeiro_elem, senao executa
a Procedure Acha_xik}

Begin
     for i:=1 to n_vert do
         if (i in conj_e_n[k]) then
         begin
              inc(cont);
              x:=i;
         end;
End;

Procedure Acha_xik;
{procedure executada se conjunto E- tem mais de um elemento.}

Var
   cont_aux, vert_men : byte;
Begin
     cont_aux:=50;
     for i:=1 to n_vert do
         if (i in conj_e_n[k]) then
         begin
              for x:=1 to n_vert do
                  if (x in sucessor[i]) then
                     if (x in conj_e_p[k]) then
                        inc(cont);
              if cont < cont_aux then
              begin
                    cont_aux:=cont;
                    vert_men:=i;
              end;
         end;
         conj_aux:=sucessor[vert_men] * conj_e_p[k];
         Primeiro_elem(conj_aux, Xik);
End;


Begin {Principal}
      clrscr;
      textbackground(1);
      textcolor(15);
      clrscr;
      tela_um;
      compl_um;
      apresentacao;
      Inicio :
             lin1:=10;
             clrscr;
             for i:=0 to 49 do
             begin
                  conj_max[i]:=[];
                  conj_e_p[i]:=[];
                  conj_e_n[i]:=[];
                  conj_max[i]:=[];
                  conj_v_lk[i]:=[];
             end;
             l:=1;
             k:=0;
             clrscr;
             tela_um;
      Passo_1 :
              gotoxy(20,12);
              write('Quantos vertices possui o grafo : ');
              readln(n_vert);
              for i:=1 to n_vert do
                  conj_e_p[k]:=conj_e_p[k] + [i];
              for i:=1 to n_vert do
              begin
                   clrscr;
                   tela_um;
                   tela_dois;
                   gotoxy(10,23);
                   write('Digite zero(0) para encerrar o conjunto de sucessores de x',i);
                   flag:=false;
                   lin:=5;
                   while not flag do
                   begin
                        lin:=lin + 1;
                        gotoxy(6,lin);
                        write('Sucessor de x',i,' : ');
                        readln(elemento);
                        if (elemento>0) and (elemento<=n_vert) then
                           sucessor[i]:=sucessor[i] + [elemento]
                        else
                            if elemento=0 then
                               flag:=true
                            else
                            begin
                                 write(#7);
                                 lin:=lin - 1;
                            end;
                   end;
              end;
              writeln;
              writeln;
      Passo_2 :
              if conj_e_n[k] <> [] then
              begin
                   cont:=0;
                   Unico_elem(cont, x);
                   if cont = 1 then
                   begin
                        conj_aux:=sucessor[x] * conj_e_p[k];
                        Primeiro_elem(conj_aux, Xik);
                   end
                   else
                       Acha_xik;
              end
              else
                  Primeiro_elem(conj_e_p[k], Xik);
      Passo_3 :
              conj_v_lk[k+1]:=conj_v_lk[k] + [Xik[k+1]];
              conj_e_p[k+1]:=conj_e_p[k+1] + conj_e_p[k];
              conj_e_p[k+1]:=conj_e_p[k+1] - [Xik[k+1]];
              conj_e_p[k+1]:=conj_e_p[k+1] - sucessor[Xik[k+1]];
              conj_e_n[k+1]:=conj_e_n[k] - sucessor[Xik[k+1]];
              inc(k);
      Passo_4 :
              if (conj_e_p[k] = []) and (conj_e_n[k] = []) then
              begin
                   conj_max[l]:=conj_v_lk[k];
                   write('Conjunto maximal ',l,' : ');
                   for i:=1 to n_vert do
                       if (i in conj_max[l]) then
                          write(i,' ');
                   writeln;
                   inc(l);
                   goto Passo_6;
                   {gotoxy(40,18);
                   write('Deseja continar? (s/n)');
                   opcao:= readkey;
                   If (opcao='s') or (opcao='S') then
                      goto Inicio;}
              end
              else
                   goto Passo_5;
      Passo_5 :
              if not (conj_e_p[k] = []) then
              begin
                   if (conj_e_n[k] = []) then
                      goto Passo_2
                   else
                   begin
                        if not Intersecao_vazia then
                           goto Passo_2
                        else
                            goto Passo_6;
                   end;
              end;
      Passo_6 :
              dec(k);
              if k<>-1 then
              begin
                   conj_v_lk[k]:=conj_v_lk[k+1] - [Xik[k+1]];
                   conj_e_p[k]:=conj_e_p[k] - [Xik[k+1]];
                   conj_e_n[k]:=conj_e_n[k] + [Xik[k+1]];
                   If (k<>0) or not (conj_e_p[k] = []) then
                       goto Passo_5
                   else
                       goto Fim;
              end;
      Fim :
          writeln('Os conjuntos independentes maximais encontrados sao : ');
          gotoxy(40,18);
          write('Deseja continar? (s/n)');
          opcao:= readkey;
          If (opcao='s') or (opcao='S') then
             goto Inicio;
end.







