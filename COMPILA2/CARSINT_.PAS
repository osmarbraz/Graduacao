Program CarregadorSintatico;
Uses
  CRT;
Const
  Max = 80;
Type
  str20 = string[20];
  TabSint = Record
     Tipo, Nome: str20;
     NumNo, Alt, Suc: integer;
  End;
  TabGrafo = Record
     Ter: Boolean;
     Sim, Alt, Suc: integer;
  End;
  TabNT = Record
     Nome: str20;
     Prim: integer;
  End;
Var
  TS: Array [1..Max] Of TabSint;
  TG: Array [1..Max] Of TabGrafo;
  TT: Array [1..Max] Of str20;
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
     {TS [I].Tipo := UpCase (TS [I].Tipo);}
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
  While TS [I].Tipo <> '&' Do
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
           If (TN [J].Nome = TS [I].Nome) And (TN [J].Prim = 0)
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
           MaxT := MaxT + 1;
           TT [MaxT] := TS [I].Nome;
        End;
        j := 0;
        Repeat
         inc (j);
         If TT [J] = TS [I].Nome
          Then
           TG [K].Ter := True;
        Until (TT[j] = TS[i].nome) or (j = maxt);
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
            j := 0;
            Repeat
             inc (j);
             If TN [J].Nome = TS [I].Nome
             Then
              TG [K].Ter := False;
            Until (TN [j].nome = TS[i].nome) or (j = Maxt);
        End;
        If TS [I+1].Tipo = '&'
        Then
        Begin
           TG [K].Ter := True;
           TG [K].Sim := 0;
           IndTG := K;
        End
        Else
           TG [K].Sim := J;
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
     if lin > 24 then
      begin
       lin := 1;
       readln;
       clrscr;
      end;
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
     if lin > 24 then
      begin
       lin := 1;
       readln;
       clrscr;
      end;
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
     if lin > 24 then
      begin
       lin := 1;
       readln;
       clrscr;
      end;
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
     if lin > 24 then
      begin
       lin := 1;
       readln;
       clrscr;
      end;
  End;
End;

{===========================================================================}

Begin
  {DefTabSint;}
  TS [1].Tipo := 'C';
  TS [2].Tipo := 'T';
  TS [3].Tipo := 'T';
  TS [4].Tipo := 'T';
  TS [5].Tipo := 'N';
  TS [6].Tipo := 'T';
  TS [7].Tipo := 'T';
  TS [8].Tipo := 'C';
  TS [9].Tipo := 'T';
  TS [10].Tipo := 'T';
  TS [11].Tipo := 'T';
  TS [12].Tipo := 'T';
  TS [13].Tipo := 'T';
  TS [14].Tipo := 'T';
  TS [15].Tipo := 'T';
  TS [16].Tipo := 'N';
  TS [17].Tipo := 'T';
  TS [18].Tipo := 'T';
  TS [19].Tipo := 'T';
  TS [20].Tipo := 'C';
  TS [21].Tipo := 'T';
  TS [22].Tipo := 'N';
  TS [23].Tipo := 'T';
  TS [24].Tipo := 'T';
  TS [25].Tipo := 'T';
  TS [26].Tipo := 'T';
  TS [27].Tipo := 'N';
  TS [28].Tipo := 'T';
  TS [29].Tipo := 'N';
  TS [30].Tipo := 'T';
  TS [31].Tipo := 'N';
  TS [32].Tipo := 'T';
  TS [33].Tipo := 'N';
  TS [34].Tipo := 'T';
  TS [35].Tipo := 'N';
  TS [36].Tipo := 'T';
  TS [37].Tipo := 'T';
  TS [38].Tipo := 'T';
  TS [39].Tipo := 'N';
  TS [40].Tipo := 'T';
  TS [41].Tipo := 'N';
  TS [42].Tipo := 'T';
  TS [43].Tipo := 'N';
  TS [44].Tipo := 'N';
  TS [45].Tipo := 'T';
  TS [46].Tipo := 'C';
  TS [47].Tipo := 'N';
  TS [48].Tipo := 'T';
  TS [49].Tipo := 'T';
  TS [50].Tipo := 'T';
  TS [51].Tipo := 'T';
  TS [52].Tipo := 'T';
  TS [53].Tipo := 'N';
  TS [54].Tipo := 'T';
  TS [55].Tipo := 'C';
  TS [56].Tipo := 'N';
  TS [57].Tipo := 'T';
  TS [58].Tipo := 'T';
  TS [59].Tipo := 'T';
  TS [60].Tipo := 'C';
  TS [61].Tipo := 'N';
  TS [62].Tipo := 'T';
  TS [63].Tipo := 'T';
  TS [64].Tipo := 'T';
  TS [65].Tipo := 'C';
  TS [66].Tipo := 'T';
  TS [67].Tipo := 'T';
  TS [68].Tipo := 'T';
  TS [69].Tipo := 'N';
  TS [70].Tipo := 'T';
  TS [71].Tipo := 'T';
  TS [72].Tipo := '&';
  TS [73].Tipo := '&';
  TS [74].Tipo := '&';
  TS [75].Tipo := '&';
  TS [76].Tipo := '&';
  TS [77].Tipo := '&';
  TS [78].Tipo := '&';
  TS [79].Tipo := '&';
  TS [80].Tipo := '&';

  TS [1].Nome := 'PROGRAMA';
  TS [2].Nome := 'PROGRAM';
  TS [3].Nome := 'IDENT';
  TS [4].Nome := ';';
  TS [5].Nome := 'BLOCO';
  TS [6].Nome := '.';
  TS [7].Nome := ' ';
  TS [8].Nome := 'BLOCO';
  TS [9].Nome := 'VAR';
  TS [10].Nome := 'IDENT';
  TS [11].Nome := ':';
  TS [12].Nome := ',';
  TS [13].Nome := 'INTEGER';
  TS [14].Nome := ';';
  TS [15].Nome := 'BEGIN';
  TS [16].Nome := 'COMANDO';
  TS [17].Nome := 'END';
  TS [18].Nome := ';';
  TS [19].Nome := ' ';
  TS [20].Nome := 'COMANDO';
  TS [21].Nome := 'BEGIN';
  TS [22].Nome := 'COMANDO';
  TS [23].Nome := ';';
  TS [24].Nome := 'END';
  TS [25].Nome := ';';
  TS [26].Nome := 'IF';
  TS [27].Nome := 'EXPRESSAO';
  TS [28].Nome := 'THEN';
  TS [29].Nome := 'COMANDO';
  TS [30].Nome := 'ELSE';
  TS [31].Nome := 'COMANDO';
  TS [32].Nome := 'WHILE';
  TS [33].Nome := 'EXPRESSAO';
  TS [34].Nome := 'DO';
  TS [35].Nome := 'COMANDO';
  TS [36].Nome := 'FOR';
  TS [37].Nome := 'IDENT';
  TS [38].Nome := ':=';
  TS [39].Nome := 'EXPRESSAO';
  TS [40].Nome := 'TO';
  TS [41].Nome := 'EXPRESSAO';
  TS [42].Nome := 'DO';
  TS [43].Nome := 'COMANDO';
  TS [44].Nome := 'EXPRESSAO';
  TS [45].Nome := ' ';
  TS [46].Nome := 'EXPRESSAO';
  TS [47].Nome := 'EXP_SIMP';
  TS [48].Nome := ':=';
  TS [49].Nome := '=';
  TS [50].Nome := '<';
  TS [51].Nome := '>';
  TS [52].Nome := '<>';
  TS [53].Nome := 'EXP_SIMP';
  TS [54].Nome := ' ';
  TS [55].Nome := 'EXP_SIMP';
  TS [56].Nome := 'TERMO';
  TS [57].Nome := '+';
  TS [58].Nome := '-';
  TS [59].Nome := ' ';
  TS [60].Nome := 'TERMO';
  TS [61].Nome := 'FATOR';
  TS [62].Nome := '*';
  TS [63].Nome := '/';
  TS [64].Nome := ' ';
  TS [65].Nome := 'FATOR';
  TS [66].Nome := 'IDENT';
  TS [67].Nome := 'CONST';
  TS [68].Nome := '(';
  TS [69].Nome := 'EXPRESSAO';
  TS [70].Nome := ')';
  TS [71].Nome := ' ';
  TS [72].Nome := ' ';
  TS [73].Nome := ' ';
  TS [73].Nome := ' ';
  TS [74].Nome := ' ';
  TS [75].Nome := ' ';
  TS [76].Nome := ' ';
  TS [77].Nome := ' ';
  TS [78].Nome := ' ';
  TS [79].Nome := ' ';
  TS [80].Nome := ' ';

  TS [1].NumNo := -1;
  TS [2].NumNo := 1;
  TS [3].NumNo := 2;
  TS [4].NumNo := 3;
  TS [5].NumNo := 4;
  TS [6].NumNo := 5;
  TS [7].NumNo := 6;
  TS [8].NumNo := -1;
  TS [9].NumNo := 1;
  TS [10].NumNo := 2;
  TS [11].NumNo := 3;
  TS [12].NumNo := 4;
  TS [13].NumNo := 5;
  TS [14].NumNo := 6;
  TS [15].NumNo := 7;
  TS [16].NumNo := 8;
  TS [17].NumNo := 9;
  TS [18].NumNo := 10;
  TS [19].NumNo := 11;
  TS [20].NumNo := -1;
  TS [21].NumNo := 1;
  TS [22].NumNo := 2;
  TS [23].NumNo := 3;
  TS [24].NumNo := 4;
  TS [25].NumNo := 5;
  TS [26].NumNo := 6;
  TS [27].NumNo := 7;
  TS [28].NumNo := 8;
  TS [29].NumNo := 9;
  TS [30].NumNo := 10;
  TS [31].NumNo := 11;
  TS [32].NumNo := 12;
  TS [33].NumNo := 13;
  TS [34].NumNo := 14;
  TS [35].NumNo := 15;
  TS [36].NumNo := 16;
  TS [37].NumNo := 17;
  TS [38].NumNo := 18;
  TS [39].NumNo := 19;
  TS [40].NumNo := 20;
  TS [41].NumNo := 21;
  TS [42].NumNo := 22;
  TS [43].NumNo := 23;
  TS [44].NumNo := 24;
  TS [45].NumNo := 25;
  TS [46].NumNo := -1;
  TS [47].NumNo := 1;
  TS [48].NumNo := 2;
  TS [49].NumNo := 3;
  TS [50].NumNo := 4;
  TS [51].NumNo := 5;
  TS [52].NumNo := 6;
  TS [53].NumNo := 7;
  TS [54].NumNo := 8;
  TS [55].NumNo := -1;
  TS [56].NumNo := 1;
  TS [57].NumNo := 2;
  TS [58].NumNo := 3;
  TS [59].NumNo := 4;
  TS [60].NumNo := -1;
  TS [61].NumNo := 1;
  TS [62].NumNo := 2;
  TS [63].NumNo := 3;
  TS [64].NumNo := 4;
  TS [65].NumNo := -1;
  TS [66].NumNo := 1;
  TS [67].NumNo := 2;
  TS [68].NumNo := 3;
  TS [69].NumNo := 4;
  TS [70].NumNo := 5;
  TS [71].NumNo := 6;
  TS [72].NumNo := -1;
  TS [73].NumNo := -1;
  TS [74].NumNo := -1;
  TS [75].NumNo := -1;
  TS [76].NumNo := -1;
  TS [77].NumNo := -1;
  TS [78].NumNo := -1;
  TS [79].NumNo := -1;
  TS [80].NumNo := -1;

  TS [1].Alt := -1;
  TS [2].Alt := 0;
  TS [3].Alt := 0;
  TS [4].Alt := 0;
  TS [5].Alt := 0;
  TS [6].Alt := 0;
  TS [7].Alt := 0;
  TS [8].Alt := -1;
  TS [9].Alt := 0;
  TS [10].Alt := 0;
  TS [11].Alt := 4;
  TS [12].Alt := 0;
  TS [13].Alt := 0;
  TS [14].Alt := 0;
  TS [15].Alt := 0;
  TS [16].Alt := 0;
  TS [17].Alt := 10;
  TS [18].Alt := 0;
  TS [19].Alt := -1;
  TS [20].Alt := -1;
  TS [21].Alt := 6;
  TS [22].Alt := 0;
  TS [23].Alt := 4;
  TS [24].Alt := 0;
  TS [25].Alt := 25;
  TS [26].Alt := 12;
  TS [27].Alt := 0;
  TS [28].Alt := 0;
  TS [29].Alt := 0;
  TS [30].Alt := 25;
  TS [31].Alt := 0;
  TS [32].Alt := 16;
  TS [33].Alt := 0;
  TS [34].Alt := 0;
  TS [35].Alt := 0;
  TS [36].Alt := 24;
  TS [37].Alt := 0;
  TS [38].Alt := 0;
  TS [39].Alt := 0;
  TS [40].Alt := 0;
  TS [41].Alt := 0;
  TS [42].Alt := 0;
  TS [43].Alt := 0;
  TS [44].Alt := 0;
  TS [45].Alt := -1;
  TS [46].Alt := -1;
  TS [47].Alt := 0;
  TS [48].Alt := 3;
  TS [49].Alt := 4;
  TS [50].Alt := 5;
  TS [51].Alt := 6;
  TS [52].Alt := 0;
  TS [53].Alt := 0;
  TS [54].Alt := -1;
  TS [55].Alt := -1;
  TS [56].Alt := 0;
  TS [57].Alt := 3;
  TS [58].Alt := 4;
  TS [59].Alt := -1;
  TS [60].Alt := -1;
  TS [61].Alt := 0;
  TS [62].Alt := 3;
  TS [63].Alt := 4;
  TS [64].Alt := -1;
  TS [65].Alt := -1;
  TS [66].Alt := 2;
  TS [67].Alt := 3;
  TS [68].Alt := 6;
  TS [69].Alt := 0;
  TS [70].Alt := 0;
  TS [71].Alt := -1;
  TS [72].Alt := -1;
  TS [73].Alt := -1;
  TS [74].Alt := -1;
  TS [75].Alt := -1;
  TS [76].Alt := -1;
  TS [77].Alt := -1;
  TS [78].Alt := -1;
  TS [79].Alt := -1;
  TS [80].Alt := -1;

  TS [1].Suc := -1;
  TS [2].Suc := 2;
  TS [3].Suc := 3;
  TS [4].Suc := 4;
  TS [5].Suc := 5;
  TS [6].Suc := 6;
  TS [7].Suc := 0;
  TS [8].Suc := -1;
  TS [9].Suc := 2;
  TS [10].Suc := 3;
  TS [11].Suc := 5;
  TS [12].Suc := 2;
  TS [13].Suc := 6;
  TS [14].Suc := 7;
  TS [15].Suc := 8;
  TS [16].Suc := 9;
  TS [17].Suc := 11;
  TS [18].Suc := 8;
  TS [19].Suc := -1;
  TS [20].Suc := 2;
  TS [21].Suc := 3;
  TS [22].Suc := 2;
  TS [23].Suc := 5;
  TS [24].Suc := 5;
  TS [25].Suc := 25;
  TS [26].Suc := 7;
  TS [27].Suc := 8;
  TS [28].Suc := 9;
  TS [29].Suc := 10;
  TS [30].Suc := 11;
  TS [31].Suc := 25;
  TS [32].Suc := 13;
  TS [33].Suc := 14;
  TS [34].Suc := 15;
  TS [35].Suc := 25;
  TS [36].Suc := 17;
  TS [37].Suc := 18;
  TS [38].Suc := 19;
  TS [39].Suc := 20;
  TS [40].Suc := 21;
  TS [41].Suc := 22;
  TS [42].Suc := 23;
  TS [43].Suc := 25;
  TS [44].Suc := 25;
  TS [45].Suc := -1;
  TS [46].Suc := -1;
  TS [47].Suc := 2;
  TS [48].Suc := 7;
  TS [49].Suc := 7;
  TS [50].Suc := 7;
  TS [51].Suc := 7;
  TS [52].Suc := 7;
  TS [53].Suc := 8;
  TS [54].Suc := -1;
  TS [55].Suc := -1;
  TS [56].Suc := 2;
  TS [57].Suc := 1;
  TS [58].Suc := 1;
  TS [59].Suc := -1;
  TS [60].Suc := -1;
  TS [61].Suc := 2;
  TS [62].Suc := 1;
  TS [63].Suc := 1;
  TS [64].Suc := -1;
  TS [65].Suc := -1;
  TS [66].Suc := 6;
  TS [67].Suc := 6;
  TS [68].Suc := 4;
  TS [69].Suc := 0;
  TS [70].Suc := 0;
  TS [71].Suc := -1;
  TS [72].Suc := -1;
  TS [73].Suc := -1;
  TS [74].Suc := -1;
  TS [75].Suc := -1;
  TS [76].Suc := -1;
  TS [77].Suc := -1;
  TS [78].Suc := -1;
  TS [79].Suc := -1;
  TS [80].Suc := -1;

  IndTS := 71;

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