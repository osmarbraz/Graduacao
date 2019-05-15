 program compilador;
{ UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL
  CIENCIAS DA COMPUTACAO - CCP
  COMPILADORES I
  ALUNOS: * JARBAS POSSAMAI
          * JULIANO MORONA
  ULTIMA REVISAO: 26/03/96}

uses crt;
const
 cont_ln : integer = 0;
 T_ct    : byte = 1; { contador de constantes}
 t_i     : byte = 1; { contador de identificadores}
 t_s     : byte = 1; { contador de simbolos especiais}
 t_sd    : byte = 1; { contador de simbolos especiais duplos}
 t_l     : byte = 1; { contador de literais}
 t_cm    : byte = 1; { contador de comentarios}
 t_pr    : byte = 1; { contador de palavras reservadas}
 aspa    : char = #39;
 digito  : set of char=['0'..'9'];
 letras  : set of char=['A'..'Z'];

type
 str2 = string[2];
var
 nome_arq               : string [30];
 arq                    : text;
 i                      : byte;
 linha,linhai           : string;
 pal_reserv             : array [1..100] of string[30];
 simb_esp               : array [1..30] of string[2];
 t_simb_esp             : array [1..100] of string[2];
 t_simb_esp_d           : array [1..100] of string[2];
 t_const                : array [1..100] of string[30];
 t_ident                : array [1..100] of string[20];
 t_liter                : array [1..100] of string[100];
 t_coment               : array [1..100] of string[200];
 t_pal_reserv           : array [1..100] of string[30];
 opc                    : char;

{************* Converte strings para maiusculas ****************}
function Maiusculo (palavra : string):string;
var
 tamanho,i  : integer;
begin
 tamanho := length (palavra);
 for i := 1 to tamanho do
  palavra[i] := upcase(palavra[i]);
 maiusculo := palavra;
end;

function ler_arq : string; {Le uma linha do arquivo sequencialmente}
var
 aux                  : string;
begin
 aux := '';
 if not eof(arq) then
  begin
   readln (arq,aux);
   inc (cont_ln);
  end
 else aux := '%%%'; { %%% -> aponta o fim do arquivo texto}
 ler_arq := aux;
 linhai := aux; {linha completa para mensagem de erro}
end;

procedure espaco_esq(var ln : string);     { Retira todos os espacos ' ' a}
var                                        { esquerda e direita das linhas}
 t   : byte;
begin
 while ln[1] =' ' do
  ln := copy (ln,2,length (ln));
 t := length(ln);
 while ln[t] =' ' do
  begin
   dec (t);
   ln := copy (ln,1,t);
  end;
end;

procedure p_erro (nr : byte);  { Avisa do tipo de erro encontrado}
begin
 textcolor (15);
 case nr of
  1 : begin
         write (#7);
         writeln ('Comando Desconhecido na linha ',cont_ln);
         writeln ('" ',linhai,' "');
        end;
  2 : begin
        write (#7);
        writeln ('Arquivo nao encontrado! => "',nome_arq,'"');
      end;
      else
      begin
       write (#7);
       writeln ('Mensagem de erro nao cadastrada ');
      end;
 end;
 textcolor (7);
end;

function palavra_reservada (palavra : string) : boolean; {verifica se e uma}
var                                                      {palavra reservada}
 aux : boolean;
 i   : byte;
begin
 aux := false;
 i := 1;
 while (not aux) and (i < 100) do
 begin
  if palavra = pal_reserv[i] then aux := true;
  inc (i);
 end;
 palavra_reservada := aux;
 if palavra = '' then palavra_reservada := false;
end;

function simbolo_especial (simbolo : str2) : boolean; { Verifica se e um }
var                                                   { simbolo especial }
 aux : boolean;                                       { da linguagem     }
 i   : byte;
begin
 aux := false;
 i := 1;
 while (not aux) or (i < 30) do
  begin
   if simbolo = simb_esp[i] then aux := true;
   inc (i);
  end;
 simbolo_especial := aux;
end;

procedure comentario (var ln : string); {Analisa para ver se e realmente uma}
 var                                    {linha de comentario}
  i      : byte;
  resto  : integer;
  inicio : byte;
  fim    : byte;
  aux    : string;
begin
 case ln[1] of
  '(' : begin
         if ln[2] = '*' then
          begin
           i := 3;
           inicio := 1;
           while (ln[i] <> '*') and (i <= length(ln)) do
           begin
             inc (i);
           end;
           if ln[i] = '*' then
            if ln[i+1] = ')' then
             begin
              fim := i+1;
              for i:= inicio to fim do
               t_coment[t_cm] := t_coment[t_cm] + ln[i];
              inc (t_cm);
              resto:=(length(ln)-(fim)); {calcula o restante da frase}
              if resto > 0 then
                begin
                 ln:=copy(ln,fim,length(ln));
                 i:=1;
                end
              else
                begin
                 ln:='';
                 i:=1;
                end;
             end
              else
               begin
                p_erro(1);
                halt(0);
               end
               else
                begin
                 p_erro(1);
                 halt(0);
                end;
          end
          else
          begin
           p_erro(1);
           halt(0);
          end;
        end;
  '{' : begin
         i := 2;
         inicio := 2;
          while (ln[i] <> '}') or (i <= length(ln)) do
           begin
             inc (i);
           end;
           if ln[i] = '}' then
             begin
              fim := i-1;
              t_coment[t_cm] := copy (ln,inicio,(fim-inicio));
              inc (t_cm);
             end;
        end;
 end;

end;

{***************funcao para identificar se o token e uma constante***********}
function constante(aux:string):boolean;
var
  erro:integer;
  numero:real;
begin
  val(aux,numero,erro);
  if erro=0 then constante:=true else
     constante:=false;
  if aux='' then constante:= false;
end;

{*************funcao para identificar se o token e um identificador*********}
function identificador(aux:string):boolean;
begin
  if (aux[1] = ' ') or (aux = '') then identificador:=false
  else
  case aux[1] of
     'A'..'Z': identificador:= true;
    else        identificador:= false;
   end;
end;

{***************funcao para identificar se o token e um literal*************}
procedure literal(var aux:string);
var
 j,i     : byte;
 palavra : string[100];
 resto   : byte;
begin
 palavra:= '';
 i:=3;
 palavra:= '';
 if aux[1] = '(' then
  if aux[2] = aspa then
   while (aux[i] <> aspa) and (length(aux) >= i) do
    inc(i);
  if aux[i] = aspa then
   if aux[i+1] = ')' then
    begin
     for j := 1 to i+1 do
      palavra := palavra+aux[j];
     t_liter[t_l] := palavra;
     inc (T_l);
     inc(i);
     resto:=(length(aux)-(i));
     if resto <> 0 then
      begin
       aux:=copy(aux,i+1,resto);
       i:=1;
       if resto = 1 then
        if aux[1] = ';' then
         begin
          t_simb_esp[t_s] := ';';
          inc (t_s);
          aux := '';
          i := 1;
         end;
      end
     else
      begin
       aux:='';
       i:=1;
      end;
    end;
end;

{******* verifica se apos um simbolo especial existe letra ou digito *******}
{******* para detectar erro do tipo: ' a:= 2+;'                       *******}
procedure testa_sintaxe (i : byte;var ln: string);
var
 j      : byte;
 achei  : boolean;
begin
 achei := false;
 j := i+1;
 while j <= length(ln) do
  begin
   if (ln[j] in letras) or (ln[j] in digito) then
    begin
     achei := true;
     j := length(ln) +1;{sai do laco se encontrar letra ou digito}
    end
   else if ln[j] <> ' ' then
    begin
     achei := false;
     j := length(ln) +1;{sai do laco se nao encontrar letra,digito ou ' '}
    end;
   inc(j);
  end;
 if not achei then
  begin
   p_erro (1);
   halt(0);
  end;
end;

{*****************Procedimento para distinguir os tokens******************}
procedure analise2(var ln:string);
var
i,j             : byte;
aux             : string;
erro,inicio     : integer;
ponto,resto     : integer;
numero          : real;
ok              : boolean;

begin
 i:=2;
 ok := false;
 inicio :=1;
 aux:='';
 while (i >=1) and (ln<>'') do
  begin
   if length(ln) < i then
    ln[i] := ' ';
  case ln[i] of
  '.'         : begin
                  aux := copy (ln,inicio,i-1);
                  ponto:=i;
                  inc(i);
                  if aux = 'END' then
                   begin
                    T_pal_reserv [t_pr] := 'END';
                    inc (t_pr);
                    ln:=copy (ln,i,(length(ln)-i));
                    i := 0;
                   end
                  else
                  repeat
                    case ln[i] of
                     '0'..'9': inc(i);
                     'A'..'Z': begin
                                 p_erro(1);
                                 halt(0);
                               end;
                      '.'    : begin
                                t_simb_esp_d[t_sd] := '..';
                                inc (t_sd);
                                ln[i] := ' ';
                                ln[i-1] := ' ';
                                aux := copy (ln,1,i-2);
                                if constante(aux) then
                                 begin
                                  t_const[t_ct] := aux;
                                  inc (t_ct);
                                  for j:=1 to i-2 do
                                   ln[j] := ' ';
                                  espaco_esq (ln);
                                 end;
                               end;
                     else
                      begin
                                aux:=copy(ln,inicio,i-1);
                                if constante(aux) then
                                 begin
                                   aux:=copy(ln,inicio,(i-1));
                                   t_const[t_ct]:=aux;
                                   inc(t_ct);
                                   resto:=(length(ln)-(i-1)); {calcula o restante da frase}
                                   if resto <> 0 then
                                    begin
                                     ln:=copy(ln,i,resto);
                                     espaco_esq(ln);
                                     i:=1;
                                    end
                                   else
                                    begin
                                     ln:='';
                                     i:=0;
                                    end;
                                  end
                                 else
                                  begin
                                   p_erro(1);
                                   halt(0);
                                  end;
                             end;
                       end;
                  until i<=1;
                end;
      'A'..'Z': inc(i);
      '0'..'9': inc(i);
':',',',';',' ','>','<','=','+','-','/','*','[',']','(','{': begin {identifica a cadeia}
                   case ln[i] of
 '+','-', ';', '=',',','/','*','[',']' : begin
                                            t_simb_esp[t_s] := ln[i];
                                            inc (t_s);
                                            ln[i] := ' ';
                                            case t_simb_esp[t_s-1][1] of
                                             '+','-','=','/','*' : testa_sintaxe (i,ln);
                                            end;
                                          end;
       '(','{'  : begin
               if i > 2 then
                if (ln[i] = '(') or (ln[i] = '{') then
                 begin
                  insert (' ',ln,i);
                 end;
               if ln[1] = '(' then
                if ln[2] = '*' then  comentario(ln)
                 else if ln[2] = aspa then literal(ln)
                  else
                   begin
                    P_erro(1);
                    halt(0);
                   end
                   else if ln[i]='{' then comentario(ln);
              end;
                    '<' : begin
                           if ln[i+1] = '=' then
                            begin
                             t_simb_esp_d[t_sd] := '<=';
                             inc (t_sd);
                             ln[i] := ' ';
                             ln[i+1] := ' ';
                             testa_sintaxe(i+1,ln);
                            end
                           else
                            if ln[i+1] = '>' then
                             begin
                              t_simb_esp_d[t_sd] := '<>';
                              inc (t_sd);
                              ln[i] := ' ';
                              ln[i+1] := ' ';
                              testa_sintaxe(i+1,ln);
                             end
                            else
                             begin
                              t_simb_esp[t_s] := '<';
                              inc (t_s);
                              ln[i] := ' ';
                              testa_sintaxe(i,ln);
                             end;
                          end;
               '>',':' : begin
                           if ln[i+1] = '=' then
                           begin
                            t_simb_esp_d[t_sd] := ln[i]+ln[i+1];
                            inc (t_sd);
                            ln[i] := ' ';
                            ln[i+1] := ' ';
                            testa_sintaxe(i+1,ln);
                           end
                           else
                           begin
                            t_simb_esp[t_s] := ln[i];
                            inc (t_s);
                            ln[i] := ' ';
                            testa_sintaxe(i,ln);
                           end;
                          end;
                   end;
                  aux := '';
                  for j:=1 to i-1 do
                    aux:=aux+ln[j];
                  if palavra_reservada(aux) then
                      begin
                         t_pal_reserv[t_pr]:=aux;
                         inc(t_pr);
                      end
                  else
                   if constante(aux) then
                      begin
                        t_const[t_ct]:=aux;
                        inc(t_ct);
                      end
                  else
                   if identificador(aux) then
                      begin
                        t_ident[t_i]:=aux;
                        inc(t_i);
                      end
                  else
                   if aux <> '' then
                      begin
                         p_erro(1);
                         halt(0);
                      end;
                      resto:=(length(ln)-(i)); {calcula o restante da frase}
                      if resto > 0 then
                        begin
                          ln:=copy(ln,i+1,length(ln));
                          espaco_esq (ln);
                          i:=1;
                        end
                      else
                        begin
                          ln:='';
                          i:=0;
                        end;

                end;
         else
          begin
           p_erro(1);
           halt(0);
          end;
        end;
  end;
end;

{*****************Procedimento para a 1a analise do token**************}
procedure analisar (var ln : string); { Analisa as linhas do programa a ser}
                                      { compilado                          }
begin
  case ln[1] of
   'A'..'Z','0'..'9' : analise2(ln);
   '(','{'  : begin
               if ln[1] = '(' then
                if ln[2] = '*' then  comentario(ln);
               if ln[1] = '(' then
                if ln[2] = aspa then literal(ln);
              end;
  else
   begin
    p_erro(1);
    Writeln ('Programa Abortado');
    ReadLn;
    halt(0);
   end;
  end;
end;

{********************** Lista as constantes encontradas ********************}
procedure l_const;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DAS CONSTANTES ENCONTRADAS:');
 repeat
  writeln (i,' -> ',T_const [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_ct;
 readln;
end;

{********************** Lista os identificadores encontrados ********************}
procedure l_IDENT;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DOS IDENTIFICADORES ENCONTRADOS:');
 repeat
  writeln (i,' -> ',T_ident [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_i;
 readln;
end;

{*************** Lista os simbolos especiais simples encontrados **********}
procedure l_SIMB;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DOS SIMBOLOS ESPECIAIS SIMPLES ENCONTRADOS:');
 repeat
  writeln (i,' -> ',T_simb_esp [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_s;
 readln;
end;

{*************** Lista os simbolos especiais duplos encontrados ************}
procedure l_SIMB_D;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DOS SIMBOLOS ESPECIAIS DUPLOS ENCONTRADOS:');
 repeat
  writeln (i,' -> ',T_simb_esp_d [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_sd;
 readln;
end;

{********************** Lista os literais encontrados ********************}
procedure l_liter;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DOS LITERAIS ENCONTRADOS:');
 repeat
  writeln (i,' -> ',T_liter [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_l;
 readln;
end;

{********************** Lista os comentarios encontrados ********************}
procedure l_coment;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DOS COMENTARIOS ENCONTRADOS:');
 repeat
  writeln (i,' -> ',T_coment [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_cm;
 readln;
end;

{**************** Lista as palavras reservadas encontradas ******************}
procedure l_palavr;
var
 i,i2    : byte;
begin
 clrscr;
 i := 1;
 i2 := 1;
 writeln ('LISTA DAS PALAVRAS RESERVADAS ENCONTRADAS:');
 repeat
  writeln (i,' -> ',T_pal_reserv [i]);
  inc (i);
  inc (i2);
  if i2 >=23 then
  begin
   i2 := 1;
   writeln ('PRESSIONE <ENTER> PARA CONTINUAR');
   readln;
  end;
 until i >= t_pr;
 readln;
end;

{****************************PROGRAMA PRINCIPAL*****************************}

begin
 {********** Zerar todas os arrays ***********}
 for i:=1 to 100 do
  t_const[i] := '';
 for i:=1 to 100 do
  t_liter[i] := '';
 for i:=1 to 100 do
  t_coment[i] := '';
 for i:=1 to 100 do
  t_simb_esp[i] := '';
 for i:=1 to 100 do
  t_const[i] := '';
 for i:=1 to 100 do
  t_ident[i] := '';
 for i:=1 to 100 do
  t_pal_reserv[i] := '';
 for i:=1 to 100 do
  t_simb_esp_d[i] := '';

{********* Carregar as palavras reservadas do pascal ************}
 pal_reserv[1] := 'PROGRAM';
 pal_reserv[2] := 'VAR';
 pal_reserv[3] := 'INTEGER';
 pal_reserv[4] := 'REAL';
 pal_reserv[5] := 'STRING';
 pal_reserv[6] := 'CHAR';
 pal_reserv[7] := 'ARRAY';
 pal_reserv[8] := 'RECORD';
 pal_reserv[9] := 'BYTE';
 pal_reserv[10] := 'IF';
 pal_reserv[11] := 'THEN';
 pal_reserv[12] := 'BEGIN';
 pal_reserv[13] := 'END';
 pal_reserv[14] := 'ELSE';
 pal_reserv[15] := 'DO';
 pal_reserv[16] := 'OF';
 pal_reserv[17] := 'OR';
 pal_reserv[18] := 'NOT';
 pal_reserv[19] := 'WRITE';
 pal_reserv[20] := 'WRITELN';
 pal_reserv[21] := 'READ';
 pal_reserv[22] := 'READLN';
 pal_reserv[23] := 'CASE';
 pal_reserv[24] := 'FUNCTION';
 pal_reserv[25] := 'PROCEDURE';
 pal_reserv[26] := 'CONST';
 pal_reserv[27] := 'USES';
 pal_reserv[28] := 'WHILE';
 pal_reserv[29] := 'REPEAT';
 pal_reserv[30] := 'FOR';
 pal_reserv[31] := 'TO';
 pal_reserv[32] := '';
 pal_reserv[33] := '';
 pal_reserv[34] := '';
 pal_reserv[35] := '';
 pal_reserv[36] := '';
 pal_reserv[37] := '';
 pal_reserv[38] := '';
 pal_reserv[39] := '';
 pal_reserv[40] := '';

 {*********** Carrega os simbolos especiais do Pascal *************}
 simb_esp [1] := '=';
 simb_esp [2] := '<';
 simb_esp [3] := '<=';
 simb_esp [4] := '<>';
 simb_esp [5] := '>';
 simb_esp [6] := '>=';
 simb_esp [7] := '+';
 simb_esp [8] := '-';
 simb_esp [9] := '/';
 simb_esp [10] := '*';
 simb_esp [11] := ',';
 simb_esp [12] := ';';
 simb_esp [13] := '.';
 simb_esp [14] := ':';
 simb_esp [15] := '..';
 simb_esp [16] := ':=';
 simb_esp [17] := '';
 simb_esp [18] := '';
 simb_esp [19] := '';
 simb_esp [20] := '';

 linha := '';
 writeln;
 write ('Nome do arquivo a ser compilado : ');
 readln (nome_arq);
 assign (arq,nome_arq);
 {$I-}
 reset (arq);
 {$I+}
 if ioresult <> 0 then
  begin
   p_erro(2);
  end
 else
  begin
   repeat
    if linha = '' then linha := ler_arq;
    linha := maiusculo (linha);
    writeln(linha);
    delay (50);
    espaco_esq(linha);
    if (linha <> '$') and (linha <> '%%%') then analisar (linha)
   until (linha='$') or (linha = '%%%');

   {******** Menu para listagem dos tokens ***********}
   repeat
    clrscr;
    gotoxy (30,2);
    write ('MENU DE OPCOES');
    gotoxy (10,4);
    write ('1 - CONSTANTES');
    gotoxy (10,5);
    write ('2 - SIMBOLOS ESPECIAIS SIMPLES');
    gotoxy (10,6);
    write ('3 - SIMBOLOS ESPECIAIS DUPLOS');
    gotoxy (10,7);
    write ('4 - LITERAIS');
    gotoxy (10,8);
    write ('5 - IDENTIFICADORES');
    gotoxy (10,9);
    write ('6 - COMENTARIOS');
    gotoxy (10,10);
    write ('7 - PALAVRAS RESERVADAS');
    gotoxy (10,11);
    write ('8 - TERMINAR');
    GOTOXY (8,13);
    write ('DIGITE A OPCAO DESEJADA => ');
    READln (opc);
    case opc of
     '1' : l_const;
     '2' : l_simb;
     '3' : l_SIMB_d;
     '4' : l_liter;
     '5' : l_ident;
     '6' : l_coment;
     '7' : l_palavr;
    end;
   until opc='8';
  end;
end.