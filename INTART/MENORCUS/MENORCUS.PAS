Program MenorCusto;
Uses Crt, Dos;

Const
     Maximo = 100;

Type
    str20 = string[20];

    Tipo_voo = record origem    : str20;
                      destino   : str20;
                      distancia : integer;
                      aberto    : boolean;
               end;

    Tipo_solucao = record origem   : str20;
                          destino  : str20;
                          dist     : integer;
                   end;

Var
   Voo                  : array [1..Maximo] of Tipo_voo;
   Solucao              : array [1..Maximo] of Tipo_solucao;
   numero_voos,topo     : word;
   origem,destino       : str20;
   outro_destino        : str20;
   R                    : Registers;
   sair                 : boolean;
   tecla                : char;
   cidades              : array [1..Maximo] of str20;
   numero_cidades       : integer;

{Emite um Beep}
Procedure beep (freq,time :INTEGER );
Begin
     Sound (freq);
     Delay (time);
     Nosound;
End;

{Acende o Cursor}
Procedure Cursor_ON;
Begin
    R.ah:=1;
    R.ch:=6;
    R.cl:=7;
    Intr(16,R);
End;

{Apaga o Cursor}
Procedure Cursor_OFF;
Begin
    R.ah:=1;
    R.ch:=8;
    R.cl:=0;
    Intr(16,R);
End;
{Cria uma moldura}
Procedure windows (c1,l1,c2,l2 : INTEGER);
VAR
   l,c :INTEGER;
Begin
     Window (1,1,80,25);
     Gotoxy (c1,l1);
     Write ('É');
     Gotoxy (C2,L1);
     Write ('»');
     Gotoxy (c1,l2);
     Write ('È');
     Gotoxy (c2,l2);
     Write ('¼');
     For c:=c1+1 TO c2-1 DO
         Begin
              Gotoxy (c,l1);
              Write ('Í');
              Gotoxy (c,l2);
              Write ('Í');
         End;
     For L:=l1+1 TO l2-1 DO
         Begin
              Gotoxy (c1,l);
              Write ('º');
              Gotoxy (c2,l);
              Write ('º');
         End;
     Window (c1+1,l1+1,c2-1,l2-1);
End;

{Escreva uma String em determinada posicao na tela}
Procedure escreva (x,y : Byte ; cadeia : String);
Begin
     Gotoxy (x,y);
     Write (cadeia);
End;

Procedure Leitura (Var caracter : Char);
Begin
     caracter := Readkey;
     caracter := Upcase(caracter);
End;

{Transforma as palavras para maiscula}
function maiscula (Var aux : str20): str20;
Var
   tam,x  : Word;
Begin
    tam := Length (aux);
    For x:= 1 To tam Do
        aux[x] := Upcase (aux[x]);
    maiscula := aux;
End;


{ Inicializa Variaveis }
Procedure Inicializacao;
Begin
     numero_voos:=0;
     outro_destino:='';
     topo:=0;
End;


{ Inicializa Matriz de Voos }
Procedure Seta_Voo(origem:str20;destino:str20;distancia:integer);
Begin
     If (numero_voos < Maximo) then

     Begin
          inc(numero_voos);
          Voo[numero_voos].origem    := origem;
          Voo[numero_voos].destino   := destino;
          Voo[numero_voos].distancia := distancia;
          Voo[numero_voos].aberto    := true;
     end;
End;

{ Inicia Banco de Dados }
Procedure Prepara_Banco;
Begin
     Seta_Voo('NEW YORK','CHICAGO',1000);
     Seta_Voo('CHICAGO','DENVER',1000);
     Seta_Voo('NEW YORK','TORONTO',800);
     Seta_Voo('NEW YORK','DENVER',1900);
     Seta_Voo('TORONTO','CALGARY',1500);
     Seta_Voo('TORONTO','LOS ANGELES',1800);
     Seta_Voo('TORONTO','CHICAGO',500);
     Seta_Voo('DENVER','URBANA',1000);
     Seta_Voo('DENVER','HOUSTON',1500);
     Seta_Voo('HOUSTON','LOS ANGELES',1500);
     Seta_Voo('DENVER','LOS ANGELES',1000);
End;

{ Diz se existe conexao entre as duas cidades, retornando a distancia }
Function Conexao_direta(origem:str20;destino:str20):integer;
Var
   i : word;
Begin
     For i:=1 to numero_voos do
     Begin
          If (Voo[i].origem=origem) and (Voo[i].destino=destino) then
          Begin
             Conexao_direta:=Voo[i].distancia;
             exit;
          End;
     End;
     Conexao_direta:=0;
End;

{ Encontra outro destino de menor custo }
Function Outra_Conexao(origem:str20;var destino:str20):integer;
Var
   acha_voo : word;
   no_voo   : word;
   dist     : integer;
Begin
     acha_voo := 0;
     no_voo   := 0;
     dist     := 10000;

     While (acha_voo < numero_voos) do
     Begin
          If (Voo[acha_voo].origem=origem) and (Voo[acha_voo].aberto) then
             If (Voo[acha_voo].distancia<dist) then
             Begin
                  no_voo := acha_voo;
                  dist   := Voo[acha_voo].distancia;
             End;
          inc(acha_voo);
     End;

     If (no_voo <> 0) then
     Begin
          destino:=Voo[no_voo].destino;
          Voo[no_voo].aberto:=false;
          Outra_Conexao:=Voo[no_voo].distancia;
          exit;
     End;

     Outra_Conexao:=0;
End;


{ Rotinas de Pilha }
{ Coloca no Topo }
Procedure acrescentar(origem:str20;destino:str20;dist:integer);
Begin
     If (topo < Maximo) then
     Begin
          Solucao[topo].origem  := origem;
          Solucao[topo].destino := destino;
          Solucao[topo].dist    := dist;
          inc(topo);
     End
     Else Writeln('Pilha Cheia ');

End;

{ Tira Ultimo }
Procedure Remove(var origem:str20;var destino:str20);
Begin
     If (topo > 0) then
     begin
        dec(topo);
        origem  := Solucao[topo].origem;
        destino := Solucao[topo].destino;
     end
     else Writeln('Pilha Vazia ');

End;

{ Determina se ha uma rota }
Procedure Procura_Rota(origem:str20;destino:str20);
Var
   dist1,dist2:integer;
Begin
     dist1:=Conexao_direta(origem,destino);
     If (dist1<>0) then
     Begin
        acrescentar(origem,destino,dist1);
        exit;
     End;

     dist2:=Outra_Conexao(origem,outro_destino);
     If (dist2<>0) then
     Begin
        acrescentar(origem,destino,dist2);
        Procura_Rota(outro_destino,destino);
     End
     Else if (topo>0) then
     Begin
          Remove(origem,destino);
          Procura_Rota(origem,destino);
     End;
End;

{ Mostra a Rota Conseguida }
Procedure Rota(destino:str20);
Var
   dist : integer;
   i    : word;
Begin
     dist:=0;
     i:=0;
     While (i<topo) do
     Begin
          Writeln('para ',Solucao[i].origem);
          dist:=dist+Solucao[i].dist;
          inc(i);
     End;
     Writeln('destino ',destino);
     Writeln('distancia ',dist);
     readln;
End;

Procedure Apresentacao;
begin
     clrscr;
     Windows(7,7,70,20);
     Escreva(2,1,'Universidade do Sul de Santa Catarina - UNISUL');
     Escreva(2,2,'Trabalho de Inteligˆncia Artificial');
     Escreva(2,3,'Professora: Solange Teresinha Sari');
     Escreva(2,9,'Academicos:');
     Escreva(2,10,'      Lusicler de Souza Molon');
     Escreva(2,11,'      Osmar de Oliveira Braz Junior');

     windows(22,13,52,15);
     Escreva(1,1,'     Busca do Menor Custo');
     Cursor_off;
     Delay(1000);
     windows(16,19,61,21);
     clrscr;
     Escreva(1,1,' Pressione qualquer tecla para continuar');
     readln;
end;

Procedure Fim;
Begin
     Window (1,1,80,25);
     Clrscr;
     windows (15,8,60,16);
     Escreva (5,2,'Academicas');
     Escreva (5,4,'      Lusicler de Souza Molon');
     Escreva (5,5,'      Osmar de Oliveira Braz Junior ');
     beep (1000,100);
     Delay (1000);
     window (1,1,80,25);
     Clrscr;
End;

{ Programa Principal }
Begin
     apresentacao;
     sair := false;
     while sair = false do
       begin
         Window (1,1,80,25);
         clrscr;
         windows(22,2,52,4);
         Escreva(1,1,'     Busca do Menor Custo');
         Windows(6,6,71,21);
         clrscr;
         cursor_on;

         Inicializacao ; { Inicializa Variaveis }
         Prepara_Banco; {Inicia Banco de Dados}

         { Le dados }
         clrscr;
         Write('Origem : ');
         Readln(origem);
         origem := maiscula(origem);

         Write('Destino: ');
         Readln(destino);
         destino := maiscula(destino);

         { Procura a Rota Desejada }
         Procura_Rota(origem,destino);

         { Mostra Solucao }
         Rota(destino);
         windows(22,20,52,22);
         clrscr;
         escreva(1,1,'  Deseja continuar (S/N) ?');
         tecla := readkey;
         if (tecla = 'n') or (tecla = 'N') then
           sair := true;
       end;
   fim;
End.


