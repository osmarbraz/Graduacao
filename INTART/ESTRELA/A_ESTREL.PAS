Program A_ESTRELA;
Uses CRT;

Type
   STR3 = String[3];

   APSUCESSOR = ^SUC;

   APABERTO = ^NO_AB;
   NO_AB    = Record
                NOME       : STR3;
                PAI        : Apaberto;
                CUSTO      : Integer;
                PROX       : APABERTO;
                SUCESSORES : APSUCESSOR;
              End;

   SUC        =  Record
                   NOME  : STR3;
                   PAI   : apaberto;
                   CUSTO : Integer;
                   PROX  : APSUCESSOR;
                 End;


   APFECHADo = ^NO_FE;
   NO_FE     = Record
                 NOME  : STR3;
                 PROX  : APFECHADo;
               End;

     CID = Record
             NOME     : STR3;
             SUCESSOR : STR3;
             CUSTO    : Integer;
           End;

VAR
     CIDADE                                     : ARRAY [1..13] OF CID;
     I,CA,X                                     : BYTE;
     ABERTO,  RAIZABERTO, PROXABE               : APABERTO;
     PROXSUC, SUCESS                            : APSUCESSOR;
     FECHADo, RAIZFECHADo                       : APFECHADo;
     ORIGEM, META                               : STR3;
     MENOR                                      : Real;
     CAMINHO                                    : ARRAY [1..13] OF STR3;
     PROXIMOCAMINHO                             : APABERTO;
{**************************************************************************}
Procedure INSERE_FILA_ABERTOS (nome_cidade: str3; nome_pai : apaberto; cusTO : Integer);
var
 aux, aux2 : apaberTO;
Begin
 If ABERTO = Nil Then  { SE LISTA VAZIA }
 Begin
   New(ABERTO);
   ABERTO^.NOME  := NOME_CIDADE;
   ABERTO^.PAI   := nil;
   ABERTO^.CUSTO := CUSTO;
   ABERTO^.PROX  := Nil;
   RAIZABERTO := ABERTO;
 End
 Else
 Begin
   New(AUX);
   AUX^.NOME  := NOME_CIDADE;
   AUX^.PAI   := aberto;
   AUX^.CUSTO := CUSTO;
   AUX^.PROX  := Nil;
   AUX2 := RAIZABERTO;
   While AUX2^.PROX <> Nil Do
   Begin
      AUX2 := AUX2^.PROX;
   End;
   AUX2^.PROX := AUX;
End;
End;

Procedure INSERE_FILA_FECHADoS(NOME_CIDADE: STR3);
VAR
 AUX,AUX2 : APFECHADo;
Begin
 If FECHADo = Nil Then  { SE LISTA VAZIA }
 Begin
   New(FECHADo);
   FECHADo^.NOME  := NOME_CIDADE;
   FECHADo^.PROX  := Nil;
   RAIZFECHADo := FECHADo;
 End
 Else
 Begin
   New(AUX);
   AUX^.NOME  := NOME_CIDADE;
   AUX^.PROX  := Nil;
   AUX2 := RAIZFECHADo;
   While AUX2^.PROX <> Nil Do
   Begin
      AUX2 := AUX2^.PROX;
   End;
   AUX2^.PROX := AUX;
End;
End;

{***********************************************************}

Procedure ACHASUC(ELEMENTO :APABERTO);
VAR
     AUX_ABERTO                 : APABERTO;
     A                          : BYTE;
     AUX_SUCESSOR               : APSUCESSOR;
     PROXIMO, ANTERIOR          : APSUCESSOR;
     CIDADE_ABERTA              : STR3;
Begin
   AUX_ABERTO := ELEMENTO;
   ABERTO^.SUCESSORES := Nil;
   CIDADE_ABERTA := ABERTO^.NOME;
   FOR A:=1 To 13 Do
    Begin
      If (CIDADE[A].NOME = CIDADE_ABERTA) Then
        Begin
          If AUX_ABERTO^.SUCESSORES = Nil Then
             Begin
               New(AUX_SUCESSOR);
               AUX_SUCESSOR^.NOME := CIDADE[A].SUCESSOR;
               AUX_SUCESSOR^.PAI  := AUX_ABERTO;
               AUX_SUCESSOR^.CUSTO:= CIDADE[A].CUSTO + AUX_ABERTO^.CUSTO;
               AUX_SUCESSOR^.PROX := Nil;
               AUX_ABERTO^.SUCESSORES :=  AUX_SUCESSOR;
             End
          Else
            Begin
              New(AUX_SUCESSOR);
              AUX_SUCESSOR^.NOME := CIDADE[A].SUCESSOR;
              AUX_SUCESSOR^.PAI  := AUX_ABERTO;
              AUX_SUCESSOR^.CUSTO:= CIDADE[A].CUSTO + AUX_ABERTO^.CUSTO;
              PROXIMO := AUX_ABERTO^.SUCESSORES;
              If PROXIMO^.CUSTO > AUX_SUCESSOR^.CUSTO Then
                 Begin
                   AUX_SUCESSOR^.PROX := ABERTO^.SUCESSORES;
                   ABERTO^.SUCESSORES := AUX_SUCESSOR;
                 End
              Else
                Begin
                  While ((PROXIMO <> Nil) And (PROXIMO^.CUSTO<AUX_SUCESSOR^.CUSTO)) Do
                     Begin
                       ANTERIOR := PROXIMO;
                       PROXIMO := PROXIMO^.PROX;
                     End;
                  AUX_SUCESSOR^.PROX := ANTERIOR^.PROX;
                  ANTERIOR^.PROX := AUX_SUCESSOR;
                End;
            End;
        End;
   End;
End;
(**********************************************************************)
FUNCTION VERIFICAABERTO (NOMEABERTO:STR3): BOOLEAN;
VAR
  PROXABE1 : APABERTO;
  CHAVE    : Boolean;
Begin
  CHAVE := False;
  PROXABE1 := RAIZABERTO; { PEGO O PRIMEIRO DA LISTA DE ABERTOS}
  While  PROXABE1 <> Nil Do
    Begin
      If (PROXABE1^.NOME = NOMEABERTO) Then
         CHAVE := True;
      PROXABE1 := PROXABE1^.prox;
    End;
  VERIFICAABERTO := CHAVE;
End;

(**********************************************************************)
FUNCTION VERIFICAFECHADO (NOMEFECHADO:STR3): BOOLEAN;
VAR
  PROXFEC1 : APFECHADO;
  CHAVE    : Boolean;
Begin
  CHAVE := False;
  PROXFEC1 := RAIZFECHADo; { PEGO O PRIMEIRO DA LISTA DE FECHADo}
  While  PROXFEC1 <> Nil Do
    Begin
      If (PROXFEC1^.NOME = NOMEFECHADO) Then
         CHAVE := True;
      PROXFEC1 := PROXFEC1^.PROX;
    End;
  VERIFICAFECHADO := CHAVE;
End;

Begin
     CLRSCR;
     { INICIALIZACAO Do VETOR DE CIDADES, SUCESSORES E CUSTOS }
     CIDADE[1].NOME     := '1';
     CIDADE[1].SUCESSOR := '3';
     CIDADE[1].CUSTO    :=  274;

     CIDADE[2].NOME     := '1';
     CIDADE[2].SUCESSOR := '2';
     CIDADE[2].CUSTO    := 227;

     CIDADE[3].NOME     := '2';
     CIDADE[3].SUCESSOR := '3';
     CIDADE[3].CUSTO    := 102;

     CIDADE[4].NOME     := '3';
     CIDADE[4].SUCESSOR := '4';
     CIDADE[4].CUSTO    := 231;

     CIDADE[5].NOME     := '3';
     CIDADE[5].SUCESSOR := '5';
     CIDADE[5].CUSTO    := 282;

     CIDADE[6].NOME     := '7';
     CIDADE[6].SUCESSOR := '4';
     CIDADE[6].CUSTO    := 309;

     CIDADE[7].NOME     := '4';
     CIDADE[7].SUCESSOR := '5';
     CIDADE[7].CUSTO    := 140;

     CIDADE[8].NOME     := '5';
     CIDADE[8].SUCESSOR := '9';
     CIDADE[8].CUSTO    := 252;

     CIDADE[9].NOME     := '4';
     CIDADE[9].SUCESSOR := '6';
     CIDADE[9].CUSTO    :=  98;

     CIDADE[10].NOME     := '6';
     CIDADE[10].SUCESSOR := '8';
     CIDADE[10].CUSTO    :=  10;

     CIDADE[11].NOME     := '11';
     CIDADE[11].SUCESSOR := '10';
     CIDADE[11].CUSTO    := 137;

     CIDADE[12].NOME     := '10';
     CIDADE[12].SUCESSOR := '8';
     CIDADE[12].CUSTO    :=  92;

     CIDADE[13].NOME     := '8';
     CIDADE[13].SUCESSOR := '9';
     CIDADE[13].CUSTO    := 100;

     ORIGEM := '1';
     META   := '9';

      {********************PROGRAMA PRINCIPAL*********************}
     INSERE_FILA_ABERTOS (ORIGEM,nil,0);
     While (ABERTO<>Nil) Do
       Begin
         ACHASUC(ABERTO);
         INSERE_FILA_FECHADOS(ABERTO^.NOME);
         If ABERTO^.SUCESSORES <> Nil Then
            Begin
              SUCESS := ABERTO^.SUCESSORES;
              While  SUCESS <> Nil Do
                 Begin
                   If (VERIfICAABERTO(SUCESS^.NOME) = FALSE) Then
                      If (VERIfICAFECHADo(SUCESS^.NOME) = FALSE) Then
                         If SUCESS^.NOME <> META Then
                            Begin
                              INSERE_FILA_ABERTOS(SUCESS^.NOME, SUCESS^.PAI, SUCESS^.CUSTO);
                            End;
                    SUCESS := SUCESS^.PROX;
                 End;
            End;
           ABERTO := ABERTO^.PROX;
       End;

    PROXABE := RAIZABERTO;
    MENOR := 99999;
    CA:=1;
    CAMINHO[CA] := META;
    While PROXABE <> Nil Do
     Begin
       PROXSUC := PROXABE^.SUCESSORES;
       While PROXSUC<> Nil Do
         Begin
           If PROXSUC^.NOME = META Then
              If PROXSUC^.CUSTO < MENOR Then
                 Begin
                   PROXIMOCAMINHO := PROXABE;
                   MENOR := PROXSUC^.CUSTO;
                 End;
           PROXSUC := PROXSUC^.PROX;
         End;
       PROXABE := PROXABE^.PROX;
     End;
     Inc(CA);
     CAMINHO[CA] := PROXIMOCAMINHO^.NOME;
     While proximocaminho <> nil do
        begin
            proximocaminho := proximocaminho^.pai;
            if proximocaminho <> nil then
               begin
                 Inc(CA);
                 CAMINHO[CA] := PROXIMOCAMINHO^.NOME;
               end;
        end;
    FOR X:= 1 To CA Do
    WRITELN(X, ' -  ' ,CAMINHO[X]);
    WRITELN('TOTAL ',MENOR:0:2);
    WRITELN('INICIO ',ORIGEM,' -  META ',META);
End.




