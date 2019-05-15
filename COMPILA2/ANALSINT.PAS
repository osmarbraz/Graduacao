Program Analizador_Sintatico;
Uses Crt;
Const
  MAXG = 100;
  MAXT = 40;
  MAXNT = 10;
  MAXK = 30;
Type
  ALFA = record
           NOME   : String;
           CLASSE : String;
         end;
Var
  TABGRAFO : array [0..MAXG] of record
                                  TER            : Boolean;
                                  SIM, ALT, SUC : Integer;
                                  SEM            : Integer;
                                end;
  TABNT : array [1..MAXNT] of record
                                NOME    : String;
                                PRIM    : Integer;
                              end;
  TABT   : Array [1..MAXT] of ALFA;
  K      : Array [1..MAXK] of Integer;
  TOPO   : Integer;
  OBJT   : Shortint;

  ErroSint : Integer;
  Sucesso  : Boolean;

Procedure TrataErro(Erro:integer); (*Tratamento de Erro*)
Begin
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

Procedure ANALEX(PROX : ALFA); (* Analisador Lexico - Retorna o proximo simbolo*)
Begin
End;

Procedure CARRSINT; (* Carregador Sintatico - Carrega as Tabelas *)
Begin
End;

Procedure ANASINT (OBJT : Integer); (* Analisador Sintatico *)
Var
  CONTINUE    : Boolean; (* Controle da continuacao da interpretacao *)
  INDEX       : Integer; (* Indice para os nos do grafo - indica o no sendo interpretado *)
  ENT         : ALFA;  (* Proximo simbolo de entrada *)

Begin
  ANALEX (ENT); (* Le o primeiro simbolo *)
  TOPO := 0;
  INDEX :=  TABNT[OBJT].PRIM; (* Aponta para o primeiro no do simbolo inicial*)
  CONTINUE := TRUE;
  While CONTINUE do
    Begin
      If INDEX <> 0 then (* Nao e o fim de uma producao *)
         Begin
           If TABGRAFO[INDEX].TER then (* E um terminal *)
              Begin
                If TABGRAFO[INDEX].SIM = 0 then (* E um no vazio *)
                   Begin
                     INDEX := TABGRAFO[INDEX].SUC;
                   End
                Else
                  Begin
                    If TABT[TABGRAFO[INDEX].SIM].NOME = ENT.NOME then
                       Begin (* Reconheceu um Terminal *)
                         ANALEX(ENT); (*Le o proximo simbolo *)
                         INDEX := TABGRAFO[INDEX].SUC; (* Vai parao sucessor *)
                       End
                    Else
                      Begin
                        If TABGRAFO[INDEX].ALT <> 0 THEN (* Ha Alternativa *)
                           INDEX := TABGRAFO[INDEX].ALT (* Tome a alternativa *)
                        Else
                           TRATAERRO(ErroSint); (*Erro Sintatico *)
                      End;
                  End;
              End
            Else
              Begin (* E um nao terminal *)
                EMPILHA(INDEX);
                INDEX := TABNT[TABGRAFO[INDEX].SIM].PRIM;
                (* Vai para o primeiro no do nao terminal *)
              End;
         End
      Else
       Begin
         If TOPO <> 0 then (* A pilha nao esta vazia *)
            Begin
              INDEX := DESEMPILHA;
              INDEX := TABGRAFO[INDEX].SUC;
              (* Vai para o sucessor do nao terminal *)
            End
         Else
           Begin
             If ENT.NOME = '$' Then
                Sucesso := True
             Else
               Begin
                 Sucesso := False;
{                 Trataerro(Insucesso); (* Estao Sobrando Simbolos *)}
                 Continue := False; (* Encerra a analise *)
               End;
           End;
       End;

    End;

End;

(* Programa Principal *)
Begin
  {CarSint;} (* Chamada o Carregador Sintatico *)
  Anasint(objt); (* Chamada do Analisador Sintatico *)

End.