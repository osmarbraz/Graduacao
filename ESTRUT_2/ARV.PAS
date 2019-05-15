Program Arvore;
Uses Graph,Crt,Mouse,Proc;
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

Type
    Coordenadas = ^ Coordenada;
    Coordenada  = Record
                    X,Y       : Integer;
                    Prox      : Coordenadas;
                  End;
    Strings     = String [5];
    Listas      = Record
                     Primeiro, Ultimo   : Coordenadas;
                     Tamanho            : Byte;
                  End;
    Vetor       = Array [1..70] Of Integer;

Var
   Driver,Mode                   : Integer;
   Coord                         : Coordenadas;
   Fila                          : Listas;
   Vet                           : Vetor;
   X,Y,X2,Y2,X0                  : Integer;
   Tecla,Caracter                : Char;
   Cont                          : Integer;
   Strg,Aux                      : String [12];
   Tamanho,I,J                   : Byte;
   Erro                          : Integer;
   A,B,Tam                       : Integer;
   Sair, Ok                      : Boolean;
   Botao, L1, C1, L2, C2, x1, y1 : Integer;
   Variavel                      : String;
   Opcao                         : Word;
   Tecla1                        : Boolean;

{----------------------------------------------------------------------------}
Procedure Quadrof (X,Y,X2,Y2,Tam : Integer;Corfundo : Byte);
Var
 I,J : Integer;
Begin
 Setfillstyle (1,Corfundo);
 Bar (X-Tam,Y-Tam,X2+Tam,Y2+Tam);
 Setfillstyle (1,15);
 Setcolor (8);
 Line (X,Y,X2,Y);
 Line (X2,Y,X2,Y2);
 Line (X-Tam,Y-Tam,X-Tam,Y2+Tam);
 Line (X-Tam,Y2+Tam,X2+Tam,Y2+Tam);
 Setcolor (15);
 Line (X,Y,X,Y2);
 Line (X,Y2,X2,Y2);
 Line (X-Tam,Y-Tam,X2+Tam,Y-Tam);
 Line (X2+Tam,Y-Tam,X2+Tam,Y2+Tam);
End;
{----------------------------------------------------------------------------}
Procedure Quadros (X,Y,X2,Y2,Tam : Integer);
Begin
  Setcolor (8);
  Line (X,Y,X2,Y);
  Line (X2,Y,X2,Y2);
  Line (X-Tam,Y-Tam,X-Tam,Y2+Tam);
  Line (X-Tam,Y2+Tam,X2+Tam,Y2+Tam);
  Setcolor (15);
  Line (X,Y,X,Y2);
  Line (X,Y2,X2,Y2);
  Line (X-Tam,Y-Tam,X2+Tam,Y-Tam);
  Line (X2+Tam,Y-Tam,X2+Tam,Y2+Tam);
End;
{----------------------------------------------------------------------------}
Procedure Abertura;
Begin
   ClearDevice;
   SetFillStyle(3,AzulEscuro);
   Bar(00,00,800,750);

   LigaMouse;
   CurHand;
   MouseMoveTo(350,460);

   SetFillStyle(1,Cinza);
   Moldura(20,30,300,600,BrancoFraco,Preto,False);

   SetFillStyle(1,BrancoForte);
   SetColor(BrancoForte);
   Letra(8,0,10);
   Line(95,50,125,30); {Acento da Letra A}
   Say(10,50,'ARVORE');
   SetColor(Ciano);
   Letra(4,0,4);
   Say(170,50,'Alunos:');
   SetColor(Amarelo);
   Letra(7,0,3);
   Say(210,180,'Maira Alessandra Ascari');
   Say(235,180,'Ramon Oliveira Gabriel');
   Say(260,180,'Roberto Jos‚ Gon‡alves');

   {Icone}
   SetFillStyle(1,BrancoFraco);
   Moldura(350,10,420,630,BrancoForte,Preto,False);

   Letra(12,0,20);
   SetLineStyle(1,0,4);
   SetFillStyle(1,BrancoFraco);
   Icone(376,220,397,380,'Iniciar',BrancoForte,Preto,AzulEscuro,VermelhoForte,'I');

   While Not Ok Do
   Begin
      Tecla1:=KeyPressed;
      If Tecla1 Then Tecla:=ReadKey;
      If Area(376,220,397,380,'I') Then
      Begin
         Ok:=True;
         Opcao:=1;
      End;
   End;

   CurHourGlass;
   Case Opcao Of
        1 : Clica(376,220,397,380,BrancoForte,Preto);
   End;
   Delay(1000);
End;
{----------------------------------------------------------------------------}
Procedure Circulo (X,Y : Integer; Numero : Strings );
Var
 Tamanho : Byte;
 Cor_or  : Word;
Begin
 Cor_or := Getcolor;
 Tamanho := Length (Numero);
 If Numero <> '-1' Then
 Case Tamanho Of
  1  : Begin
        Setcolor (Cor);
        Circle (X,Y,11);
        {Circle (X,Y,12);}
        Setfillstyle (1,7);
        Floodfill (X,Y,Cor);
        Setcolor (Cor);
        Outtextxy (X-3,Y-6,Numero);
       End;
  2  : Begin
        Setcolor (Cor);
        Circle (X,Y,11);
        Setfillstyle (1,7);
        Floodfill (X,Y,Cor);
        Setcolor (Cor);
        Outtextxy (X-5,Y-6,Numero);
       End;
  3  : Begin
        Setcolor (Cor);
        Circle (X,Y,11);
        Setfillstyle (1,7);
        Floodfill (X,Y,Cor);
        Setcolor (Cor);
        Outtextxy (X-8,Y-6,Numero);
       End;
 End;
End;
{----------------------------------------------------------------------------}
Procedure Enfileira (X,Y : Integer);
Var
 Aux,Aux2    : Coordenadas;
Begin
 New (Aux);
 Aux^.X    := X;
 Aux^.Y    := Y;
 Aux^.Prox := Nil;
 If Fila.Tamanho = 0 Then
 Begin
  Coord := Aux;
  Fila.Primeiro := Aux;
  Fila.Ultimo   := Aux;
  Fila.Tamanho  := 1;
 End
 Else
 Begin
  Aux2 := Fila.Ultimo;
  Aux2^.Prox := Aux;
  Fila.Ultimo := Aux;
  Inc (Fila.Tamanho);
 End;
End;
{----------------------------------------------------------------------------}
Procedure Desenfileira (Var X,Y : Integer);
Var
 Aux       : Coordenadas;
Begin
 If Fila.Tamanho > 0 Then
 Begin
  Aux := Fila.Primeiro;
  X := Aux^.X;
  Y := Aux^.Y;
  Coord := Coord^.Prox;
  Fila.Primeiro := Coord;
  Dec (Fila.Tamanho);
 End
 Else
 Begin
  X := 0;
  Y := 0;
 End;
End;
{----------------------------------------------------------------------------}
Begin
   Fila.Primeiro := Nil;
   Fila.Ultimo   := Nil;
   Fila.Tamanho  := 0;
   Driver := Detect;
   Mode := 2;
   Initgraph (Driver,Mode,'c:\compila\pascal70\bgi');
   Abertura;

   ClearDevice;
   MouseCursor(False); {Desabilita Mouse}

   {Moldura Principal}
   SetFillStyle(1,AzulEscuro);
   Moldura(000,000,GetMaxY,GetMaxX,BrancoFraco,Cinza,False);

   MouseCursor(True); {Liga Cursor}
   CurStandard;
   MouseMoveTo(500,414);

   SetColor(Amarelo);
   Letra(4,0,5);
   Say(05,170,'Arvore Bin ria');
   Line(20,60,615,60);

   {Barra de Status}
   SetFillStyle(1,VermelhoForte);
   Moldura(430,020,460,620,BrancoFraco,Preto,True);
   Letra(12,0,20);
   SetColor(BrancoForte);
   Say(441,100,'Digite Os N£meros da Arvore. Obs.: M ximo de 63 Elementos');

   {Icone de Ok}
   Letra(12,0,20);
   SetLineStyle(1,0,4);
   SetFillStyle(1,BrancoFraco);
   Icone(376,400,407,630,'<Enter>-Constroi Arvore',BrancoForte,Preto,AzulEscuro,VermelhoForte,'C');

   SetTextStyle(2,0,6);
   X  := 32;
   Y  := 75;
   X2 := 82;
   Y2 := 105;
   I := 0;
   Caracter := #95;
   Ok:=False;
   Repeat
      Inc (I);
      Quadrof (X,Y,X2,Y2,3,7);
      Cont := 0;
      Strg := '';
      A := X + 10;
      B := Y + 5;
      Setcolor (15);
      Outtextxy (A,B,Caracter);
      Inc (X, 8);
      Inc (X2,8);
      X0 := A;
      Repeat
         Tecla:=ReadKey;
         Case Tecla Of
              '0'..'9' : Begin
                            Inc (Cont);
                            If Cont < 4 Then
                            Begin
                               Strg := Strg + Tecla;
                               Setcolor (7);
                               Outtextxy (A,B,Caracter);
                               Setcolor (1);
                               Outtextxy (A,B,Tecla);
                               Inc (A,10);
                               If Cont < 3 Then
                               Begin
                                  Setcolor (15);
                                  Outtextxy (A,B,Caracter);
                               End;
                            End
                            Else Dec (Cont);
                            End;

              #8     : Begin
                          If Cont = 0 Then Cont := 1;
                          Dec (Cont);
                          If Cont < 3 Then
                          Begin
                             Setcolor (7);
                             Outtextxy (A,B,Caracter);
                          End;
                          Tamanho := Length (Strg);
                          Aux := Copy (Strg,Tamanho,1);
                          Strg := Copy (Strg,1,(Tamanho - 1));
                          Setcolor (7);
                          Dec (A,10);
                          If A < X0 Then A := X0;
                          Outtextxy (A,B,Aux);
                          Setcolor (15);
                          Outtextxy (A,B,Caracter);
                       End;
         End;
      Until (Tecla = #13);

      SetColor(7);
      Outtextxy (A,B,Caracter);
      If Strg = '' Then
      Begin
         Strg := '-1';
         Setcolor (9);
         SetTextStyle (8,0,3);
         Outtextxy (150,200,'Nenhum Valor Indicado');
         Settextstyle (2,0,6);
         SetColor (8);
      End;
      Val (Strg,Vet [I],Erro);
      If Vet [I] = -1 Then Vet [I+1] := -1;
      Inc (X ,50);
      Inc (X2,50);
      If X2 > 630 Then
      Begin
         X  := 32;
         X2 := 82;
         Inc (Y,50);
         Inc (Y2,50);
      End;
      If I >= 63 Then
      Begin
         Inc (I);
         Vet [I] := -1;
      End;
   Until (Vet [I] = -1);

   If I <> 1 Then
   Begin
      I  := 1;
      X  := 320;                {**Posicao Da  Raiz}
      Y  := 30;
      Tam := 160;               {**Distancia No Nivel 0}

      MouseCursor(False);  {Desliga Mouse}
      SetFillStyle(1,AzulEscuro);
      ClearDevice;
      Moldura(000,000,GetMaxY,GetMaxX,BrancoForte,BrancoFraco,False);

      Letra(1,2,4);
      SetColor(AzulClaro);
      x1:=10 ; y1:=15; c1:=3;
      While y1 < 600 Do
      Begin
         Say(x1,y1,' rvore bin ria');
         Inc(x1,235);
         If x1 > 320 Then
         Begin
            Inc(y1,40) ;
            x1:=10;
         End;
      End;

      MouseCursor(True);  {Liga Mouse}

      SetTextStyle (2,0,4);
      Str (Vet [I],Strg);
      SetColor(AzulEscuro);
      Circulo (X,Y,Strg);
      Enfileira (X,Y);
      Repeat
         J := 2*I;
         Str (Vet [J],Strg);
         Desenfileira (X,Y);
         Case I Of
              2   : Dec (Tam,80);  {**Distancia No Nivel 1, Quanto >, Fica < }
              4   : Dec (Tam,40);  {**    ' '       ''   2}
              8   : Dec (Tam,19);  {**    ' '       ''   3}
              16  : Dec (Tam,11);  {**    ' '       ''   4}
         End;
         X2 := X;
         Y2 := Y;
         Inc (Y,82);
         Dec (X,Tam);
         SetColor(BrancoFraco);
         If Strg <> '-1' Then Line (X2,Y2+12,X,Y-12);  {****** Linha Esquerda}
         Circulo (X,Y,Strg);
         Enfileira (X,Y);
         J := 2*I + 1;
         Str (Vet [J],Strg);
         Inc (X,(2*Tam));
         SetColor(BrancoFraco);
         If Strg <> '-1' Then Line (X2,Y2+12,X,Y-12); {******* Linha Direita}
         Circulo (X,Y,Strg);
         Enfileira (X,Y);
         Inc (I);
      Until (Vet [J] = -1) Or (Vet [J+1] = -1);
   End;

   MouseCursor(True);

   {Icone}
   Letra(12,0,20);
   SetLineStyle(1,0,4);
   SetFillStyle(1,BrancoFraco);
   Icone(050,520,077,620,'Fim',BrancoForte,Preto,AzulEscuro,VermelhoForte,'F');

   While Not Ok Do
   Begin
      Tecla1:=KeyPressed;
      If Tecla1 Then Tecla:=ReadKey;
      If Area(050,520,077,620,'F') Then
      Begin
         Ok:=True;
         Opcao:=1;
      End;
   End;

   CurHourGlass;
   Case Opcao Of
        1 : Clica(050,520,077,620,BrancoForte,Preto);
   End;
   Delay(1000);

   Closegraph;
End.