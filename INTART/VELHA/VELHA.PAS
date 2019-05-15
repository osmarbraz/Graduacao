Program JogoDaVelha;
uses crt;
var
     C1,C2,C3,L1,L2,L3,Posicao,I,Ganha: byte;
     Resultado,Primeiro,Vez,Jogada,Faz_2: byte;
     Tabuleiro: array [1..9] of byte;
     Escolha,Jogador: char;
     K1,K2,X1,X2,Cor1,Cor2: byte;
     Tecla1: char;

Procedure Janela;
Begin
    Window(K1+2,X1+1,K2+2,X2+1);
    Textbackground(0);
    Textcolor(15);
    Clrscr;
    Window(K1,X1,K2,X2);
    Textbackground(COR1);
    Textcolor(COR2);
    Clrscr;
End;

Procedure Tela1;
Begin
    Clrscr;
    Window(1,1,80,25);
    Textbackground(1);
    Textcolor(1);
    Clrscr;
    K1:=7;      K2:=74;
    X1:=6;      X2:=22;
    Cor1:=4;    Cor2:=15;
    Janela;
    Gotoxy(10,2);
    Write('UNISUL - UNIVERSIDADE DO SUL DE SC');
    Gotoxy(10,4);
    Write('PROF. SALOMAO W. SANDRINI');
    Gotoxy(26,9);
    Write('JOGO DA VELHA');
    Tecla1:=Readkey;
End;

procedure MostraTela;
begin
     clrscr;
     C1:=32;     C2:=39;     C3:=46;
     L1:=3;      L2:=6;      L3:=9;
     gotoxy(8,2);
     write('O = COMPUTADOR');
     gotoxy(8,3);
     write('X = HUMANO');
     gotoxy(30,2);
     write('     ³       ³     ');
     gotoxy(30,3);
     write('     ³       ³     ');
     gotoxy(30,4);
     write('ÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄ');
     gotoxy(30,5);
     write('     ³       ³     ');
     gotoxy(30,6);
     write('     ³       ³     ');
     gotoxy(30,7);
     write('     ³       ³     ');
     gotoxy(30,8);
     write('ÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄ');
     gotoxy(30,9);
     write('     ³       ³     ');
     gotoxy(30,10);
     write('     ³       ³     ');
     gotoxy(5,13);
     write('POSICIONE A JOGADA COM AS SETAS E PRESSIONE ENTER ');
end;

procedure LimpaTabuleiro;
begin
    gotoxy(C1,L1);    write(' ');
    gotoxy(C2,L1);    write(' ');
    gotoxy(C3,L1);    write(' ');
    gotoxy(C1,L2);    write(' ');
    gotoxy(C2,L2);    write(' ');
    gotoxy(C3,L2);    write(' ');
    gotoxy(C1,L3);    write(' ');
    gotoxy(C2,L3);    write(' ');
    gotoxy(C3,L3);    write(' ');
    for I:=1 to 9 do
         Tabuleiro[I]:=2;
    Ganha:=0;
    Resultado:=0;
end;
 
Procedure Mensagem(CodMens:byte);
begin
    gotoxy(5,15);
    case CodMens of
    1 : write('E A SUA VEZ DE JOGAR.                       ');
    2 : write('GANHEI O JOGO.                              ');
    3 : write('PARABENS, VOCE GANHOU.                      ');
    4 : write('EMPATAMOS ...                               ');
    5 : begin
         write('POSICAO INVALIDA. JOGUE NOVAMENTE.          ');
         gotoxy(C1,L1);
        end;
    6 : begin
        write(#7);
        write('QUER JOGAR OUTRA VEZ ? <S/N>  ');
        end;
    end;
end;
 
Procedure ArmaJogada;
begin
    if Tabuleiro[5]=2 then
         Faz_2:=5
    else
         if Tabuleiro[2]=2 then
              Faz_2:=2
         else
              if Tabuleiro[4]=2 then
                   Faz_2:=4
              else
                   if Tabuleiro[6]=2 then
                        Faz_2:=6
                   else
                        if Tabuleiro[8]=2 then
                             Faz_2:=8;
end;

Procedure CalculaResultado(A,B,C:byte);
begin
    Resultado:=Tabuleiro[A]*Tabuleiro[B]*Tabuleiro[C];
    if ((Resultado=18) and (Jogador='O')) or
       ((Resultado=50) and (Jogador='X')) then
    begin
         if Tabuleiro[A]=2 then
              Ganha:=A
         else
              if Tabuleiro[B]=2 then
                   Ganha:=B
              else
                   if Tabuleiro[C]=2 then
                        Ganha:=C;
    end;
end;

Procedure PossibilidadeGanhar;
begin
    Resultado:=0;
    Ganha:=0;
    CalculaResultado(1,2,3);    if Ganha<>0 then exit;
    CalculaResultado(4,5,6);    if Ganha<>0 then exit;
    CalculaResultado(7,8,9);    if Ganha<>0 then exit;

    CalculaResultado(1,4,7);    if Ganha<>0 then exit;
    CalculaResultado(2,5,8);    if Ganha<>0 then exit;
    CalculaResultado(3,6,9);    if Ganha<>0 then exit;

    CalculaResultado(1,5,9);    if Ganha<>0 then exit;
    CalculaResultado(3,5,7);    if Ganha<>0 then exit;
end;

Procedure HumanoGanhou;
begin
    Resultado:=0;
    Ganha:=0;
    CalculaResultado(1,2,3);    if Resultado=125 then exit;
    CalculaResultado(4,5,6);    if Resultado=125 then exit;
    CalculaResultado(7,8,9);    if Resultado=125 then exit;
    CalculaResultado(1,4,7);    if Resultado=125 then exit;
    CalculaResultado(2,5,8);    if Resultado=125 then exit;
    CalculaResultado(3,6,9);    if Resultado=125 then exit;
    CalculaResultado(1,5,9);    if Resultado=125 then exit;
    CalculaResultado(3,5,7);    if Resultado=125 then exit;
end;

Procedure ComputadorGanhou;
begin
    Resultado:=0;
    Ganha:=0;
    CalculaResultado(1,2,3);    if Resultado=27 then exit;
    CalculaResultado(4,5,6);    if Resultado=27 then exit;
    CalculaResultado(7,8,9);    if Resultado=27 then exit;
    CalculaResultado(1,4,7);    if Resultado=27 then exit;
    CalculaResultado(2,5,8);    if Resultado=27 then exit;
    CalculaResultado(3,6,9);    if Resultado=27 then exit;
    CalculaResultado(1,5,9);    if Resultado=27 then exit;
    CalculaResultado(3,5,7);    if Resultado=27 then exit;
end;

Procedure ImprimeJogada;
begin
    case Posicao of
    1 : begin
              gotoxy(C1,L1);
              write(Jogador);
              gotoxy(C1,L1);
        end;
    2 : begin
              gotoxy(C2,L1);
              write(Jogador);
              gotoxy(C2,L1);
        end;
    3 : begin
              gotoxy(C3,L1);
              write(Jogador);
              gotoxy(C3,L1);
        end;
    4 : begin
              gotoxy(C1,L2);
              write(Jogador);
              gotoxy(C1,L2);
        end;
    5 : begin
              gotoxy(C2,L2);
              write(Jogador);
              gotoxy(C2,L2);
        end;
    6 : begin
              gotoxy(C3,L2);
              write(Jogador);
              gotoxy(C3,L2);
        end;
    7 : begin
              gotoxy(C1,L3);
              write(Jogador);
              gotoxy(C1,L3);
        end;
    8 : begin
              gotoxy(C2,L3);
              write(Jogador);
              gotoxy(C2,L3);
        end;
    9 : begin
              gotoxy(C3,L3);
              write(Jogador);
              gotoxy(C3,L3);
        end;
    end;
end;

Procedure JogadaHumano;
var
    Tecla   : char;
    Possivel: boolean;
begin
    Tecla:=' ';
    Posicao:=1;
    Possivel:=false;
    Mensagem(1);
    gotoxy(C1,L1);
    repeat
         Tecla:=readkey;
         if ord(Tecla)=0 then
         begin
              Tecla:=readkey;
              case ord(Tecla) of
              72 : if Posicao in [4..9] then
                   case Posicao of
                   4 : begin
                        Posicao:=1;
                        gotoxy(C1,L1);
                       end;
                   5 : begin
                        Posicao:=2;
                        gotoxy(C2,L1);
                       end;
                   6 : begin
                        Posicao:=3;
                        gotoxy(C3,L1);
                       end;
                   7 : begin
                        Posicao:=4;
                        gotoxy(C1,L2);
                       end;
                   8 : begin
                        Posicao:=5;
                        gotoxy(C2,L2);
                       end;
                   9 : begin
                        Posicao:=6;
                        gotoxy(C3,L2);
                       end;
                   end;
 
              75 : if Posicao in [2,3,5,6,8,9] then
                   case Posicao of
                   2 : begin
                        Posicao:=1;
                        gotoxy(C1,L1);
                       end;
                   3 : begin
                        Posicao:=2;
                        gotoxy(C2,L1);
                       end;
                   5 : begin
                        Posicao:=4;
                        gotoxy(C1,L2);
                       end;
                   6 : begin
                        Posicao:=5;
                        gotoxy(C2,L2);
                       end;
                   8 : begin
                        Posicao:=7;
                        gotoxy(C1,L3);
                       end;
                   9 : begin
                        Posicao:=8;
                        gotoxy(C2,L3);
                       end;
                   end;

              77 : if Posicao in [1,2,4,5,7,8] then
                   case Posicao of
                   1 : begin
                        Posicao:=2;
                        gotoxy(C2,L1);
                       end;
                   2 : begin
                        Posicao:=3;
                        gotoxy(C3,L1);
                       end;
                   4 : begin
                        Posicao:=5;
                        gotoxy(C2,L2);
                       end;
                   5 : begin
                        Posicao:=6;
                        gotoxy(C3,L2);
                       end;
                   7 : begin
                        Posicao:=8;
                        gotoxy(C2,L3);
                       end;
                   8 : begin
                        Posicao:=9;
                        gotoxy(C3,L3);
                       end;
                   end;

              80 : if Posicao in [1..6] then
                   case Posicao of
                   1 : begin
                        Posicao:=4;
                        gotoxy(C1,L2);
                       end;
                   2 : begin
                        Posicao:=5;
                        gotoxy(C2,L2);
                       end;
                   3 : begin
                        Posicao:=6;
                        gotoxy(C3,L2);
                       end;
                   4 : begin
                        Posicao:=7;
                        gotoxy(C1,L3);
                       end;
                   5 : begin
                        Posicao:=8;
                        gotoxy(C2,L3);
                       end;
                   6 : begin
                        Posicao:=9;
                        gotoxy(C3,L3);
                       end;
                   end;
              end;
         end
         else
              if ord(Tecla)=13 then
                   if Tabuleiro[Posicao]=2 then
                   begin
                        Tabuleiro[Posicao]:=5;
                        Possivel:=true;
                   end
                   else
                        Mensagem(5);
    until Possivel=true;
    Jogador:='X';
    ImprimeJogada;
    HumanoGanhou;
    if Resultado=125 then
    begin
         Mensagem(3);
         Jogada:=10;
    end
    else
         if Jogada=9 then
              Mensagem(4);
    inc(Jogada);
    Vez:=3;
end;
 
Procedure JogadaComputador;
begin
    case Jogada of
    1 : begin
         Tabuleiro[1]:=3;
         Posicao:=1;
         Jogador:='O';
         ImprimeJogada;
      end;
    2 : begin
         if Tabuleiro[5]=2 then
         begin
              Tabuleiro[5]:=3;
              Posicao:=5;
         end
         else
         begin
              Tabuleiro[1]:=3;
              Posicao:=1;
         end;
         Jogador:='O';
         ImprimeJogada;
        end;
    3 : begin
         if Tabuleiro[9]=2 then
         begin
              Tabuleiro[9]:=3;
              Posicao:=9;
         end
         else
         begin
              Tabuleiro[3]:=3;
              Posicao:=3;
         end;
         Jogador:='O';
         ImprimeJogada;
        end;
    4 : begin
         Jogador:='X';
         PossibilidadeGanhar;
         if Ganha<>0 then
         begin
              Tabuleiro[Ganha]:=3;
              Posicao:=Ganha;
         end
         else
         begin
              ArmaJogada;
              Tabuleiro[Faz_2]:=3;
              Posicao:=Faz_2;
         end;
         Jogador:='O';
         ImprimeJogada;
        end;
    5 : begin
         Jogador:='O';
         PossibilidadeGanhar;
         if Ganha<>0 then
         begin
              Tabuleiro[Ganha]:=3;
              Posicao:=Ganha;
              Jogador:='O';
              ImprimeJogada;
              Mensagem(2);
              Jogada:=10;
              exit;
         end
         else
         begin
              Jogador:='X';
              PossibilidadeGanhar;
              if Ganha<>0 then
              begin
                   Tabuleiro[Ganha]:=3;
                   Posicao:=Ganha;
              end
              else
                   if Tabuleiro[7]=2 then
                   begin
                        Tabuleiro[7]:=3;
                        Posicao:=7;
                   end
                   else
                   begin
                        Tabuleiro[3]:=3;
                        Posicao:=3;
                   end;
              Jogador:='O';
              ImprimeJogada;
         end;
        end;
    6 : begin
         Jogador:='O';
         PossibilidadeGanhar;
         if Ganha<>0 then
         begin
              Tabuleiro[Ganha]:=3;
              Posicao:=Ganha;
              Jogador:='O';
              ImprimeJogada;
              Mensagem(2);
              Jogada:=10;
              exit;
         end
         else
         begin
              Jogador:='X';
              PossibilidadeGanhar;
              if Ganha<>0 then
              begin
                   Tabuleiro[Ganha]:=3;
                   Posicao:=Ganha;
              end
              else
              begin
                   ArmaJogada;
                   Tabuleiro[Faz_2]:=3;
                   Posicao:=Faz_2;
              end;
              Jogador:='O';
              ImprimeJogada;
         end;
        end;
    7 : begin
         Jogador:='O';
         PossibilidadeGanhar;
         if Ganha<>0 then
         begin
              Tabuleiro[Ganha]:=3;
              Posicao:=Ganha;
              Jogador:='O';
              ImprimeJogada;
              Mensagem(2);
              Jogada:=10;
              exit;
         end
         else
         begin
              Jogador:='X';
              PossibilidadeGanhar;
              if Ganha<>0 then
              begin
                   Tabuleiro[Ganha]:=3;
                   Posicao:=Ganha;
              end
              else
                   for I:=1 to 9 do
                        if Tabuleiro[I]=2 then
                        begin
                             Tabuleiro[I]:=3;
                             Posicao:=I;
                        end;
              Jogador:='O';
              ImprimeJogada;
         end;
        end;
    8 : begin
         Jogador:='O';
         PossibilidadeGanhar;
         if Ganha<>0 then
         begin
              Tabuleiro[Ganha]:=3;
              Posicao:=Ganha;
              Jogador:='O';
              ImprimeJogada;
              Mensagem(2);
              Jogada:=10;
              exit;
         end
         else
         begin
              Jogador:='X';
              PossibilidadeGanhar;
              if Ganha<>0 then
              begin
                   Tabuleiro[Ganha]:=3;
                   Posicao:=Ganha;
              end
              else
                   for I:=1 to 9 do
                        if Tabuleiro[I]=2 then
                        begin
                             Tabuleiro[I]:=3;
                             Posicao:=I;
                        end;
              Jogador:='O';
              ImprimeJogada;
         end;
        end;
    9 : begin
         for I:=1 to 9 do
              if Tabuleiro[I]=2 then
              begin
                   Tabuleiro[I]:=3;
                   Posicao:=I;
                   Jogador:='O';
                   ImprimeJogada;
              end;
        end;
    end;
    ComputadorGanhou;
    if Resultado=27 then
    begin
         Mensagem(2);
         Jogada:=10;
    end
    else
         if Jogada=9 then
              Mensagem(4);
    inc(Jogada);
    Vez:=5;
end;
{---------------------------------------------------------------------------}
BEGIN
    clrscr;
    Primeiro:=5;
    Tela1;
    MostraTela;
    repeat
         LimpaTabuleiro;
         Jogada:=1;
         Vez:=Primeiro;
         Repeat
              if Vez=3 then
                   JogadaComputador
              else
                   JogadaHumano;
         until Jogada>9;
         Escolha:=readkey;
         Mensagem(6);
         repeat
              Escolha:=readkey;
              Escolha:=upcase(Escolha);
         until (Escolha='S') or (Escolha='N');
         if Primeiro=5 then
              Primeiro:=3
         else
              Primeiro:=5;
    until Escolha='N';
END.
