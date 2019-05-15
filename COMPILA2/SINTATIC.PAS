program sintatic;
uses crt,u_lexico,carsint;
const
 maxg  =  500;
 maxt  =  500;
 maxnt =  500;
 maxk  =  500;

type
 alfa       = record
               nomet   : string[40];
               classe  : string[30];
               linha   : integer;
              end;
var
 k          : array [1..maxk]  of integer;
 topo       : integer;
 objt       : shortint;

{**************************************************************************}
procedure trataerro (erro : shortint);
 begin
  writeln ('Erro = ',erro);
  halt (0);
 end;

procedure empilha (p : integer);
 begin
  topo    := topo+1;
  k[topo] := p;
 end;

function desempilha: integer;
 begin
  desempilha := k[topo];
  topo       := topo-1;
 end;

procedure anasint (objt : integer); {analisador sintatico}
var
 continue       : boolean;{controle da continuacao da interpretacao}
 index          : integer;{indice para os nos do grafo - indica o no interpretado}
 ent            : tk;
begin
 des_token (ent); {le o primeiro simbolo}
 topo     := 0;   { inicia com a pilha vazia}
 index    := tN [objt].prim; {aponta para o primeiro no do simbolo inicial}
 continue := true;
 while continue do
  begin
   if index <> 0 then {nao e o fim de uma producao?}
    begin {1}
     if TG [index].ter then {e um terminal?}
      begin {2}
       if TG [index].sim = 0 then {e um no vazio?}
        begin {3}
         index := TG [index].suc; {vai para o sucessor}
        end {3}
       else
        begin {4}
         if (TT[TG [index].sim] = ent.nomet) or (TT[TG [index].sim] = ent.classe) then {reconheceu um terminal}
          begin {5}
           des_token (ent); {le o proximo registro}
           index := TG [index].suc; {vai para o sucessor}
          end {5}
         else
          begin {6}
           if TG [index].alt <> 0 then {Ha alternativas?}
            begin {7}
             index := TG [index].alt {tome a alternativa}
            end {7}
           else
            begin {8}
             trataerro (1); { erro sintatico}
            end; {8}
          end; {6}
        end; {4}
      end {2}
     else { E um nao terminal }
      begin {9}
       empilha (index);
       index := TN [TG [index].sim].prim; {vai p/ o 1o no do nao terminal}
      end; {9}
    end {1}
   else
    begin {10}
     if topo <> 0 then {a pilha nao esta vazia?}
      begin {11}
       index := desempilha;
       index := TG [index].suc;{ Vai p/ o sucessor do nao terminal}
      end {11}
     else
      begin {12}
       if ent.nomet = ' ' then {E o fim do arquivo}
        begin {13}
         {Sucesso;}
        end {13}
       else
        begin {14}
         trataerro (2); {Estao sobrando simbolos}
         continue := false; {Encerra a analise}
        end; {14}
      end; {12}
    end; {10}
  end; {fim enquanto}
end;

begin
 objt := 1;
 lexico ('c:\turbo7\teste.pas');
 car_sint; {chamada ao carregador sintatico}
 anasint (objt); {chamada ao analisador sintatico}
end.