Unit Proc;
INTERFACE
   Uses Crt, Graph, Mouse;

   Const
        Brancoforte   = 15       ;
        Brancofraco   = 7        ;
        Preto         = 0        ;
        Azulescuro    = 1        ;
        Azulclaro     = 9        ;
        Vermelhoforte = 4        ;
        Vermelhoclaro = 12       ;
        Verdeclaro    = 10       ;
        Ciano         = 11       ;
        Amarelo       = 14       ;
        Cinza         = 24       ;
        Cor           : Byte = 4 ;

   Var
        Botao         : Integer  ;
        Tecla         : Char     ;

   Procedure LigaMouse ;
   Procedure Letra(_paslet,_pasposi,_pastamanho:Word);
   Procedure Say(_paslinha,_pascoluna:Word ; _pasmensagem:String);
   Procedure Say3D(_paslinha,_pascoluna:Word ; _pasmensagem:String ; _pasCor1,_pasCor2:Word);
   Procedure Moldura(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2:Word ; Sombrear:Boolean);
   Procedure Icone(_paslin1,_pascol1,_paslin2,_pascol2 : Word  ;
             _pasicone:String ; _pascor1,_pascor2,_pascoricone,_pascorletra:Word ; _pasletra:Char);
   Procedure Icone1(_paslin1,_pascol1,_paslin2,_pascol2 : Word  ;
             _pasic1,_pasic2,_pasic3:String ; _pascor1,_pascor2,_pascoricone,_pascorletra:Word ; _pasletra:Char);
   Function Area(aL1,aC1,aL2,aC2:Integer;Letra:Char) : Boolean ;
   Procedure Clica(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2 : Word);
   Procedure Vasado(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2:Word);
   Procedure Caixa(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2,_pascor3:Word);
   Function  Palavra(_paslin,_pascol,Tam,_pasCorLetra,_pasCorFundo:Word):String;
   Procedure AddKbdBuf(cmd : String);
   Procedure LimpaBufferTeclado;

IMPLEMENTATION
{---------------------------------------------------------------------------}
Procedure Ligamouse;
Begin
   Mousereset;
   Mousecursor(True);
End;
{----------------------------------------------------------------------------}
Procedure Letra(_paslet,_pasposi,_pastamanho:Word);
Begin
   Settextstyle(_paslet,_pasposi,_pastamanho);
End;
{----------------------------------------------------------------------------}
Procedure Say(_paslinha,_pascoluna:Word ; _pasmensagem:String);
Begin
   Outtextxy(_pascoluna,_paslinha,_pasmensagem);
End;
{----------------------------------------------------------------------------}
Procedure Say3D(_paslinha,_pascoluna:Word ; _pasmensagem:String ; _pasCor1,_pasCor2:Word);
Begin
   SetColor(_pasCor2);
   Outtextxy(_pascoluna+2,_paslinha+2,_pasmensagem);
   SetColor(_pasCor1);
   Outtextxy(_pascoluna,_paslinha,_pasmensagem);
End;
{----------------------------------------------------------------------------}
Procedure Moldura(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2:Word ; Sombrear:Boolean);
Begin
   Bar(_pascol1,_paslin1,_pascol2,_paslin2);              {Limpa Area Da Moldura}

   Setcolor(_pascor1);
   Line(_pascol1   ,_paslin1   ,_pascol2   ,_paslin1  );  {Linha Superior}
   Line(_pascol1   ,_paslin1   ,_pascol1   ,_paslin2  );  {Coluna Esquerda}
   Line(_pascol1+5 ,_paslin2-5 ,_pascol2-5 ,_paslin2-5);  {Coluna Direita}
   Line(_pascol2-5 ,_paslin1+5 ,_pascol2-5 ,_paslin2-5);  {Linha Inferior}
   Setcolor(_pascor2);
   Line(_pascol1   ,_paslin2   ,_pascol2   ,_paslin2)  ;  {Linha Inferior}
   Line(_pascol2   ,_paslin1   ,_pascol2   ,_paslin2)  ;  {Coluna Direita}
   Line(_pascol1+5 ,_paslin1+5 ,_pascol2-5 ,_paslin1+5);  {Linha Superior}
   Line(_pascol1+5 ,_paslin1+5 ,_pascol1+5 ,_paslin2-5);  {Coluna Esquerda}
   If Sombrear Then
   Begin
      Setfillstyle(1,_pascor2);
      Bar(_pascol2+1 ,_paslin1+10,_pascol2+10,_paslin2+10); {Sombrea Direita}
      Bar(_pascol1+10,_paslin2+1 ,_pascol2+10,_paslin2+10); {Sombrea Em Baixo}
   End;
End;
{----------------------------------------------------------------------------}
Procedure Icone(_paslin1,_pascol1,_paslin2,_pascol2 : Word  ;
          _pasicone:String ; _pascor1,_pascor2,_pascoricone,_pascorletra:Word ; _pasletra:Char);
Var
   Posicaolin, Posicaocol, I, J : Word;
   Variavel                     : String;
   Achou                        : Boolean;
Begin
   SetColor(_pascor1);
   Bar(_pascol1,_paslin1,_pascol2,_paslin2);

   Line(_pascol1   ,_paslin1   ,_pascol2   ,_paslin1  );  {Linha Superior}
   Line(_pascol1   ,_paslin1   ,_pascol1   ,_paslin2  );  {Coluna Esquerda}

   SetColor(_pascor2);
   Line(_pascol2   ,_paslin1   ,_pascol2   ,_paslin2  );  {Coluna Direita}
   Line(_pascol1   ,_paslin2   ,_pascol2   ,_paslin2  );  {Linha Inferior}

   SetColor(Cinza);
   Line(_pascol2-1 ,_paslin1+1 ,_pascol2-1 ,_paslin2-1);  {Coluna Direita}
   Line(_pascol1+1 ,_paslin2-1 ,_pascol2-1 ,_paslin2-1);  {Linha Inferior}

   SetColor(_pascoricone);
   Posicaolin:=((_paslin1+_paslin2) Div 2)-3;
   Posicaocol:=((_pascol1+_pascol2) Div 2)-((Length(_pasicone) Div 2) * 8) + 2;

   {Acha Letra Para Diferenciar Icone}
   I:=0;
   Achou:=False;
   While Not Achou Do
   Begin
      Inc(I);
      If (Ord(Upcase(_pasicone[I])) = Ord(Upcase(_pasletra))) Or (I > Length(_pasicone)) Then Achou:=True;
   End;

   If I = 1 Then
      I:=(I+Posicaocol)-1
   Else
      I:=((I*8)+Posicaocol)-8;  {Acha Posicao Correta Da Letra}

   Say(Posicaolin,Posicaocol,_pasicone);
   Say(Posicaolin+2,I,'_');
   SetColor(_pascorletra);
   Say(Posicaolin,I,_pasletra);
End;
{----------------------------------------------------------------------------}
Procedure Icone1(_paslin1,_pascol1,_paslin2,_pascol2 : Word  ;
          _pasic1,_pasic2,_pasic3:String ; _pascor1,_pascor2,_pascoricone,_pascorletra:Word ; _pasletra:Char);
Var
   PLin1, PLin2, PLin3, PCol1, PCol2, PCol3, I, J, Linha, Coluna : Word;
   Variavel                                                      : String;
   Achou                                                         : Boolean;

Begin
   Setcolor(_pascor1);
   Bar(_pascol1,_paslin1,_pascol2,_paslin2);

   Line(_pascol1   ,_paslin1   ,_pascol2   ,_paslin1  );  {Linha Superior}
   Line(_pascol1   ,_paslin1   ,_pascol1   ,_paslin2  );  {Coluna Esquerda}

   SetColor(_pascor2);
   Line(_pascol2   ,_paslin1   ,_pascol2   ,_paslin2  );  {Coluna Direita}
   Line(_pascol1   ,_paslin2   ,_pascol2   ,_paslin2  );  {Linha Inferior}

   SetColor(Cinza);
   Line(_pascol2-1 ,_paslin1+1 ,_pascol2-1 ,_paslin2-1);  {Coluna Direita}
   Line(_pascol1+1 ,_paslin2-1 ,_pascol2-1 ,_paslin2-1);  {Linha Inferior}

   SetColor(_pasCorIcone);
   J:=6;
   If Length(_pasIc3) = 0 Then
   Begin
      J:=3;
   End;

   I:=((_pasLin2-_pasLin1) Div 3)-J;
   PLin1:=_pasLin1+I;
   PLin2:=PLin1+I;
   PLin3:=PLin2+I;

   PCol1:=((_pasCol1+_pasCol2) Div 2)-((Length(_pasIc1) Div 2) * 8) + 1;
   PCol2:=((_pasCol1+_pasCol2) Div 2)-((Length(_pasIc2) Div 2) * 8) + 1;
   PCol3:=((_pasCol1+_pasCol2) Div 2)-((Length(_pasIc3) Div 2) * 8) + 1;

   {Acha Letra Para Diferenciar Icone}
   I:=0;
   Achou:=False;
   While Not Achou Do
   Begin
      Inc(I);
      If (Ord(UpCase(_pasIc1[I])) = Ord(UpCase(_pasLetra))) Or (I > Length(_pasIc1)) Then
      Begin
         Achou:=True;
         Linha:=PLin1;
         Coluna:=PCol1;
      End;
   End;

   If I > Length(_pasIc1) Then      {Se a Letra Estiver Na Segunda Linha}
   Begin
      I:=0;
      Achou:=False;
      While Not Achou Do
      Begin
         Inc(I);
         If (Ord(UpCase(_pasIc2[I])) = Ord(UpCase(_pasLetra))) Or (I > Length(_pasIc2)) Then
         Begin
            Achou:=True;
            Linha:=PLin2;
            Coluna:=PCol2;
         End;
      End;
   End;

   If I > Length(_pasIc2) Then      {Se a Letra Estiver Na Terceira Linha}
   Begin
      I:=0;
      Achou:=False;
      While Not Achou Do
      Begin
         Inc(I);
         If (Ord(UpCase(_pasIc3[I])) = Ord(UpCase(_pasLetra))) Or (I > Length(_pasIc3)) Then
         Begin
            Achou:=True;
            Linha:=PLin3;
            Coluna:=PCol3;
         End;

      End;
   End;


   If I = 1 Then
      I:=(I+Coluna)-1
   Else
      I:=((I*8)+Coluna)-8;  {Acha Posicao Correta da Letra}

   Say(PLin1,PCol1,_pasIc1);
   Say(PLin2,PCol2,_pasIc2);
   Say(PLin3,PCol3,_pasIc3);
   Say(Linha+2,I,'_');
   SetColor(_pasCorLetra);
   Say(Linha,I,_pasLetra);
End;
{----------------------------------------------------------------------------}
Function Area(aL1,aC1,aL2,aC2:Integer; Letra:Char) : Boolean ;
Var
   MouseAreaX, MouseAreaY : Integer;
   Tecla1,Retorno         : Boolean ;
Begin
   Botao:=1;
   Retorno:=MousePressed(1,Botao,MouseAreaX,MouseAreaY);

   Tecla1:=KeyPressed;
   If Tecla1 Then Tecla:=ReadKey;

   Area:=False;
   If (Retorno) And ((MouseAreaY >= aL1) And (MouseAreaY <= aL2) And (MouseAreaX >= aC1) And
      (MouseAreaX <= aC2)) Or (UpCase(Tecla)=Letra) Then Area:=True;
End;
{----------------------------------------------------------------------------}
Procedure Clica(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2 : Word);
Var
   Posicaolin, Posicaocol : Word;
   Variavel               : String;
Begin
   MouseCursor(False);  {Desliga Mouse}

   Bar(_pascol1+1  ,_paslin2-1 ,_pascol2-1 ,_paslin2-1);
   Bar(_pascol2-1  ,_paslin1+1 ,_pascol2-1 ,_paslin2-1);


   SetColor(_pascor2);
   Line(_pascol1   ,_paslin1   ,_pascol2   ,_paslin1  );  {Linha Superior}
   Line(_pascol1   ,_paslin1   ,_pascol1   ,_paslin2  );  {Coluna Esquerda}

   SetColor(_pascor1);
   Line(_pascol2   ,_paslin1   ,_pascol2   ,_paslin2  );  {Coluna Direita}
   Line(_pascol1   ,_paslin2   ,_pascol2   ,_paslin2  );  {Linha Inferior}

   SetColor(Cinza);
   Line(_pascol1+1 ,_paslin1+1 ,_pascol1+1 ,_paslin2-1);  {Coluna Esquerda}
   Line(_pascol1+1 ,_paslin1+1 ,_pascol2-1 ,_paslin1+1);  {Linha Superior}

   MouseCursor(True); {Liga Mouse}
End;
{---------------------------------------------------------------------------}
Procedure Vasado(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2:Word);

Begin
   SetColor(_pascor1);
   Rectangle(_pascol1,_paslin1,_pascol2,_paslin2);

   SetColor(_pascor2);
   Rectangle(_pascol1-1,_paslin1-1,_pascol2-1,_paslin2-1);

   SetColor(_pascor1);
   Line(_pascol2-20 ,_paslin1 ,_pascol2 ,_paslin1);  {Linha Inferior}
End;
{---------------------------------------------------------------------------}
Procedure Caixa(_paslin1,_pascol1,_paslin2,_pascol2,_pascor1,_pascor2,_pascor3:Word);
Begin
   SetColor(_pascor1);
   Rectangle(_pascol1,_paslin1,_pascol2,_paslin2);

   SetFillStyle(1,BrancoForte{_pascor3});
{   SetColor(_pascor3);}
   Bar(_pascol1+1,_paslin1+1,_pascol2-1,_paslin2-1);

   SetColor(_pascor2);
   Line(_pascol1+2,_paslin1+2,_pascol2-1,_paslin1+2); {Linha Superior}
   Line(_pascol1+2,_paslin1+2,_pascol1+2,_paslin2-2); {Coluna Esquerda}
   Line(_pascol1+2,_paslin2-1,_pascol2-2,_paslin2-1); {Linha Superior}
   Line(_pascol2-1,_paslin1+1,_pascol2-1,_paslin2-1); {Coluna Direita}

   SetColor(_pascor3);
   Line(_pascol1+1,_paslin1+1,_pascol2-2,_paslin1+1); {Linha Superior}
   Line(_pascol1+1,_paslin1+1,_pascol1+1,_paslin2-1); {Coluna Esquerda}

End;
{---------------------------------------------------------------------------}
Function Palavra(_paslin,_pascol,Tam,_pasCorLetra,_pasCorFundo:Word):String;
Var
   i,o             : Word     ;
   Letra           : Char     ;
   Resultado,Limpa : String   ;
Begin
   For o := 1 to Tam Do Limpa:=Limpa+'Û';

   Resultado:='';
   i:=1;

   While True Do
   Begin
      Letra:=ReadKey ;
      If (Letra = #13) Then
      Begin
         Palavra:=Resultado;
         Exit;
      End;

      Case Letra Of
      ' ' .. '~'    : Begin      {Letras}
                         Resultado:=Resultado+Letra;
                         Inc(i);
                      End;
      Chr(4)        : Begin      {Seta Esquerda}
                         For o := 1 to (I-1) Do Resultado:=Resultado[o];
                         Dec(i);
                         SetColor(_pasCorFundo);
                         Say(_paslin,_pascol,Limpa);
                      End;
      Chr(8)        : Begin      {Seta BackEspace}
                         For o := 1 to (I-1) Do Resultado:=Resultado[o];
                         Dec(i);
                         SetColor(_pasCorFundo);
                         Say(_paslin,_pascol,Limpa);
                      End;

      End;

      SetColor(_pasCorLetra);
      Say(_paslin,_pascol,Resultado);

      If (i = Tam) Then
      Begin
         Palavra:=Resultado;
         Exit;
      End;
   End;
End;
{---------------------------------------------------------------------------}
Procedure AddKbdBuf(cmd : String);
Var
  i    : byte;
  Head : byte absolute $0040:$001A;  { Aponta para o inicio do buffer }
  Tail : byte absolute $0040:$001C;  { Aponta para o fim do buffer    }
  Buff : array[$1E..$3D] of char absolute $0040:$001E; { Buffer de teclado }
Begin
  For i := 1 to Length(cmd) do Begin
    buff[Tail] := cmd[i];
    inc(Tail, 2);
    If (Tail > $3C) then Tail := $1E;
    If (Tail = Head) then Begin  { Buffer est  cheio }
      dec(Tail,2);
      exit;
    End;
  End;
End;
{---------------------------------------------------------------------------}
Procedure LimpaBufferTeclado;
Begin
   Mem[$0040:$001A] := Mem[$0040:$001C];
End;
{---------------------------------------------------------------------------}
End.