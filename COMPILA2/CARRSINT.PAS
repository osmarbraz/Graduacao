Program Carregador_Sintatico;
Uses Crt;
Const
  NUMERO = 13;

Type
  Str2 = String[2];
  RTABSINT = Record
               TIPO      : Str2;
               NOMETS    : Str2;
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
               NOMET   : Str2;
             End;
  RTABNT   = Record
               NOMENT  : Str2;
               PRIM    : Integer;
             End;

Var
   TABSINT                       : Array [1..NUMERO] of RTABSINT;
   TABGRAFO                      : Array [1..NUMERO] of RTABGRAFO;
   TABT                          : Array [1..NUMERO] of RTABT;
   TABNT                         : Array [1..NUMERO] of RTABNT;
   MAXT, MAXNT, INDPRIM, NOMAX   : Integer;
   INDTS, J, I, E                : Integer;


(**********Function Verifica se Esta na TABNT *******************)
Function EncontraNaTABNT (NOME : Str2) : Boolean;
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
Function EncontraNaTABT (NOME : Str2) : Boolean;
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


Begin

(************ Dados da Matriz TABSINT **************************)
    TABSINT[1].TIPO   := 'C';
    TABSINT[1].NOMETS := 'S';
    TABSINT[1].NUMNO  := -1;
    TABSINT[1].ALTTS  := -1;
    TABSINT[1].SUCTS  := -1;

    TABSINT[2].TIPO   := 'T';
    TABSINT[2].NOMETS := 'a';
    TABSINT[2].NUMNO  := 1;
    TABSINT[2].ALTTS  := 5;
    TABSINT[2].SUCTS  := 2;

    TABSINT[3].TIPO   := 'T';
    TABSINT[3].NOMETS := 'b';
    TABSINT[3].NUMNO  := 2;
    TABSINT[3].ALTTS  := 3;
    TABSINT[3].SUCTS  := 0;

    TABSINT[4].TIPO   := 'N';
    TABSINT[4].NOMETS := 'S';
    TABSINT[4].NUMNO  := 3;
    TABSINT[4].ALTTS  := 0;
    TABSINT[4].SUCTS  := 4;

    TABSINT[5].TIPO   := 'T';
    TABSINT[5].NOMETS := 'c';
    TABSINT[5].NUMNO  := 4;
    TABSINT[5].ALTTS  := 0;
    TABSINT[5].SUCTS  := 0;

    TABSINT[6].TIPO   := 'T';
    TABSINT[6].NOMETS := 'd';
    TABSINT[6].NUMNO  := 5;
    TABSINT[6].ALTTS  := 7;
    TABSINT[6].SUCTS  := 6;

    TABSINT[7].TIPO   := 'N';
    TABSINT[7].NOMETS := 'M';
    TABSINT[7].NUMNO  := 6;
    TABSINT[7].ALTTS  := 0;
    TABSINT[7].SUCTS  := 0;

    TABSINT[8].TIPO   := 'T';
    TABSINT[8].NOMETS := 'e';
    TABSINT[8].NUMNO  := 7;
    TABSINT[8].ALTTS  := 0;
    TABSINT[8].SUCTS  := 0;

    TABSINT[9].TIPO   := 'C';
    TABSINT[9].NOMETS := 'M';
    TABSINT[9].NUMNO  := -1;
    TABSINT[9].ALTTS  := -1;
    TABSINT[9].SUCTS  := -1;

    TABSINT[10].TIPO   := 'T';
    TABSINT[10].NOMETS := 'f';
    TABSINT[10].NUMNO  := 1;
    TABSINT[10].ALTTS  := 3;
    TABSINT[10].SUCTS  := 2;

    TABSINT[11].TIPO   := 'N';
    TABSINT[11].NOMETS := 'S';
    TABSINT[11].NUMNO  := 2;
    TABSINT[11].ALTTS  := 0;
    TABSINT[11].SUCTS  := 1;

    TABSINT[12].TIPO   := 'T';
    TABSINT[12].NOMETS := '';
    TABSINT[12].NUMNO  := 3;
    TABSINT[12].ALTTS  := 0;
    TABSINT[12].SUCTS  := 0;

    TABSINT[13].TIPO   := '';
    TABSINT[13].NOMETS := '';
    TABSINT[13].NUMNO  := -1;
    TABSINT[13].ALTTS  := -1;
    TABSINT[13].SUCTS  := -1;

(************* Inicializacao das Variaveis ********************)
   Clrscr;

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
                    {Erro (dois cabecas para um mesmo terminal) }
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

           IF (TABSINT[INDTS].NOMETS = '') Then
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

     Writeln('TABSINT');
     For J := 1 to Numero do
       Begin
        WRITElN(TABSINT[J].TIPO,' - ',TABSINT[J].NOMETS,' - ',
          TABSINT[J].NUMNO,' - ',TABSINT[J].ALTTS,' - ',TABSINT[J].SUCTS);
       End;

     READLN;

     Writeln('TABGRAFO');
     For J := 1 to Numero do
       Begin
        WRITElN(TABGRAFO[J].TER,' - ',TABGRAFO[J].SIM,' - ',
          TABGRAFO[J].ALTTG,' - ',TABGRAFO[J].SUCTG);
       End;

     READLN;

     Writeln('TABT');
     For J := 1 to Numero do
       Begin
        WRITElN(TABT[J].NOMET);
       End;

     READLN;

     Writeln('TABNT');
     For J := 1 to Numero do
       Begin
        WRITElN(TABNT[J].NOMENT,' - ',TABNT[J].PRIM);
       End;
    READLN;
End.