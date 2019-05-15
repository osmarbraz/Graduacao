Program CarregadorSintatico;
Uses
  CRT;
Const
  Max = 30;
Type
  TabSint = Record
     Tipo, Nome: Char;
     NumNo, Alt, Suc: integer;
  End;
  TabGrafo = Record
     Ter: Boolean;
     Sim, Alt, Suc: integer;
  End;
  TabNT = Record
     Nome: Char;
     Prim: integer;
  End;
Var
  TS: Array [1..Max] Of TabSint;
  TG: Array [1..Max] Of TabGrafo;
  TT: Array [1..Max] Of Char;
  TN: Array [1..Max] Of TabNT;
  MaxT, MaxNT, IndPrim, NoMax, IndTG, IndTS: integer;

{===========================================================================}

Procedure DefTabSint;
Var
  I, Lin, Col: integer;
Begin
  ClrScr;
  I := 0;
  Lin := 1;
  Col := 1;
  GotoXY (Col, Lin);
  Write ('Definicao da Tabela do Sintatico');
  Inc (Lin, 2);
  GotoXY (Col, Lin);
  Write ('Indice');
  Col := 11;
  GotoXY (Col, Lin);
  Write ('Tipo');
  Col := 19;
  GotoXY (Col, Lin);
  Write ('Nome');
  Col := 27;
  GotoXY (Col, Lin);
  Write ('Numero No');
  Col := 40;
  GotoXY (Col, Lin);
  Write ('Alternativa');
  Col := 55;
  GotoXY (Col, Lin);
  Write ('Sucessor');
  Repeat
     Inc (I);
     Col := 1;
     Inc (Lin);
     GotoXY (Col, Lin);
     Write (I);
     Col := 11;
     GotoXY (Col, Lin);
     Write;
     ReadLn (TS [I].Tipo);
     TS [I].Tipo := UpCase (TS [I].Tipo);
     If TS [I].Tipo = 'F'
     Then
     Begin
        IndTS := I;
        Exit;
     End;
     Col := 19;
     GotoXY (Col, Lin);
     Write;
     ReadLn (TS [I].Nome);
     Col := 27;
     GotoXY (Col, Lin);
     Write;
     ReadLn (TS [I].NumNo);
     Col := 40;
     GotoXY (Col, Lin);
     Write;
     ReadLn (TS [I].Alt);
     Col := 55;
     GotoXY (Col, Lin);
     Write;
     ReadLn (TS [I].Suc);
  Until I = Max;
  IndTS := Max;
End;

{===========================================================================}

Procedure DefTabNT;
Var
  I: integer;
Begin
  For I := 1 To Max Do
  Begin
     TN [I].Nome := ' ';
     TN [I].Prim := 0;
  End;
End;

{===========================================================================}

Procedure DefTabelas;
Var
  I, J, K: integer;
  Cond: Boolean;
Begin
  MaxT := 0;
  MaxNT := 0;
  IndPrim := 1;
  NoMax := 0;
  I := 1;
  DefTabNT;
  While TS [I].Tipo <> 'F' Do
  Begin
     If TS [I].Tipo = 'C'
     Then
     Begin
        IndPrim := IndPrim + NoMax;
        NoMax := 0;
        J := 1;
        Cond := True;
        While TN [J].Nome <> ' ' Do
        Begin
           If TS [I].Nome = TN [J].Nome
           Then
              Cond := False;
           Inc (J);
        End;
        If Cond
        Then
        Begin
           MaxNT := MaxNT + 1;
           TN [MaxNT].Nome := TS [I].Nome;
           TN [MaxNT].Prim := IndPrim;
        End;
        For J := 1 To MaxNT Do
        Begin
           If (TN [J].Nome = TS [I].Nome) then
            if (TN [J].Prim = 0)
           Then
              TN [J].Prim := IndPrim
           Else
           Begin
              {Erro: Existe dois cabecas para um mesmo terminal}
           End;
        End;
     End
     Else
     Begin
        K := IndPrim + TS [I].NumNo - 1;
        If (TS [I].Tipo = 'T') And (TS [I].Nome <> ' ')
        Then
         Begin
           J := 1;
           Cond := True;
           While (TT [J] <> ' ') And (j < Max)  Do
           Begin
              If TS [I].Nome = TT [J]
              Then
                 Cond := False;
              Inc (J);
           End;
           If Cond Then
            Begin
             MaxT := MaxT + 1;
             TT [MaxT] := TS [I].Nome;
            End;
         End;
        For J := 1 To MaxT Do
        Begin
           If TT [J] = TS [I].Nome
           Then
              TG [K].Ter := True;
        End;
        If TS [I].Tipo = 'N'
        Then
        Begin
           J := 1;
           Cond := True;
           While TN [J].Nome <> ' ' Do
           Begin
              If TS [I].Nome = TN [J].Nome
              Then
                 Cond := False;
              Inc (J);
           End;
           If Cond
           Then
           Begin
              MaxNT := MaxNT + 1;
              TN [MaxNT].Nome := TS [I].Nome;
              TN [MaxNT].Prim := 0;
           End;
           For J := 1 To MaxNT Do
           Begin
              If TN [J].Nome = TS [I].Nome
              Then
                 TG [K].Ter := False;
           End;
        End;
        If TS [I].Nome = ' '
        Then
        Begin
    {       TG [K].Ter := True;}
           TG [K].Sim := 0;
{           IndTG := K;}
        End
        Else
           TG [K].Sim := J;
     IndTG := K;
        If TS [I].Alt <> 0
        Then
           TG [K].Alt := IndPrim + TS [I].Alt - 1
        Else
           TG [K].Alt := 0;
        If TS [I].Suc <> 0
        Then
           TG [K].Suc := IndPrim + TS [I].Suc - 1
        Else
           TG [K].Suc := 0;
        If NoMax < TS [I].NumNo
        Then
           NoMax := TS [I].NumNo;
     End;
     Inc (I);
  End;
End;

{===========================================================================}

Procedure AprTabSint;
Var
  I, Lin, Col: integer;
Begin
  ClrScr;
  Lin := 1;
  Col := 1;
  GotoXY (Col, Lin);
  Write ('Definicao da Tabela do Sintatico');
  Inc (Lin, 2);
  GotoXY (Col, Lin);
  Write ('Indice');
  Col := 11;
  GotoXY (Col, Lin);
  Write ('Tipo');
  Col := 19;
  GotoXY (Col, Lin);
  Write ('Nome');
  Col := 27;
  GotoXY (Col, Lin);
  Write ('Numero No');
  Col := 40;
  GotoXY (Col, Lin);
  Write ('Alternativa');
  Col := 55;
  GotoXY (Col, Lin);
  Write ('Sucessor');
  For I := 1 To IndTS Do
  Begin
     Col := 1;
     Inc (Lin);
     GotoXY (Col, Lin);
     Write (I);
     Col := 11;
     GotoXY (Col, Lin);
     Write (TS [I].Tipo);
     Col := 19;
     GotoXY (Col, Lin);
     Write (TS [I].Nome);
     Col := 27;
     GotoXY (Col, Lin);
     Write (TS [I].NumNo);
     Col := 40;
     GotoXY (Col, Lin);
     Write (TS [I].Alt);
     Col := 55;
     GotoXY (Col, Lin);
     Write (TS [I].Suc);
  End;
End;


{===========================================================================}

Procedure DefTabGrafos;
Var
  I, Lin, Col: integer;
Begin
  ClrScr;
  Lin := 1;
  Col := 1;
  GotoXY (Col, Lin);
  Write ('Definicao da Tabela dos Grafos');
  Inc (Lin, 2);
  GotoXY (Col, Lin);
  Write ('Indice');
  Col := 11;
  GotoXY (Col, Lin);
  Write ('Terminal');
  Col := 23;
  GotoXY (Col, Lin);
  Write ('Sim');
  Col := 30;
  GotoXY (Col, Lin);
  Write ('Alternativa');
  Col := 45;
  GotoXY (Col, Lin);
  Write ('Sucessor');
  For I := 1 To IndTG Do
  Begin
     Col := 1;
     Inc (Lin);
     GotoXY (Col, Lin);
     Write (I);
     Col := 11;
     GotoXY (Col, Lin);
     Write (TG [I].Ter);
     Col := 23;
     GotoXY (Col, Lin);
     Write (TG [I].Sim);
     Col := 30;
     GotoXY (Col, Lin);
     Write (TG [I].Alt);
     Col := 45;
     GotoXY (Col, Lin);
     Write (TG [I].Suc);
  End;
End;

{===========================================================================}

Procedure DefTabTer;
Var
  I, Lin, Col: integer;
Begin
  ClrScr;
  Lin := 1;
  Col := 1;
  GotoXY (Col, Lin);
  Write ('Definicao da Tabela dos Terminais');
  Inc (Lin, 2);
  GotoXY (Col, Lin);
  Write ('Indice');
  Col := 11;
  GotoXY (Col, Lin);
  Write ('Nome');
  For I := 1 To (MaxT - 1) Do
  Begin
     Col := 1;
     Inc (Lin);
     GotoXY (Col, Lin);
     Write (I);
     Col := 11;
     GotoXY (Col, Lin);
     Write (TT [I]);
  End;
End;

{===========================================================================}

Procedure DefTabNTer;
Var
  I, Lin, Col: integer;
Begin
  ClrScr;
  Lin := 1;
  Col := 1;
  GotoXY (Col, Lin);
  Write ('Definicao da Tabela dos Nao Terminais');
  Inc (Lin, 2);
  GotoXY (Col, Lin);
  Write ('Indice');
  Col := 11;
  GotoXY (Col, Lin);
  Write ('Nome');
  Col := 19;
  GotoXY (Col, Lin);
  Write ('Prim');
  For I := 1 To MaxNT Do
  Begin
     Col := 1;
     Inc (Lin);
     GotoXY (Col, Lin);
     Write (I);
     Col := 11;
     GotoXY (Col, Lin);
     Write (TN [I].Nome);
     Col := 19;
     GotoXY (Col, Lin);
     Write (TN [I].Prim);
  End;
End;

{===========================================================================}

Begin
  {DefTabSint;}

  TS [1].Tipo := 'C';
  TS [2].Tipo := 'T';
  TS [3].Tipo := 'T';
  TS [4].Tipo := 'N';
  TS [5].Tipo := 'T';
  TS [6].Tipo := 'T';
  TS [7].Tipo := 'N';
  TS [8].Tipo := 'T';
  TS [9].Tipo := 'C';
  TS [10].Tipo := 'T';
  TS [11].Tipo := 'N';
  TS [12].Tipo := 'T';
  TS [13].Tipo := 'F';
  TS [1].Nome := 'S';
  TS [2].Nome := 'a';
  TS [3].Nome := 'b';
  TS [4].Nome := 'S';
  TS [5].Nome := 'c';
  TS [6].Nome := 'd';
  TS [7].Nome := 'M';
  TS [8].Nome := 'e';
  TS [9].Nome := 'M';
  TS [10].Nome := 'f';
  TS [11].Nome := 'S';
  TS [12].Nome := '-';
  TS [13].Nome := ' ';
  TS [1].NumNo := -1;
  TS [2].NumNo := 1;
  TS [3].NumNo := 2;
  TS [4].NumNo := 3;
  TS [5].NumNo := 4;
  TS [6].NumNo := 5;
  TS [7].NumNo := 6;
  TS [8].NumNo := 7;
  TS [9].NumNo := -1;
  TS [10].NumNo := 1;
  TS [11].NumNo := 2;
  TS [12].NumNo := 3;
  TS [1].Alt := -1;
  TS [2].Alt := 5;
  TS [3].Alt := 3;
  TS [4].Alt := 0;
  TS [5].Alt := 0;
  TS [6].Alt := 7;
  TS [7].Alt := 0;
  TS [8].Alt := 0;
  TS [9].Alt := -1;
  TS [10].Alt := 3;
  TS [11].Alt := 0;
  TS [12].Alt := 0;
  TS [1].Suc := -1;
  TS [2].Suc := 2;
  TS [3].Suc := 0;
  TS [4].Suc := 4;
  TS [5].Suc := 0;
  TS [6].Suc := 6;
  TS [7].Suc := 0;
  TS [8].Suc := 0;
  TS [9].Suc := -1;
  TS [10].Suc := 2;
  TS [11].Suc := 1;
  TS [12].Suc := 0;
  IndTS := 12;

  DefTabelas;
  AprTabSint;
  ReadLn;
  DefTabGrafos;
  ReadLn;
  DefTabTer;
  ReadLn;
  DefTabNTer;
  ReadLn;
End.