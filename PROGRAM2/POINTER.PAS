program lista_agenda;
uses crt;
type

   registro = record
                   nome: string[50];
                   idade: byte;
              end;
   arquivo = file of registro;

   ptr_loco = ^nodo;
   nodo = record
               nome: string[50];
               idade: byte;
               ant: ptr_loco;
               prox: ptr_loco;
          end;
var
  reg : registro;
  arq : arquivo;
  primeiro,ultimo: ptr_loco;
  opcao : char;

{---------------------------------------------------------------------------}

procedure ordena(var primeiro,ultimo : ptr_loco;  item : ptr_loco);
var
  feito: boolean;
  atual: ptr_loco;

begin
   feito:=false;
   if primeiro = nil
   then begin
           primeiro:=item;
           ultimo:=item;
           item^.prox:=nil;
           item^.ant:=nil;
        end
   else begin
           if item^.nome < primeiro^.nome
           then begin
                   primeiro^.ant:=item;
                   item^.prox:=primeiro;
                   item^.ant:=nil;
                   primeiro:=item;
                end
           else begin
                   if item^.nome > ultimo^.nome
                   then begin
                           ultimo^.prox:=item;
                           item^.ant:=ultimo;
                           item^.prox:=nil;
                           ultimo:=item;
                        end
                   else begin
                           atual:= primeiro;
                           while (not feito) do
                           begin
                              if item^.nome < atual^.prox^.nome
                              then begin
                                      item^.prox:=atual^.prox;
                                      item^.ant:=atual;
                                      atual^.prox^.ant:=item;
                                      atual^.prox:=item;
                                      feito:=true;
                                    end
                               else  atual:=atual^.prox;
                           end;
                        end;
                end;
   end;
end;

{---------------------------------------------------------------------------}

procedure pucha_lista(var primeiro,ultimo : ptr_loco {; var arq : arquivo});
var
  atual,item: ptr_loco;
  tecla: char;
begin
seek(arq,0);
 if eof (arq)
 then begin
         writeln('SEU ARQUIVO ESTA VAZIO');
         tecla:= readkey;
      end
 else while not eof (arq) do
      begin
         new(item);
         read(arq,reg);
         item^.nome:= reg.nome;
         item^.idade:= reg.idade;
         ordena(primeiro,ultimo,item);
       end;
end;

{---------------------------------------------------------------------------}

procedure busca(var atual : ptr_loco; var primeiro :ptr_loco; nome: string);
var
  feito: boolean;

begin
feito:=false;
atual:=primeiro;
while (not feito) and (atual<>nil) do
 begin
   if atual^.nome = nome
   then  feito:=true
   else  atual:=atual^.prox;
 end;
end;

{---------------------------------------------------------------------------}

procedure inclusao(var atual,primeiro,ultimo : ptr_loco);
var
  item : ptr_loco;
  tecla: char;

begin
   repeat
    new(item);
    write('QUAL O NOME? ');
    readln(item^.nome);
    write('QUAL A IDADE? ');
    readln(item^.idade);
    ordena(primeiro,ultimo,item);
    write('DIGITE "S" P/ CONTINUAR E "N" P/ SAIR ');
    readln(tecla);
   until tecla = 'N';
end;

{---------------------------------------------------------------------------}

procedure consulta(var primeiro: ptr_loco);
var
  nome:string[37];
  atual: ptr_loco;
begin
   write('QUAL O NOME A SER CONSULTADO? ');
   readln(nome);
   busca(atual,primeiro,nome);
   if atual <> nil
   then writeln('IDADE: ',atual^.idade)
   else writeln('ESTE NOME NAO EXISTE');
end;

{---------------------------------------------------------------------------}

procedure alteracao(var primeiro,ultimo:ptr_loco);
var
  nome: string;
  tecla: char;
  atual: ptr_loco;

begin
 repeat
  write('QUAL O NOME A SER ALTERADO? ');
  readln(nome);
  busca(atual,primeiro,nome);
  if atual <> nil
  then begin
          writeln(atual^.nome);
          write('NOVA IDADE');
          readln(atual^.idade);
       end
  else write('ESTE NOME NAO EXISTE!!!!');
  write('DIGITE "S" P/ CONTINUAR E "N" P/ SAIR');
  readln(tecla);
 until tecla='N';
end;

{---------------------------------------------------------------------------}

procedure exclusao(var primeiro,ultimo:ptr_loco);
var
  tecla: char;
  nome: string;
  atual: ptr_loco;

begin
 repeat
  clrscr;
  write('QUAL O NOME A SER EXCLUIDO');
  readln(nome);
  busca(atual,primeiro,nome);
  if atual <> nil
  then begin
          if atual=primeiro
          then begin
                  primeiro:= atual^.prox;
                  dispose(atual);
               end
          else
            begin
               atual^.ant^.prox:= atual^.prox;
               atual^.prox^.ant:= atual^.ant;
               dispose(atual);
            end;
        end
  else writeln('ESTE NOME NAO EXISTE');
  write('DIGITE "S" P/ CONTINUAR E "N" P/ SAIR ');
  readln(tecla);
 until tecla = 'N';
end;

{---------------------------------------------------------------------------}

procedure listagem(primeiro: ptr_loco);
var
  atual: ptr_loco;
begin
 atual:=primeiro;
 while atual <> nil do
 begin
 writeln('NOME: ',atual^.nome);
 writeln('IDADE: ',atual^.idade);
 atual:= atual^.prox;
 end;
 repeat until keypressed;
end;

{---------------------------------------------------------------------------}

procedure menu;
var
  opcao:char;
  atual: ptr_loco;
begin
 repeat
   clrscr;
   writeln('DIGITE "1" PARA INCLUSAO');
   writeln('DIGITE "2" PARA EXCLUSAO');
   writeln('DIGITE "3" PARA ALTERA€AO');
   writeln('DIGITE "4" PARA CONSULTA');
   writeln('DIGITE "5" PARA LISTAGEM');
   writeln('DIGITE "6" PARA FIM');
   writeln;
   write('ESCOLHA A OP€AO ');
   readln(opcao);
   case opcao of
                '1'  : begin
                          clrscr;
                          inclusao(atual,primeiro,ultimo);
                       end;
                '2'  : begin
                          clrscr;
                          exclusao(primeiro,ultimo);
                       end;
                '3'  : begin
                          clrscr;
                          alteracao(primeiro,ultimo);
                       end;
                '4'  : begin
                          clrscr;
                          consulta(primeiro);
                       end;
                '5'  : begin
                          clrscr;
                          listagem(primeiro);
                       end;
   end;
 until opcao = '6';
end;

{---------------------------------------------------------------------------}

procedure joga_lista(primeiro:ptr_loco);
var
  atual:ptr_loco;

begin
   rewrite(arq);
   atual:= primeiro;
   while atual <> nil do
   begin
      reg.nome := atual^.nome;
      reg.idade := atual^.idade;
      write(arq,reg);
      atual:= atual^.prox;
   end;
end;

{---------------------------------------------------------------------------}

begin
 clrscr;
 assign(arq,'agen2.dat');
{$I-}
 reset(arq);
 if ioresult <> 0
 then
 rewrite(arq);
{$I+}
 primeiro:= nil;
 ultimo:= nil;
 pucha_lista(primeiro,ultimo{,arq});
 menu;
 joga_lista(primeiro);
end.