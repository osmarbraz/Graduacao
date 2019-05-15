
(***************************** PROGRAMA *************************************)
Program Analisa;
uses crt,ustr;
const
  asterisco= chr(42); { 39 '} {42 *}
  aspa     = chr(39);
  branco   = chr(32);
  letra    : set of char = ['A'..'Z','a'..'z'];
  numero   : set of char = ['0'..'9'];
  simbolo  : set of char = ['=' , '<' , '>' , '+' , '-' , '/'
                            ,'*' , ',' , ';' , '.' , ':', '[', ']', '$' ];

  NUM = 75; (* Numero de Elemento das Tablelas do Carregador *)


Type
  ALFA = record
            NOME   : String;
            CLASSE : String;
         end;
  str200 = string[200];
  Str1 = String[1];
  Str50 = String[50];
  RTABSINT = Record
               TIPO      : str1;
               NOMETS    : str50;
               NUMNO     : Integer;
               ALTTS     : Integer;
               SUCTS     : Integer;
             End;

  RTABGRAFO = Record
                TER     : Boolean;
                SIM     : Integer;
                ALTTG   : Integer;
                SUCTG   : Integer;
              End;

  RTABT    = Record
               NOMET   : str50;
             End;
  RTABNT   = Record
               NOMENT  : str50;
               PRIM    : Integer;
             End;

Var

 vet_linha           :array[1..50] of str200;
 nome_arq               : string [30];
 arq                    : text;
 cont_ln              : byte;
 aux                  : string;
  TABSINT                       : Array [1..NUM] of RTABSINT;
  TABGRAFO                      : Array [1..NUM] of RTABGRAFO;
  TABT                          : Array [1..NUM] of RTABT;
  TABNT                         : Array [1..NUM] of RTABNT;
  MAXT, MAXNT, INDPRIM, NOMAX, INDTS, J, I, E,OS, MA  : Integer;
  com, lit                                 : integer;
  ultima, pos, cao, ErroSint,totaldelinhas : integer;
  tamanholinha,x,codigoreservada,Y, Objt, Topo, Index : integer;
  tem, Continue, Sucesso, Denovo           : Boolean;
  linha                                    : str200;
  reservada                                : array[1..150] of string[12];
  token, lin                               : string;
  K                                        : Array [1..60] of Integer;
  ENT                                      : ALFA;  (* Proximo simbolo de entrada *)
  Comentario                               : Array [1..20] of Record
                                                               Comenta : String[80];
                                                               Linha   : integer;
                                                              end;
  Literal                                  : Array [1..20] of Record
                                                               Litera : String[80];
                                                               Linha  : integer;
                                                              end;
{******************** Analisador Lexico ***************************************}
{**************** Procedure Verifica*******************************************}
procedure verifica(Linha:str200; tamanholinha: integer; var y:integer);
var
  mensagem : string;

label est0, est1, est2, est3, est4, est41, est42, est5, est6, erro;
var
  contaponto                    : byte;
  j                             : integer;

begin
    codigoreservada := 103;
    contaponto := 0;
    token:='';
(***************************** ESTADO 0 ***************************************)
    est0: if (linha[y] = BRANCO) then
              begin
                inc(y);
                goto est0;
              end
          else
            begin
               if (linha[y] in LETRA) then
                  goto est1
               else
                  if (linha[y] in NUMERO) then
                     goto est2
                  else
                     if (linha[y] in SIMBOLO) then
                        goto est3
                     else
                        if (linha[y] = '(') then
                           begin
                             if (linha[y+1] = '*') then
                                begin
                                  token := token + linha[Y];
                                  inc(Y);
                                  goto est5;
                                end;
                             token := token + linha[Y];
                             goto est4;
                           end;

               mensagem := 'NÃO RECONHECIDO';
               codigoreservada := 103;
               token := token + linha[Y];
               inc(y);
               goto erro;
            end;

(*********************** ESTADO 1 - IDENTIFICADOR *****************************)
     est1: token := token + linha[Y];
           inc(y);
           if (Y <= tamanholinha) then
              if (linha[y] in letra) then
                 goto est1
              else
                 if (linha[y] in numero) then
                    goto est1;
           codigoreservada := 100;
           mensagem := 'IDENTIFICADOR'; { ENCONTRA IDENTIFICADOR }
           for J:=1 to 50 do
               if (TOKEN = reservada[j]) then { ENCONTRA RESERVADA }
                  begin
                    mensagem := 'PALAVRA RESERVADA';
                    codigoreservada:=j;
                    j:=50;
                  end;
           goto est6;                  { DESVIA PARA O FIM}

(************************* ESTADO 2 - CONSTANTE *******************************)
     est2 : TOKEN := TOKEN + LINHA[Y];
            inc(Y);
            if (y <= tamanholinha) then
               if (linha[y] in numero) then
                  goto est2
               else
                 if (linha[y] = '.') then
                    if (contaponto < 1) then
                       if (linha[y+1] <> '.') then
                          begin
                            contaponto := contaponto + 1;
                            goto est2;
                          end;
           codigoreservada := 101;
           mensagem := 'CONSTANTE';  { ENCONTRA UMA CONSTANTE }
           goto est6;                { DESVIA PARA O FIM}

(************************* ESTADO 3 - SIMBOLO ESPECIAL*************************)
     est3 : token := token + linha[Y];
            if (y <= tamanholinha) then
               inc(y);
            if ((token = ':') and (linha[y] = '=')) then
               begin
                 token := token + linha[Y];
                 inc(Y);
               end
            else
              if ((token = '<') and (linha[y] = '>')) then
                 begin
                   token := token + linha[Y];
                   inc(Y);
                 end
              else
                if ((token = '<') and (linha[y] = '=')) then
                  begin
                    token := token + linha[Y];
                    inc(Y);
                  end
                else
                  if ((token = '>') and (linha[y] = '=')) then
                    begin
                      token := token + linha[Y];
                      inc(Y);
                    end
                  else
                    if ((token = '.') and (linha[y] = '.')) then
                       begin
                         token := token + linha[Y];
                         inc(Y);
                       end;
            For j := 51 to 72 do
              if (token = reservada[j]) then
                 begin
                    mensagem := 'SIMBOLO ESPECIAL'; { ENCONTRA SIMBOLO }
                    codigoreservada := J;
                    J := 72;
                    goto est6;                      { DESVIA PARA O FIM}
                 end;
            goto est6;

(************************** ESTADO 4 - LITERAL ********************************)
     est4 : inc(y);
            if (y <= tamanholinha) then
               if (linha[y] = branco) then
                  goto est4
               else
                 if (linha[y] = aspa) then
                    goto est41
                 else
                    begin
                      mensagem := 'ESPERANDO ASPA OU *';
                      goto erro;
                    end
            else
              begin
                mensagem := 'LINHA MUITO GRANDE';
                goto erro;
              end;

     est41:token := token + linha[Y];
           inc(y);
           if (y <= tamanholinha) then
              if (linha[y] <> aspa) then
                 goto est41
              else
                begin
                  token := token + linha[Y];
                  goto est42;
                end
           else
              begin
                mensagem := 'LINHA MUITO GRANDE';
                goto erro;
              end;

     est42:inc(y);
           if (y <= tamanholinha) then
              if (linha[y] = branco) then
                 goto est42
              else
                 if (linha[y] = ')') then
                    begin
                      token := token + linha[Y];
                      inc(y);
                      codigoreservada := 105;
                      mensagem := 'LITERAL';
                      goto est6;
                    end
                 else
                    begin
                      mensagem := 'ESPERANDO )';
                      goto erro
                    end
           else
             begin
                mensagem := 'LINHA MUITO GRANDE';
                goto erro;
              end;

(********************** ESTADO 5 - COMENTARIO *********************************)
     est5: token := token + linha[Y];
           inc(Y);
           if (y <= tamanholinha) then
              if (linha[Y] <> '*') then
                 goto est5
              else
                begin
                  token := token + linha[Y];
                  inc(Y);
                  if (linha[Y] = ')') then
                     begin
                       token := token + linha[Y];
                       inc(Y);
                       mensagem := 'COMENTARIO';
                       codigoreservada := 104;
                       goto est6;
                     end
                  else
                     begin
                       mensagem := 'ESPERANDO )';
                       goto erro;
                     end;
                end
           else
             begin
                mensagem := 'LINHA MUITO GRANDE';
                goto erro;
             end;

{**************************** ERRO ********************************************}
     ERRO: goto est6;

{****************************** FIM *******************************************}
     est6: dec(y);
           Writeln(token+'    '+ mensagem+' => '+inttostr(codigoreservada));

end;


function Maiusculo (palavra : string):string;
var
 tamanho,i  : integer;
begin
 tamanho := length (palavra);
 for i := 1 to tamanho do
  palavra[i] := upcase(palavra[i]);
 maiusculo := palavra;
end;

{--------------------------LEITURA DE LINHAS-------------------------------}

function ler_arq : string; {Le uma linha do arquivo sequencialmente}
var
 linhai               : string;
begin
 cont_ln:=1;
 aux := '';
 while not eof(arq) do
  begin
   readln (arq,aux);
   vet_linha[cont_ln]:=maiusculo(aux);
   inc (cont_ln);
  end;
 if not eof(arq) then aux := '%%%'; { %%% -> aponta o fim do arquivo texto}

{ ler_arq := MAIUSCULO(aux);
 linhai := aux; {linha completa para mensagem de erro}
end;


{************* Procedure Analex ***********************************************}
Procedure AnaLex;
Var
  ultima, pos     : integer;
  Certo           : boolean;

Begin{1}
  ent.nome := '';
  ent.classe := '';

  certo := false;
  while certo = false do
    begin {2}
      linha := vet_linha[os];
      tamanholinha :=length(linha); {Conta o numero de caracteres da linha}
      For pos := 1 to tamanholinha do { Pega o tamanho da linha se os espacos finais }
        if linha[pos] <> ' ' then
           begin{3}
             ultima := pos; (* marca a posicao do ultimo elemento da linha *)
             certo := true;
           end;{3}
{      if ma> tamanholinha then
         certo := false;}
      tamanholinha := ultima;
      if certo = false then (* incrementa para uma nova linha *)
         inc(os)
    end; {2}
    if (MA <= tamanholinha) and (os <=totaldelinhas ) then
       begin {4}
         verifica(linha,tamanholinha,MA);
         ent.nome := Token; (* Atribui o Token *)
         ent.Classe := Reservada[codigoReservada]; (* Atribui a Classe *)
         Inc(ma); (* Incrementa para  proxima posicao na linha *)
       end {4}
    else
      begin {5}
        inc(os); (* incrementa para uma nova linha *)
        if os > totaldelinhas  then
           begin {6}
             ent.nome := '$';
             ent.classe := '$';
           end {6}
        Else
          begin {7}
            ma := 1;
            certo := false;
            while certo= false do
              begin{8}
                linha := aux;
                linha := vet_linha[os];
                tamanholinha :=length(linha); {Conta o numero de caracteres da linha}
                For pos := 1 to tamanholinha do { Pega o tamanho da linha se os espacos finais }
                   if linha[pos] <> ' ' then
                     begin{9}
                       ultima := pos;(* marca a posicao do ultimo elemento da linha *)
                       certo := true;
                     end;{9}
                tamanholinha := ultima;
                if certo = false then
                  inc(os);(* incrementa para uma nova linha *)
              end;{8}
            if (MA <= tamanholinha) and (os <= totaldelinhas ) then
               begin{10}
                 verifica(linha,tamanholinha,MA);
                 ent.nome := Token;  (* Atribui o Token *)
                 ent.Classe := Reservada[codigoReservada];(* Atribui a Classe *)
                 inc(ma); (* Incrementa para  proxima posicao na linha *)
               end;{10}
          End;{7}
      end;{5}
end;{1}

(******************* Analisador Sintatico****************************************)
Procedure TrataErro1; (*Tratamento de Erro Sintático*)
Begin
  Writeln('******************** Erro !!!!!  **************');
  Writeln('  Erro na linha Linha - '+ inttostr(os+1) + ' Coluna - '+ inttostr(ma));
  Writeln('  Esperando - '+ TABT[TABGRAFO[INDEX].SIM].NOMET);
End;

Procedure TrataErro2; (*Tratamento de Erro de Pilha*)
Begin
  Writeln('******************** Erro !!!!!  **************');
  Writeln('  Erro na linha Linha - '+ inttostr(os+1) + ' Coluna - '+ inttostr(ma));
  Writeln('  Esta Sobrando Simbolos !!!! ');
End;

Procedure EMPILHA (P : Integer);
Begin
  TOPO := TOPO + 1;
  K[TOPO] := P;
End;

Function DESEMPILHA:integer;
Begin
  DESEMPILHA := K[TOPO];
  TOPO := TOPO - 1;
End;

(********************* Carreagador Sintático **********************************)
(**********Function Verifica se Esta na TABNT *******************)
Function EncontraNaTABNT (NOME : Str50) : Boolean;
Var
   AUX_INDNT : Integer;
   CHAVE     : Boolean;
Begin
  Chave := false;
  AUX_INDNT := 1;
  While TABNT[AUX_INDNT].NOMENT <> '' Do
    Begin
      If TABNT[AUX_INDNT].NOMENT = NOME Then
         Chave := True;
      Inc(AUX_INDNT);
    End;
  EncontraNaTABNT := Chave;
End;

(**********Function Verifica se Esta na TABT *******************)
Function EncontraNaTABT (NOME : Str50) : Boolean;
Var
   AUX_INDT : Integer;
   CHAVE    : Boolean;
Begin
  Chave := false;
  AUX_INDT := 1;
  While TABT[AUX_INDT].NOMET <> '' Do
    Begin
      If TABT[AUX_INDT].NOMET = NOME Then
         Chave := True;
      Inc(AUX_INDT);
    End;
  EncontraNaTABT := Chave;
End;

procedure Carrega;
begin

(************ Dados da Matriz TABSINT **************************)
  TABSINT[1].TIPO   := 'C';
  TABSINT[1].NOMETS := 'PROGRAMA';
  TABSINT[1].NUMNO  := -1;
  TABSINT[1].ALTTS  := -1;
  TABSINT[1].SUCTS  := -1;

  TABSINT[2].TIPO   := 'T';
  TABSINT[2].NOMETS := 'PROGRAM';
  TABSINT[2].NUMNO  := 1;
  TABSINT[2].ALTTS  := 0;
  TABSINT[2].SUCTS  := 2;

  TABSINT[3].TIPO   := 'T';
  TABSINT[3].NOMETS := 'IDENT';
  TABSINT[3].NUMNO  := 2;
  TABSINT[3].ALTTS  := 0;
  TABSINT[3].SUCTS  := 3;

  TABSINT[4].TIPO   := 'T';
  TABSINT[4].NOMETS := ';';
  TABSINT[4].NUMNO  := 3;
  TABSINT[4].ALTTS  := 0;
  TABSINT[4].SUCTS  := 4;

  TABSINT[5].TIPO   := 'N';
  TABSINT[5].NOMETS := 'BLOCO';
  TABSINT[5].NUMNO  := 4;
  TABSINT[5].ALTTS  := 0;
  TABSINT[5].SUCTS  := 5;

  TABSINT[6].TIPO   := 'T';
  TABSINT[6].NOMETS := '.';
  TABSINT[6].NUMNO  := 5;
  TABSINT[6].ALTTS  := 0;
  TABSINT[6].SUCTS  := 6;

  TABSINT[7].TIPO   := 'T';
  TABSINT[7].NOMETS := '$';(* FINAL DO ARQUIVO *)
  TABSINT[7].NUMNO  := 6;
  TABSINT[7].ALTTS  := 0;
  TABSINT[7].SUCTS  := 0;

  TABSINT[8].TIPO   := 'C';
  TABSINT[8].NOMETS := 'BLOCO';
  TABSINT[8].NUMNO  := -1;
  TABSINT[8].ALTTS  := -1;
  TABSINT[8].SUCTS  := -1;

  TABSINT[9].TIPO   := 'T';
  TABSINT[9].NOMETS := 'VAR';
  TABSINT[9].NUMNO  := 1;
  TABSINT[9].ALTTS  := 0;
  TABSINT[9].SUCTS  := 2;

  TABSINT[10].TIPO   := 'T';
  TABSINT[10].NOMETS := 'IDENT';
  TABSINT[10].NUMNO  := 2;
  TABSINT[10].ALTTS  := 0;
  TABSINT[10].SUCTS  := 3;

  TABSINT[11].TIPO   := 'T';
  TABSINT[11].NOMETS := ':';
  TABSINT[11].NUMNO  := 3;
  TABSINT[11].ALTTS  := 4;
  TABSINT[11].SUCTS  := 5;

  TABSINT[12].TIPO   := 'T';
  TABSINT[12].NOMETS := ',';
  TABSINT[12].NUMNO  := 4;
  TABSINT[12].ALTTS  := 0;
  TABSINT[12].SUCTS  := 2;

  TABSINT[13].TIPO   := 'T';
  TABSINT[13].NOMETS := 'INTEGER';
  TABSINT[13].NUMNO  := 5;
  TABSINT[13].ALTTS  := 0;
  TABSINT[13].SUCTS  := 6;

  TABSINT[14].TIPO   := 'T';
  TABSINT[14].NOMETS := ';';
  TABSINT[14].NUMNO  := 6;
  TABSINT[14].ALTTS  := 0;
  TABSINT[14].SUCTS  := 7;

  TABSINT[15].TIPO   := 'T';
  TABSINT[15].NOMETS := 'BEGIN';
  TABSINT[15].NUMNO  := 7;
  TABSINT[15].ALTTS  := 0;
  TABSINT[15].SUCTS  := 8;

  TABSINT[16].TIPO   := 'N';
  TABSINT[16].NOMETS := 'COMANDO';
  TABSINT[16].NUMNO  := 8;
  TABSINT[16].ALTTS  := 0;
  TABSINT[16].SUCTS  := 9;

  TABSINT[17].TIPO   := 'T';
  TABSINT[17].NOMETS := 'END';
  TABSINT[17].NUMNO  := 9;
  TABSINT[17].ALTTS  := 10;
  TABSINT[17].SUCTS  := 11;

  TABSINT[18].TIPO   := 'T';
  TABSINT[18].NOMETS := ';';
  TABSINT[18].NUMNO  := 10;
  TABSINT[18].ALTTS  := 0;
  TABSINT[18].SUCTS  := 8;

  TABSINT[19].TIPO   := 'T';
  TABSINT[19].NOMETS := '$';
  TABSINT[19].NUMNO  := 11;
  TABSINT[19].ALTTS  := 0;
  TABSINT[19].SUCTS  := 0;

  TABSINT[20].TIPO   := 'C';
  TABSINT[20].NOMETS := 'COMANDO';
  TABSINT[20].NUMNO  := -1;
  TABSINT[20].ALTTS  := -1;
  TABSINT[20].SUCTS  := -1;

  TABSINT[21].TIPO   := 'T';
  TABSINT[21].NOMETS := 'BEGIN';
  TABSINT[21].NUMNO  := 1;
  TABSINT[21].ALTTS  := 6;
  TABSINT[21].SUCTS  := 2;

  TABSINT[22].TIPO   := 'N';
  TABSINT[22].NOMETS := 'COMANDO';
  TABSINT[22].NUMNO  := 2;
  TABSINT[22].ALTTS  := 0;
  TABSINT[22].SUCTS  := 3;

  TABSINT[23].TIPO   := 'T';
  TABSINT[23].NOMETS := ';';
  TABSINT[23].NUMNO  := 3;
  TABSINT[23].ALTTS  := 4;
  TABSINT[23].SUCTS  := 2;

  TABSINT[24].TIPO   := 'T';
  TABSINT[24].NOMETS := 'END';
  TABSINT[24].NUMNO  := 4;
  TABSINT[24].ALTTS  := 0;
  TABSINT[24].SUCTS  := 5;

  TABSINT[25].TIPO   := 'T';
  TABSINT[25].NOMETS := ';';
  TABSINT[25].NUMNO  := 5;
  TABSINT[25].ALTTS  := 25;
  TABSINT[25].SUCTS  := 25;

  TABSINT[26].TIPO   := 'T';
  TABSINT[26].NOMETS := 'IF';
  TABSINT[26].NUMNO  := 6;
  TABSINT[26].ALTTS  := 12;
  TABSINT[26].SUCTS  := 7;

  TABSINT[27].TIPO   := 'N';
  TABSINT[27].NOMETS := 'EXPRESSAO';
  TABSINT[27].NUMNO  := 7;
  TABSINT[27].ALTTS  := 0;
  TABSINT[27].SUCTS  := 8;

  TABSINT[28].TIPO   := 'T';
  TABSINT[28].NOMETS := 'THEN';
  TABSINT[28].NUMNO  := 8;
  TABSINT[28].ALTTS  := 0;
  TABSINT[28].SUCTS  := 9;

  TABSINT[29].TIPO   := 'N';
  TABSINT[29].NOMETS := 'COMANDO';
  TABSINT[29].NUMNO  := 9;
  TABSINT[29].ALTTS  := 0;
  TABSINT[29].SUCTS  := 10;

  TABSINT[30].TIPO   := 'T';
  TABSINT[30].NOMETS := 'ELSE';
  TABSINT[30].NUMNO  := 10;
  TABSINT[30].ALTTS  := 25;
  TABSINT[30].SUCTS  := 11;

  TABSINT[31].TIPO   := 'N';
  TABSINT[31].NOMETS := 'COMANDO';
  TABSINT[31].NUMNO  := 11;
  TABSINT[31].ALTTS  := 0;
  TABSINT[31].SUCTS  := 25;

  TABSINT[32].TIPO   := 'T';
  TABSINT[32].NOMETS := 'WHILE';
  TABSINT[32].NUMNO  := 12;
  TABSINT[32].ALTTS  := 16;
  TABSINT[32].SUCTS  := 13;

  TABSINT[33].TIPO   := 'N';
  TABSINT[33].NOMETS := 'EXPRESSAO';
  TABSINT[33].NUMNO  := 13;
  TABSINT[33].ALTTS  := 0;
  TABSINT[33].SUCTS  := 14;

  TABSINT[34].TIPO   := 'T';
  TABSINT[34].NOMETS := 'DO';
  TABSINT[34].NUMNO  := 14;
  TABSINT[34].ALTTS  := 0;
  TABSINT[34].SUCTS  := 15;

  TABSINT[35].TIPO   := 'N';
  TABSINT[35].NOMETS := 'COMANDO';
  TABSINT[35].NUMNO  := 15;
  TABSINT[35].ALTTS  := 0;
  TABSINT[35].SUCTS  := 25;

  TABSINT[36].TIPO   := 'T';
  TABSINT[36].NOMETS := 'FOR';
  TABSINT[36].NUMNO  := 16;
  TABSINT[36].ALTTS  := 24;
  TABSINT[36].SUCTS  := 17;

  TABSINT[37].TIPO   := 'T';
  TABSINT[37].NOMETS := 'IDENT';
  TABSINT[37].NUMNO  := 17;
  TABSINT[37].ALTTS  := 0;
  TABSINT[37].SUCTS  := 18;

  TABSINT[38].TIPO   := 'T';
  TABSINT[38].NOMETS := ':=';
  TABSINT[38].NUMNO  := 18;
  TABSINT[38].ALTTS  := 0;
  TABSINT[38].SUCTS  := 19;

  TABSINT[39].TIPO   := 'N';
  TABSINT[39].NOMETS := 'EXPRESSAO';
  TABSINT[39].NUMNO  := 19;
  TABSINT[39].ALTTS  := 0;
  TABSINT[39].SUCTS  := 20;

  TABSINT[40].TIPO   := 'T';
  TABSINT[40].NOMETS := 'TO';
  TABSINT[40].NUMNO  := 20;
  TABSINT[40].ALTTS  := 0;
  TABSINT[40].SUCTS  := 21;

  TABSINT[41].TIPO   := 'N';
  TABSINT[41].NOMETS := 'EXPRESSAO';
  TABSINT[41].NUMNO  := 21;
  TABSINT[41].ALTTS  := 0;
  TABSINT[41].SUCTS  := 22;

  TABSINT[42].TIPO   := 'T';
  TABSINT[42].NOMETS := 'DO';
  TABSINT[42].NUMNO  := 22;
  TABSINT[42].ALTTS  := 0;
  TABSINT[42].SUCTS  := 23;

  TABSINT[43].TIPO   := 'N';
  TABSINT[43].NOMETS := 'COMANDO';
  TABSINT[43].NUMNO  := 23;
  TABSINT[43].ALTTS  := 0;
  TABSINT[43].SUCTS  := 25;

  TABSINT[44].TIPO   := 'N';
  TABSINT[44].NOMETS := 'EXPRESSAO';
  TABSINT[44].NUMNO  := 24;
  TABSINT[44].ALTTS  := 0;
  TABSINT[44].SUCTS  := 25;

  TABSINT[45].TIPO   := 'T';
  TABSINT[45].NOMETS := '$';
  TABSINT[45].NUMNO  := 25;
  TABSINT[45].ALTTS  := 0;
  TABSINT[45].SUCTS  := 0;

  TABSINT[46].TIPO   := 'C';
  TABSINT[46].NOMETS := 'EXPRESSAO';
  TABSINT[46].NUMNO  := -1;
  TABSINT[46].ALTTS  := -1;
  TABSINT[46].SUCTS  := -1;

  TABSINT[47].TIPO   := 'N';
  TABSINT[47].NOMETS := 'EXP_SIMP';
  TABSINT[47].NUMNO  := 1;
  TABSINT[47].ALTTS  := 0;
  TABSINT[47].SUCTS  := 2;

  TABSINT[48].TIPO   := 'T';
  TABSINT[48].NOMETS := ':=';
  TABSINT[48].NUMNO  := 2;
  TABSINT[48].ALTTS  := 3;
  TABSINT[48].SUCTS  := 7;

  TABSINT[49].TIPO   := 'T';
  TABSINT[49].NOMETS := '=';
  TABSINT[49].NUMNO  := 3;
  TABSINT[49].ALTTS  := 4;
  TABSINT[49].SUCTS  := 7;

  TABSINT[50].TIPO   := 'T';
  TABSINT[50].NOMETS := '<';
  TABSINT[50].NUMNO  := 4;
  TABSINT[50].ALTTS  := 5;
  TABSINT[50].SUCTS  := 7;

  TABSINT[51].TIPO   := 'T';
  TABSINT[51].NOMETS := '>';
  TABSINT[51].NUMNO  := 5;
  TABSINT[51].ALTTS  := 6;
  TABSINT[51].SUCTS  := 7;

  TABSINT[52].TIPO   := 'T';
  TABSINT[52].NOMETS := '<>';
  TABSINT[52].NUMNO  := 6;
  TABSINT[52].ALTTS  := 7;
  TABSINT[52].SUCTS  := 7;

  TABSINT[53].TIPO   := 'N';
  TABSINT[53].NOMETS := 'EXP_SIMP';
  TABSINT[53].NUMNO  := 7;
  TABSINT[53].ALTTS  := 0;
  TABSINT[53].SUCTS  := 8;

  TABSINT[54].TIPO   := 'T';
  TABSINT[54].NOMETS := '$';
  TABSINT[54].NUMNO  := 8;
  TABSINT[54].ALTTS  := 0;
  TABSINT[54].SUCTS  := 0;

  TABSINT[55].TIPO   := 'C';
  TABSINT[55].NOMETS := 'EXP_SIMP';
  TABSINT[55].NUMNO  := -1;
  TABSINT[55].ALTTS  := -1;
  TABSINT[55].SUCTS  := -1;

  TABSINT[56].TIPO   := 'N';
  TABSINT[56].NOMETS := 'TERMO';
  TABSINT[56].NUMNO  := 1;
  TABSINT[56].ALTTS  := 0;
  TABSINT[56].SUCTS  := 2;

  TABSINT[57].TIPO   := 'T';
  TABSINT[57].NOMETS := '+';
  TABSINT[57].NUMNO  := 2;
  TABSINT[57].ALTTS  := 3;
  TABSINT[57].SUCTS  := 1;

  TABSINT[58].TIPO   := 'T';
  TABSINT[58].NOMETS := '-';
  TABSINT[58].NUMNO  := 3;
  TABSINT[58].ALTTS  := 4;
  TABSINT[58].SUCTS  := 1;

  TABSINT[59].TIPO   := 'T';
  TABSINT[59].NOMETS := '$';
  TABSINT[59].NUMNO  := 4;
  TABSINT[59].ALTTS  := 0;
  TABSINT[59].SUCTS  := 0;

  TABSINT[60].TIPO   := 'C';
  TABSINT[60].NOMETS := 'TERMO';
  TABSINT[60].NUMNO  := -1;
  TABSINT[60].ALTTS  := -1;
  TABSINT[60].SUCTS  := -1;

  TABSINT[61].TIPO   := 'N';
  TABSINT[61].NOMETS := 'FATOR';
  TABSINT[61].NUMNO  := 1;
  TABSINT[61].ALTTS  := 0;
  TABSINT[61].SUCTS  := 2;

  TABSINT[62].TIPO   := 'T';
  TABSINT[62].NOMETS := '*';
  TABSINT[62].NUMNO  := 2;
  TABSINT[62].ALTTS  := 3;
  TABSINT[62].SUCTS  := 1;

  TABSINT[63].TIPO   := 'T';
  TABSINT[63].NOMETS := '/';
  TABSINT[63].NUMNO  := 3;
  TABSINT[63].ALTTS  := 4;
  TABSINT[63].SUCTS  := 1;

  TABSINT[64].TIPO   := 'T';
  TABSINT[64].NOMETS := '$';
  TABSINT[64].NUMNO  := 4;
  TABSINT[64].ALTTS  := 0;
  TABSINT[64].SUCTS  := 0;

  TABSINT[65].TIPO   := 'C';
  TABSINT[65].NOMETS := 'FATOR';
  TABSINT[65].NUMNO  := -1;
  TABSINT[65].ALTTS  := -1;
  TABSINT[65].SUCTS  := -1;

  TABSINT[66].TIPO   := 'T';
  TABSINT[66].NOMETS := 'IDENT';
  TABSINT[66].NUMNO  := 1;
  TABSINT[66].ALTTS  := 2;
  TABSINT[66].SUCTS  := 6;

  TABSINT[67].TIPO   := 'T';
  TABSINT[67].NOMETS := 'CONST';
  TABSINT[67].NUMNO  := 2;
  TABSINT[67].ALTTS  := 3;
  TABSINT[67].SUCTS  := 6;

  TABSINT[68].TIPO   := 'T';
  TABSINT[68].NOMETS := '(';
  TABSINT[68].NUMNO  := 3;
  TABSINT[68].ALTTS  := 6;
  TABSINT[68].SUCTS  := 4;

  TABSINT[69].TIPO   := 'N';
  TABSINT[69].NOMETS := 'EXPRESSAO';
  TABSINT[69].NUMNO  := 4;
  TABSINT[69].ALTTS  := 0;
  TABSINT[69].SUCTS  := 5;

  TABSINT[70].TIPO   := 'T';
  TABSINT[70].NOMETS := ')';
  TABSINT[70].NUMNO  := 5;
  TABSINT[70].ALTTS  := 0;
  TABSINT[70].SUCTS  := 6;

  TABSINT[71].TIPO   := 'T';
  TABSINT[71].NOMETS := '$';
  TABSINT[71].NUMNO  := 6;
  TABSINT[71].ALTTS  := 0;
  TABSINT[71].SUCTS  := 0;

  TABSINT[72].TIPO   := '';
  TABSINT[72].NOMETS := '';
  TABSINT[72].NUMNO  := -1;
  TABSINT[72].ALTTS  := -1;
  TABSINT[72].SUCTS  := -1;

(************* Inicializacao das Variaveis *******************)
(************* do carregador sintático ***********************)
   MAXT := 0;
   MAXNT := 0;
   INDPRIM := 1;
   NOMAX := 0;
   INDTS := 1;

   While TABSINT[INDTS].TIPO <> '' DO
     Begin{1}
       If TABSINT[INDTS].TIPO = 'C' Then
          Begin{2}
            INDPRIM := INDPRIM + NOMAX;
            NOMAX := 0;
            If EncontraNaTABNT(TABSINT[INDTS].NOMETS) = False Then
               Begin{3}
                 MAXNT := MAXNT + 1;
                 TABNT[MAXNT].NOMENT := TABSINT[INDTS].NOMETS;
                 TABNT[MAXNT].PRIM := INDPRIM;
               End;{3}
            For J := 1 To MAXNT DO
              Begin{4}
                If ((TABNT[J].NOMENT = TABSINT[INDTS].NOMETS) And
                       (TABNT[J].PRIM = 0)) Then
                   Begin {5}
                     TABNT[J].PRIM := INDPRIM;
                   End{5}
                Else
                  Begin{7}
{                   MENSAGEM.CAPTION := 'Dois cabecas para um mesmo terminal';}
                  End;{7}
              End;{4}
          End{2}
       Else
         Begin{8}
           I := INDPRIM + TABSINT[INDTS].NUMNO - 1;
           If ((TABSINT[INDTS].TIPO = 'T') And (TABSINT[INDTS].NOMETS <> '')) Then
              Begin {9}
                If (EncontraNaTABT(TABSINT[INDTS].NOMETS) = False) Then
                   Begin {10}
                     MAXT := MAXT + 1;
                     TABT[MAXT].NOMET := TABSINT[INDTS].NOMETS;
                   End;  {10}
                For J := 1 To MAXT DO
                  Begin{11}
                    If (TABT[J].NOMET = TABSINT[INDTS].NOMETS) Then
                       Begin {12}
                         TABGRAFO[I].TER := True;
                         E := J;
                         J := MAXT;
                       End{12}
                  End;{11}
              End; {9}
           If (TABSINT[INDTS].TIPO = 'N') Then
              Begin{13}
                              If (EncontraNaTABNT(TABSINT[INDTS].NOMETS) = False) Then
                   Begin {14}
                     MAXNT := MAXNT + 1;
                     TABNT[MAXNT].NOMENT := TABSINT[INDTS].NOMETS;
                     TABNT[MAXNT].PRIM := 0;
                   End; {14}
                 For J := 1 To MAXNT DO
                   Begin{15}
                     If (TABNT[J].NOMENT = TABSINT[INDTS].NOMETS) Then
                        Begin {16}
                          TABGRAFO[I].TER := False;
                          E := J;
                          J := MAXNT;
                        End{16}
                   End;{15}
              End;{13}

           IF (TABSINT[INDTS].NOMETS = '$') Then
              Begin {17}
                TABGRAFO[I].TER := True;
                TABGRAFO[I].SIM := 0;
              End{17}
           Else
             Begin{18}
               TABGRAFO[I].SIM := E;
             End;{18}

           IF (TABSINT[INDTS].ALTTS <> 0) Then
              Begin {19}
                TABGRAFO[I].ALTTG := INDPRIM + TABSINT[INDTS].ALTTS - 1;
              End{19}
           Else
             Begin{20}
               TABGRAFO[I].ALTTG := 0;
             End;{20}

           IF (TABSINT[INDTS].SUCTS <> 0) Then
              Begin {21}
                TABGRAFO[I].SUCTG := INDPRIM + TABSINT[INDTS].SUCTS - 1;
              End{21}
           Else
             Begin{22}
               TABGRAFO[I].SUCTG := 0;
             End;{22}

          If (NOMAX < TABSINT[INDTS].NUMNO) Then
             Begin{23}
               NOMAX := TABSINT[INDTS].NUMNO;
             End;{23}
         End;{8}
       INC(INDTS);
     End;{1}
(************ Fim do Carregador Sintático ****************)
end;



(****** Programa Principal ********)
Begin {1}
carrega;

 linha := '';
 writeln;
 CLRSCR;
 write ('Nome do arquivo a ser compilado : ');
 readln (nome_arq);
 assign (arq,nome_arq);
 {$I-}
 reset (arq);
 {$I+}
{ if ioresult <> 0 then
  begin
   p_erro(2);
  end
 else}
    CLRSCR;
    WRITELN('************************** PROGRAMA SENDO ANALISADO************************');

  com := 0; (* Contador de Comentarios *)
  lit := 0; (* Contador de literais *)

  OS := 1; (* Linha *)
  MA := 1; (* Coluna *)

  Ent.Nome := '';
  Ent.Classe := '';

  OBJT := 1;

  (******************* Declaracao de Palavras Reservadas ************************)
   reservada[1] := 'PROGRAM';    reservada[2] := 'LABEL';
   reservada[3] := 'CONST';      reservada[4] := 'VAR';
   reservada[5] := 'PROCEDURE';  reservada[6] := 'BEGIN';
   reservada[7] := 'END';        reservada[8] := 'INTEGER';
   reservada[9] := 'ARRAY';      reservada[10] := 'OF';
   reservada[11] := 'CALL';      reservada[12] := 'GOTO';
   reservada[13] := 'IF';        reservada[14] := 'THEN';
   reservada[15] := 'ELSE';      reservada[16] := 'WHILE';
   reservada[17] := 'DO';        reservada[18] := 'REPEAT';
   reservada[19] := 'UNTIL';     reservada[20] := 'READLN';
   reservada[21] := 'WRITELN';   reservada[22] := 'READ';
   reservada[23] := 'WRITE';     reservada[24] := 'OR';
   reservada[25] := 'AND';       reservada[26] := 'NOT';
   reservada[27] := 'IDENT';     reservada[28] := 'CLRSCR';
   reservada[29] := 'FOR';       reservada[30] := 'TO';
   reservada[31] := 'CASE';      reservada[32] := 'USES';
   reservada[33] := 'CRT';       reservada[34] := 'KEYPRESSED';
   reservada[35] := 'BYTE';      reservada[36] := 'SET';
   reservada[37] := 'WITH';      reservada[38] := 'GOTOXY';
   reservada[39] := 'TYPE';      reservada[40] := 'CHAR';
   reservada[41] := 'STRING';    reservada[42] := 'LONGINT';
   reservada[43] := 'REAL';      reservada[44] := 'FILE';
   reservada[45] := 'READKEY';   reservada[46] := 'BOOLEAN';
   reservada[47] := 'FUNCTION';  Reservada[48] := 'RECORD';
   reservada[49] := 'UNIT';      reservada[50] := 'INTERFACE';
   reservada[51] := '+';         reservada[52] := '-';
   reservada[53] := '*';         reservada[54] := '/';
   reservada[55] := '[';         reservada[56] := ']';
   reservada[57] := '(';         reservada[58] := ')';
   reservada[59] := ':';         reservada[60] := '=';
   reservada[61] := '<';         reservada[62] := '>';
   reservada[63] := ',';         reservada[64] := ';';
   reservada[65] := '.';         reservada[66] := '$';
   reservada[67] := ':=';        reservada[68] := '<>';
   reservada[69] := '<=';        reservada[70] := '>=';
   reservada[71] := '..';        reservada[72] := 'ASPAS';

   reservada[100] := 'IDENT';    reservada[101] := 'CONST';
   reservada[102] := 'EXPRESSAO'; reservada[103] := 'NAO RECONHECIDO';
   reservada[104] := 'COMENTARIO'; reservada[105] := 'LITERAL';

   (* 100 codigo do indentificador *)
   (* 101 codigo da constante      *)
   (* 102 codigo do literal        *)
   (* 103 codigo do comentario     *)

(**************************** Analisador Sintatico ****************************)
 ler_arq;
 totaldelinhas:= cont_ln; {Conta o numero de linhas do texto}
  For pos := 0 to totaldelinhas do
    begin
      tem := false;
      lin := aux;
      For cao := 1 to length(lin) do
          if lin[cao] <> ' ' then
             tem := true;
      if tem = true then
         ultima := pos;
    end;
  totaldelinhas := ultima + 1;

  Writeln('************* Analise L‚xica ***************');

 (************ Faz a selecao dos literais e Comentarios *****************)
  Denovo := True;
  While DENOVO = True DO
    Begin {A1}
      ANALEX; (* Le o primeiro simbolo *)
      if ((ent.Classe = 'COMENTARIO') or (Ent.Classe = 'LITERAL')
         OR (Ent.Classe = 'WRITE') OR (Ent.Classe ='WRITELN')) then
            begin{A2}
              denovo := true;
             If ent.classe = 'COMENTARIO' Then
                Begin{A3}
                  inc(com);
                  Comentario[com].comenta := Ent.nome;
                  Comentario[com].linha := os;
                End;{A3}
             If (Ent.Classe = 'LITERAL') OR (Ent.Classe = 'WRITELN')
                OR (Ent.Classe = 'WRITE') THEN
                Begin {A4}
                  Inc(lit);
                  Literal[lit].litera := Ent.nome;
                  Literal[lit].linha := os;
                End;{A4}
            End {A2}
      Else
       Denovo := false;
    end;{A1}
  TOPO := 0;
  k[1]:= 0;
  INDEX :=  TABNT[OBJT].PRIM; (* Aponta para o primeiro no do simbolo inicial*)
  Continue := TRUE;
  Sucesso := false;
  While CONTINUE do
    Begin{2}
      If INDEX <> 0 then (* Nao e o fim de uma producao *)
         Begin{3}
           If TABGRAFO[INDEX].TER then (* E um terminal *)
              Begin {4}
                If TABGRAFO[INDEX].SIM = 0 then (* E um no vazio *)
                   Begin {5}
                     INDEX := TABGRAFO[INDEX].SUCTG;
                   End {5}
                Else
                  Begin {6}
                    If TABT[TABGRAFO[INDEX].SIM].NOMET = ENT.CLASSE then
                       Begin {7} (* Reconheceu um Terminal *)

(************ Faz a selecao dos literais e Comentarios *****************)
                         Denovo := True;
                         While DENOVO = True DO
                           Begin {15}
                             ANALEX; (* Le o proximo simbolo *)
                             if ((ent.Classe = 'COMENTARIO') or (Ent.Classe = 'LITERAL')
                                OR (Ent.Classe = 'WRITE') OR (Ent.Classe ='WRITELN')) then
                               begin {16}
                                 denovo := true;
                                 If ent.classe = 'COMENTARIO' Then
                                    Begin {17}
                                      Inc(com);
                                      Comentario[com].comenta := Ent.nome;
                                      Comentario[com].linha := os;
                                    End; {17}
                                 If (Ent.Classe = 'LITERAL') OR (Ent.Classe = 'WRITELN')
                                    OR (Ent.Classe = 'WRITE') THEN
                                    Begin {18}
                                      Inc(lit);
                                      Literal[lit].litera := Ent.nome;
                                      Literal[lit].linha := os;
                                    End; {18}
                               End {16}
                             Else
                           Denovo := false;
                         end; {15}

                         INDEX := TABGRAFO[INDEX].SUCTG; (* Vai parao sucessor *)
                       End {7}
                    Else
                      Begin {8}
                        If TABGRAFO[INDEX].ALTTG <> 0 THEN (* Ha Alternativa *)
                           INDEX := TABGRAFO[INDEX].ALTTG (* Tome a alternativa *)
                        Else
                          begin {14}
                           TRATAERRO1; (*Erro Sintatico *)
                           Continue := FALSE;
                          end; {14}
                      end; {8}
                  end; {6}
              end {4}
            Else
              Begin {9} (* E um nao terminal *)
                EMPILHA(INDEX);
                INDEX := TABNT[TABGRAFO[INDEX].SIM].PRIM;
                (* Vai para o primeiro no do nao terminal *)
              End;{9}
         End {3}
      Else
       Begin {10}
         If TOPO <> 0 then (* A pilha nao esta vazia *)
            Begin {11}
              INDEX := DESEMPILHA;
              INDEX := TABGRAFO[INDEX].SUCTG;
              (* Vai para o sucessor do nao terminal *)
            End {11}
         Else
           Begin {12}
             If (ENT.NOME = '$') Then
                begin
                  Sucesso := True;
                  continue := false;
                End
             Else
               Begin{13}
                 Sucesso := False;
                 Trataerro2; (* Estao Sobrando Simbolos *)
                 Continue := False; (* Encerra a analise *)
               End; {13}
           End;{12}
       End; {10}

    End;{2}
  if Sucesso = true then(* Verifica se esta ok a analise sintatica *)
     Begin {19}
       Writeln('************* Resultados ***************');
       Writeln('  -> Analise Sintática está OK !!!');
       Writeln('******************************************');
       Writeln('');
     End; {19}

  If com > 0 then  (* Verifica se tem algum comentario *)
    Begin {20}
      Writeln('************ Comentarios  ***************');
      for x := 1 to com do
        Writeln(' Comentario -> '+ comentario[x].comenta + ' - Linha ' + inttostr(Comentario[x].linha+1));
    End; {20}

  If Lit > 0 then (* Verifica se tem algum literal *)
    Begin {21}
      Writeln('************ Literais *******************');
      for x := 1 to Lit do
        Writeln(' Literal -> '+ literal[x].litera + ' - Linha ' + inttostr(Literal[x].linha+1));
    End; {21}

  Writeln('*******************************************');
readln;
End.{1}
readln;
end.
