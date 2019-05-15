unit U_lexico;
{ UNIVERSIDADE DO SUL DE SANTA CATARINA - UNISUL
  CIENCIAS DA COMPUTACAO - CCP
  COMPILADORES II
  ALUNOS: * JARBAS POSSAMAI
          * JULIANO MORONA
  ULTIMA REVISAO: 15/06/96
  }

interface
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
 str2     = string [2];
 str30    = string [30];
 str20    = string [20];
 str100   = string [100];
 str200   = string [200];
 tk       = record
             nomet : string [40];
             classe: string [30];
             linha : integer;
            end;
 ap_token = ^tokens;
 tokens   = record
             valor  : string [30];
             classe : string [20];
             linha  : integer;
             prox   : ap_token;
            end;
var
 nome_arq               : string [30];
 arq                    : text;
 i                      : integer;
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
 token                  : ap_token;
 t_fim                  : ap_token;
 nr_token               : word;
 opc                    : char;

 {*** empilha todos os tokens encontrados para posterior analise ****}
 Procedure lexico (aux : str30);

 {** Desempilha os tokens previamente empilhados ***}
 Procedure des_token (var aux: tk);

implementation

procedure emp_token (tok :tk);
var
 aux1 : ap_token;
begin
 if nr_token < 1 then
  begin
   new (token);
   token^.valor  := tok.nomet;
   token^.classe := tok.classe;
   token^.linha  := tok.linha;
   token^.prox   := nil;
   inc (nr_token);
   t_fim := token;
  end
 else
  begin
   new (aux1);
   aux1^.valor  := tok.nomet;
   aux1^.classe := tok.classe;
   aux1^.linha  := tok.linha;
   aux1^.prox   := nil;
   t_fim^.prox  := aux1;
   t_fim        := t_fim^.prox;
   inc (nr_token);
  end;
end;

procedure des_token (var aux: tk);
begin
 if nr_token > 0 then
 begin
  aux.nomet  := token^.valor;
  aux.classe := token^.classe;
  aux.linha  := token^.linha;
  token := token^.prox;
  dec (nr_token);
 end
 else if nr_token <= 0 then
  begin
   aux.nomet := '';
   aux.classe := '';
   aux.linha := 0;
  end;
end;

procedure guarda_pal_reservada (res :str30);
var
 aux : tk;
begin
 t_pal_reserv[t_pr]:=res;
 inc(t_pr);
 aux.nomet  := res;
 aux.classe := 'PALAVRA RESERVADA';
 aux.linha  := cont_ln;
 emp_token (AUX);
end;

procedure guarda_literal (lit : str100);
VAR
 aux : tk;
begin
 t_liter[t_l] := lit;
 inc (T_l);
 aux.nomet := lit;
 aux.classe := 'LITERAL';
 aux.linha  := cont_ln;
 emp_token (aux);
end;

procedure guarda_comentario (coment : str200);
begin
 T_coment[t_cm] := coment;
 inc (t_cm);
end;

procedure guarda_simbolo_duplo (simb : str2);
var
 aux : tk;
begin
 t_simb_esp_d[t_sd] := simb;
 inc (t_sd);
 aux.nomet := simb;
 aux.classe := 'SIMBOLO';
 aux.linha  := cont_ln;
 emp_token (aux);
end;

procedure guarda_constante (cons : str30);
var
 aux : tk;
begin
 t_const [t_ct] := cons;
 inc (t_ct);
 aux.nomet := cons;
 aux.classe := 'CONST';
 aux.linha  := cont_ln;
 emp_token (aux);
end;

procedure guarda_identificador (ident : str20);
var
 aux : tk;
begin
 t_ident[t_i] := ident;
 inc(t_i);
 aux.nomet := ident;
 aux.classe := 'IDENT';
 aux.linha  := cont_ln;
 emp_token (aux);
end;

procedure guarda_simbolo (simb : str2);
var
 aux : tk;
begin
 t_simb_esp[t_s] := simb;
 inc (t_s);
 aux.nomet := simb;
 aux.classe := 'SIMBOLO';
 aux.linha  := cont_ln;
 emp_token (aux);
end;

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
 t   : integer;
begin
 if ln <> '' then
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
end;

procedure p_erro (nr : integer);  { Avisa do tipo de erro encontrado}
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
 i   : integer;
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
 i   : integer;
begin
 aux := false;
 i := 1;
 while (not aux) and (i < 30) do
  begin
   if simbolo = simb_esp[i] then aux := true;
   inc (i);
  end;
 simbolo_especial := aux;
end;

procedure comentario (var ln : string); {Analisa para ver se e realmente uma}
 var                                    {linha de comentario}
  i      : integer;
  resto  : integer;
  inicio : integer;
  fim    : integer;
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
              aux := '';
              for i:= inicio to fim do
               aux := aux + ln[i];
              guarda_comentario (aux);
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
              guarda_comentario (copy (ln,inicio,(fim-inicio)));
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
 j,i     : integer;
 palavra : string[100];
 resto   : integer;
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
     guarda_literal (palavra);
     inc(i);
     resto:=(length(aux)-(i));
     if resto <> 0 then
      begin
       aux:=copy(aux,i+1,resto);
       i:=1;
       if resto = 1 then
        if aux[1] = ';' then
         begin
          guarda_simbolo(';');
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

{****** Procedimento para extrair um token e classificalo *******}
procedure retira (var ln : string;var i : integer);
var
 aux   : string;
 j     : integer;
 resto : integer;
begin
 aux := '';
 if i <= 0 then i := 1;
 for j:=1 to i do
  aux:=aux+ln[j];
 if palavra_reservada (aux) then
  begin
   guarda_pal_reservada (aux);
  end
  else
   if constante(aux) then
    begin
     guarda_constante (aux);
   end
   else
    if identificador(aux) then
     begin
      guarda_identificador (aux);
     end
     else
      if simbolo_especial(aux) then
       begin
        i := 0;
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

{*****************Procedimento para distinguir os tokens******************}
procedure analise2(var ln:string);
var
i,j             : integer;
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
                    guarda_pal_reservada ('END');
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
                                guarda_simbolo_duplo ('..');
                                ln[i] := ' ';
                                ln[i-1] := ' ';
                                aux := copy (ln,1,i-2);
                                if constante(aux) then
                                 begin
                                  guarda_constante (aux);
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
                                   guarda_constante (aux);
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
           ' ': begin
                 dec (i);
                 retira (ln,i);
                end;
      '0'..'9': inc(i);
':',',',';','>','<','=','+','-','/','*','[',']','(','{': begin {identifica a cadeia}
          case ln[i] of
'+','-', ';', '=',',','/','*','[',']' : begin
                                         dec (i);
                                         retira (ln,i);
                                         guarda_simbolo (ln[i]);
                                         ln[i] := ' ';
                                         if ln = ' ' then
                                          begin
                                           ln := '';
                                           i := 0;
                                          end;
                                          espaco_esq (ln);
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
                             dec (i);
                             retira (ln,i);
                             guarda_simbolo_duplo ('<=');
                             ln[i] := ' ';
                             ln[i+1] := ' ';
                             espaco_esq (ln);
                            end
                           else
                            if ln[i+1] = '>' then
                             begin
                              dec (i);
                              retira (ln,i);
                              guarda_simbolo_duplo ('<>');
                              ln[i] := ' ';
                              ln[i+1] := ' ';
                              espaco_esq (ln);
                             end
                            else
                             begin
                              dec (i);
                              retira (ln,i);
                              guarda_simbolo ('<');
                              ln[i] := ' ';
                              espaco_esq (ln);
                             end;
                          end;
               '>',':' : begin
                           if ln[i+1] = '=' then
                           begin
                            dec (i);
                            retira (ln,i);
                            guarda_simbolo_duplo (ln[i]+ln[i+1]);
                            ln[i] := ' ';
                            ln[i+1] := ' ';
                            espaco_esq(ln);
                           end
                           else
                           begin
                            dec (i);
                            retira (ln,i);
                            guarda_simbolo (ln[i]);
                            ln[i] := ' ';
                            espaco_esq (ln);
                           end;
                          end;
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

{****************************PROGRAMA PRINCIPAL*****************************}
procedure lexico (aux : str30);
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

 nr_token := 0; {zera a pilha para os tokens}
 linha := '';
 nome_arq := aux;
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
    espaco_esq(linha);
    if (linha <> '$') and (linha <> '%%%') then analisar (linha)
   until (linha='$') or (linha = '%%%');
  end;
 end;
end.