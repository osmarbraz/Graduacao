{$V-}

unit Mouse;

interface

var
  MouseExists  : boolean;
  MouseVisible : boolean;
  MouseButtons : byte;

{01} procedure MouseReset;
{02} procedure MouseCursor(on:boolean);
{03} procedure MouseStatus(var status, col, lin : integer);
{04} procedure MouseMoveTo(new_col, new_lin : integer);
{05} function  MousePressed (button:integer;
                             var count,col,lin:integer):boolean;
{06} function  MouseReleased(button:integer;
                             var count,col,lin:integer):boolean;
{07} procedure MouseRange(col1,lin1,col2,lin2 : integer);
{08} procedure MouseTextCursor(cursor_type : integer; arg1, arg2 : word);
{09} procedure MouseReadMotion(var horizontal_count,
                                   vertical_count : integer);
{10} procedure LightPenOn;
{11} procedure LightPenOff;
{12} procedure MouseRatio(horizontal, vertical : integer);
{13} procedure MouseConditionalOff(col1, lin1, col2, lin2 : integer);
{14} function  MouseGetSize : word;
{15} procedure MouseSaveDriver(var p:pointer; s:word);
{16} procedure MouseRestoreDriver(var p:pointer; s:word);
{17} procedure MouseGetSensitivity(var h,v:word);
{18} procedure MouseSetCRTPage(page:byte);
{19} function  MouseGetCRTPage : byte;
{20} procedure MouseEnableDriver;
{21} function  MouseDisableDriver : boolean;
{22} procedure MouseSetLanguage(lan:byte);
{23} function  MouseGetLanguage : byte;
{24} procedure MouseGetInformation(var Version,MouseType:string;
                                   var IRQp:byte);
{25} procedure CurHand;
{26} procedure CurHourGlass;
{27} procedure CurUpArrow;
{28} procedure CurLeftArrow;
{29} procedure CurStandard;
{30} procedure CurBigStandard;
{31} procedure CurSight;

implementation

uses Dos;

type
  tCursMask = record
                 Matr : array[1..2,1..16] of word;
                 Horz,
                 Vert : integer;
               end;

var
  masc : tCursMask;
  r    : Registers;


{<<< XX >>>----------------------------------------------------------------
|          CallMouse
---------------------------------------------------------------------------}
procedure CallMouse(MouseFunction : integer);
begin
  r.AX := MouseFunction;
  intr ($33, r);
end; { CallMouse }


{<<< XX >>>----------------------------------------------------------------
|          MouseGraphCursor
---------------------------------------------------------------------------}
procedure MouseGraphCursor;
begin
  r.BX := word(masc.Horz);
  r.CX := word(masc.vert);
  r.DX := ofs(masc);
  r.ES := seg(masc);

  CallMouse($09);
end;


{<<< XX >>>----------------------------------------------------------------
|          BTW   (BinToWord)
---------------------------------------------------------------------------}
function BTW(str:string) : word;
var
  w, aux, cont : word;
begin
  w   := 0;
  aux := 1;

  for cont := length(str) DownTo 1 do begin
    w   := w + (ord(str[cont])-48)*aux;
    aux := aux * 2;
  end;

  BTW := w;
end;


{<<< 01 >>>----------------------------------------------------------------
|          MouseReset
---------------------------------------------------------------------------}
procedure MouseReset;
begin
  CallMouse($00);

  MouseExists  := r.AX <> 0;
  MouseButtons := r.BX;
  MouseVisible := false;
end; { Reset }


{<<< 02 >>>----------------------------------------------------------------
|          MouseCursor
---------------------------------------------------------------------------}
procedure MouseCursor(on:boolean);
begin
  if (on) then begin
     if (MouseVisible) then exit;
     CallMouse($01);
     MouseVisible := true; end
   else begin
     if (not MouseVisible) then exit;
     CallMouse($02);
     MouseVisible := false;
  end;
end;


{<<< 03 >>>----------------------------------------------------------------
|          MouseStatus
---------------------------------------------------------------------------}
procedure MouseStatus(var status, col, lin : integer);
begin
  CallMouse ($03);
  col    := r.CX;
  lin    := r.DX;
  status := r.BX;
end;


{<<< 04 >>>----------------------------------------------------------------
|          MouseMoveTo
---------------------------------------------------------------------------}
procedure MouseMoveTo(new_col, new_lin : integer);
begin
  r.CX := new_col;
  r.DX := new_lin;
  CallMouse($04);
end;


{<<< 05 >>>----------------------------------------------------------------
|          MousePressed
---------------------------------------------------------------------------}
function MousePressed(button:integer; var count,col,lin:integer):boolean;
var
  result : boolean;
begin
  with r do begin
    BX := pred(button);
    CallMouse($05);

    case button of
      1 : result := AX and $01 <> 0;
      2 : result := AX and $02 <> 0;
      3 : result := AX and $04 <> 0;
    end; { case }

    count := BX;
    col   := CX;
    lin   := DX;
  end; { with }

  MousePressed := result;
end;


{<<< 06 >>>----------------------------------------------------------------
|          MouseReleased
---------------------------------------------------------------------------}
function MouseReleased(button:integer; var count,col,lin:integer):boolean;
var
  result : boolean;
begin
  with r do begin
    BX := pred(button);
    CallMouse($06);

    case button of
      1 : result := AX and $01 <> 0;
      2 : result := AX and $02 <> 0;
      3 : result := AX and $04 <> 0;
    end; { case }

    count := BX;
    col   := CX;
    lin   := DX;
  end; { with }

  MouseReleased := result;
end;


{<<< 07 >>>----------------------------------------------------------------
|          MouseRange
---------------------------------------------------------------------------}
procedure MouseRange(col1,lin1,col2,lin2 : integer);
begin
  r.CX := col1;
  r.DX := col2;
  CallMouse($07);

  r.CX := lin1;
  r.DX := lin2;
  CallMouse($08);
end;


{<<< 08 >>>----------------------------------------------------------------
|          MouseTextCursor
---------------------------------------------------------------------------}
procedure MouseTextCursor(cursor_type : integer; arg1, arg2 : word);
begin
  r.BX := cursor_type;
  r.CX := arg1;
  r.DX := arg2;
  CallMouse($0A);
end;


{<<< 09 >>>----------------------------------------------------------------
|          MouseReadMotion
---------------------------------------------------------------------------}
procedure MouseReadMotion(var horizontal_count, vertical_count : integer);
begin
  CallMouse($0B);
  horizontal_count := r.CX;
  vertical_count   := r.DX;
end;


{<<< 10 >>>----------------------------------------------------------------
|          LightPenOn
---------------------------------------------------------------------------}
procedure LightPenOn;
begin
  CallMouse($0D);
end;


{<<< 11 >>>----------------------------------------------------------------
|          LightPenOff
---------------------------------------------------------------------------}
procedure LightPenOff;
begin
  CallMouse($0E);
end;


{<<< 12 >>>----------------------------------------------------------------
|          MouseRatio
---------------------------------------------------------------------------}
procedure MouseRatio(horizontal, vertical : integer);
begin
  if (vertical   < 1) then vertical   := 1;
  if (horizontal < 1) then horizontal := 1;

  r.CX := horizontal;
  r.DX := vertical;
  CallMouse($0F);
end;


{<<< 13 >>>----------------------------------------------------------------
|          MouseConditionalOff
---------------------------------------------------------------------------}
procedure MouseConditionalOff(col1, lin1, col2, lin2 : integer);
begin
  if (not MouseVisible) then exit;
  r.CX := col1;
  r.DX := lin1;
  r.SI := col2;
  r.DI := lin2;

  CallMouse($10);
  MouseVisible := false;
end;


{<<< 14 >>>----------------------------------------------------------------
|          MouseGetSize
---------------------------------------------------------------------------}
function MouseGetSize : word;
begin
  CallMouse($15);
  MouseGetSize := r.BX;
end;


{<<< 15 >>>----------------------------------------------------------------
|          MouseSaveDriver
---------------------------------------------------------------------------}
procedure MouseSaveDriver(var p:pointer; s:word);
begin
  GetMem(p,s);

  r.ES := seg(p);
  r.DX := ofs(p);
  CallMouse($16);
end;


{<<< 16 >>>----------------------------------------------------------------
|          MouseRestoreDriver
---------------------------------------------------------------------------}
procedure MouseRestoreDriver(var p:pointer; s:word);
begin
  r.ES := seg(p);
  r.DX := ofs(p);
  CallMouse($17);

  FreeMem(p,s);
end;


{<<< 17 >>>----------------------------------------------------------------
|          MouseGetSensitivity
---------------------------------------------------------------------------}
procedure MouseGetSensitivity(var h,v:word);
begin
  CallMouse($1B);
  h := r.BX;     { Raz„o (mickeys/pixel) na horizontal }
  v := r.CX;     { Raz„o (mickeys/pixel) na vertical   }
end;


{<<< 18 >>>----------------------------------------------------------------
|          MouseSetCRTPage
---------------------------------------------------------------------------}
procedure MouseSetCRTPage(page:byte);
begin
  r.BX := page;
  CallMouse($1D);
end;


{<<< 19 >>>----------------------------------------------------------------
|          MouseGetCRTPage
---------------------------------------------------------------------------}
function MouseGetCRTPage : byte;
begin
  CallMouse($1E);
  MouseGetCRTPage := r.BX
end;


{<<< 20 >>>----------------------------------------------------------------
|          MouseDisableDriver
---------------------------------------------------------------------------}
function MouseDisableDriver : boolean;
begin
  CallMouse($1F);
  MouseDisableDriver := r.AX = $1F;
end;


{<<< 21 >>>----------------------------------------------------------------
|          MouseEnableDriver
---------------------------------------------------------------------------}
procedure MouseEnableDriver;
begin
  CallMouse($20);
end;


{<<< 22 >>>----------------------------------------------------------------
|          MouseSetLanguage
---------------------------------------------------------------------------}
procedure MouseSetLanguage(lan:byte);
begin
  r.BX := lan;
  CallMouse($22);
end;


{<<< 23 >>>----------------------------------------------------------------
|          MouseGetLanguage
---------------------------------------------------------------------------}
function MouseGetLanguage : byte;
begin
  CallMouse($23);
  MouseGetLanguage := r.BX
end;


{<<< 24 >>>----------------------------------------------------------------
|          MouseGetInformation
---------------------------------------------------------------------------}
procedure MouseGetInformation(var Version,MouseType:string; var IRQp:byte);

Const
  mType : array[1..5] of string[12] = ('Bus Mouse',
                                       'Serial Mouse','InPort Mouse',
                                       'PS/2 Mouse',  'HP Mouse');
var
  VerAux : string[10];

begin
  CallMouse($24);

  str(r.BH, Version);
  str(r.BL, VerAux);

  Version   := Version + '.' + VerAux;
  MouseType := mType[r.CH];
  IRQp      := r.CL;
end;


{<<< 25 >>>----------------------------------------------------------------
|          CurHand
---------------------------------------------------------------------------}
procedure CurHand;
begin
  with masc do begin
   matr[1,01] := BTW('1111001111111111'); matr[2,01] := BTW('0000110000000000');
   matr[1,02] := BTW('1110110111111111'); matr[2,02] := BTW('0001001000000000');
   matr[1,03] := BTW('1110110111111111'); matr[2,03] := BTW('0001001000000000');
   matr[1,04] := BTW('1110110111111111'); matr[2,04] := BTW('0001001000000000');
   matr[1,05] := BTW('1110110111111111'); matr[2,05] := BTW('0001001000000000');
   matr[1,06] := BTW('1110110001001111'); matr[2,06] := BTW('0001001110110000');
   matr[1,07] := BTW('1110110110110001'); matr[2,07] := BTW('0001001001001110');
   matr[1,08] := BTW('1110110110110110'); matr[2,08] := BTW('0001001001001001');
   matr[1,09] := BTW('1000110110110110'); matr[2,09] := BTW('0111001001001001');
   matr[1,10] := BTW('0110111111111110'); matr[2,10] := BTW('1001000000000001');
   matr[1,11] := BTW('0110111111111110'); matr[2,11] := BTW('1001000000000001');
   matr[1,12] := BTW('0110111111111110'); matr[2,12] := BTW('1001000000000001');
   matr[1,13] := BTW('0111111111111110'); matr[2,13] := BTW('1000000000000001');
   matr[1,14] := BTW('1011111111111110'); matr[2,14] := BTW('0100000000000001');
   matr[1,15] := BTW('1101111111111101'); matr[2,15] := BTW('0010000000000010');
   matr[1,16] := BTW('1110000000000011'); matr[2,16] := BTW('0001111111111100');

   Horz := 5;
   Vert := 0;
  end;

  MouseGraphCursor;
end;


{<<< 26 >>>----------------------------------------------------------------
|          CurHourGlass
---------------------------------------------------------------------------}
procedure CurHourGlass;
begin
  with masc do begin
   matr[1,01] := BTW('1000000000000011'); matr[2,01] := BTW('0111111111111100');
   matr[1,02] := BTW('1011111111111011'); matr[2,02] := BTW('0100000000000100');
   matr[1,03] := BTW('1011111111111011'); matr[2,03] := BTW('0100000000000100');
   matr[1,04] := BTW('1011100000111011'); matr[2,04] := BTW('0100011111000100');
   matr[1,05] := BTW('1101000000010111'); matr[2,05] := BTW('0010111111101000');
   matr[1,06] := BTW('1110100000101111'); matr[2,06] := BTW('0001011111010000');
   matr[1,07] := BTW('1111010001011111'); matr[2,07] := BTW('0000101110100000');
   matr[1,08] := BTW('1111001010011111'); matr[2,08] := BTW('0000110101100000');
   matr[1,09] := BTW('1111011011011111'); matr[2,09] := BTW('0000100100100000');
   matr[1,10] := BTW('1110111011101111'); matr[2,10] := BTW('0001000100010000');
   matr[1,11] := BTW('1101111011110111'); matr[2,11] := BTW('0010000100001000');
   matr[1,12] := BTW('1011111011111011'); matr[2,12] := BTW('0100000100000100');
   matr[1,13] := BTW('1011110101111011'); matr[2,13] := BTW('0100001010000100');
   matr[1,14] := BTW('1011101010111011'); matr[2,14] := BTW('0100010101000100');
   matr[1,15] := BTW('1000000000000011'); matr[2,15] := BTW('0111111111111100');
   matr[1,16] := BTW('1111111111111111'); matr[2,16] := BTW('0000000000000000');

   Horz := 7;
   Vert := 7;
  end;

  MouseGraphCursor;
end;


{<<< 27 >>>----------------------------------------------------------------
|          CurUpArrow
---------------------------------------------------------------------------}
procedure CurUpArrow;
begin
  with masc do begin
   matr[1,01] := BTW('1111111111111111'); matr[2,01] := BTW('0000000100000000');
   matr[1,02] := BTW('1111111111111111'); matr[2,02] := BTW('0000001110000000');
   matr[1,03] := BTW('1111111111111111'); matr[2,03] := BTW('0000001110000000');
   matr[1,04] := BTW('1111111111111111'); matr[2,04] := BTW('0000011111000000');
   matr[1,05] := BTW('1111111111111111'); matr[2,05] := BTW('0000011111000000');
   matr[1,06] := BTW('1111111111111111'); matr[2,06] := BTW('0000111111100000');
   matr[1,07] := BTW('1111111111111111'); matr[2,07] := BTW('0000111111100000');
   matr[1,08] := BTW('1111111111111111'); matr[2,08] := BTW('0001111111110000');
   matr[1,09] := BTW('1111111111111111'); matr[2,09] := BTW('0001111111110000');
   matr[1,10] := BTW('1111111111111111'); matr[2,10] := BTW('0011111111111000');
   matr[1,11] := BTW('1111111111111111'); matr[2,11] := BTW('0000001110000000');
   matr[1,12] := BTW('1111111111111111'); matr[2,12] := BTW('0000001110000000');
   matr[1,13] := BTW('1111111111111111'); matr[2,13] := BTW('0000001110000000');
   matr[1,14] := BTW('1111111111111111'); matr[2,14] := BTW('0000001110000000');
   matr[1,15] := BTW('1111111111111111'); matr[2,15] := BTW('0000001110000000');
   matr[1,16] := BTW('1111111111111111'); matr[2,16] := BTW('0000001110000000');

   Horz := 7;
   Vert := 0;
  end;

  MouseGraphCursor;
end;


{<<< 28 >>>----------------------------------------------------------------
|          CurLeftArrow
---------------------------------------------------------------------------}
procedure CurLeftArrow;
begin
  with masc do begin
   matr[1,01] := BTW('1111111111111111'); matr[2,01] := BTW('0000000000000000');
   matr[1,02] := BTW('1111111111111111'); matr[2,02] := BTW('0000000000000000');
   matr[1,03] := BTW('1111111111111111'); matr[2,03] := BTW('0000000000000000');
   matr[1,04] := BTW('1111111111111111'); matr[2,04] := BTW('0000000000000000');
   matr[1,05] := BTW('1111111111111111'); matr[2,05] := BTW('0000000110000000');
   matr[1,06] := BTW('1111111111111111'); matr[2,06] := BTW('0000011110000000');
   matr[1,07] := BTW('1111111111111111'); matr[2,07] := BTW('0011111111111111');
   matr[1,08] := BTW('1111111111111111'); matr[2,08] := BTW('1111111111111111');
   matr[1,09] := BTW('1111111111111111'); matr[2,09] := BTW('0011111111111111');
   matr[1,10] := BTW('1111111111111111'); matr[2,10] := BTW('0000011110000000');
   matr[1,11] := BTW('1111111111111111'); matr[2,11] := BTW('0000000110000000');
   matr[1,12] := BTW('1111111111111111'); matr[2,12] := BTW('0000000000000000');
   matr[1,13] := BTW('1111111111111111'); matr[2,13] := BTW('0000000000000000');
   matr[1,14] := BTW('1111111111111111'); matr[2,14] := BTW('0000000000000000');
   matr[1,15] := BTW('1111111111111111'); matr[2,15] := BTW('0000000000000000');
   matr[1,16] := BTW('1111111111111111'); matr[2,16] := BTW('0000000000000000');

   Horz := 0;
   Vert := 7;
  end;

  MouseGraphCursor;
end;


{<<< 29 >>>----------------------------------------------------------------
|          CurStandard  (Default)
---------------------------------------------------------------------------}
procedure CurStandard;
begin
  with masc do begin
   matr[1,01] := BTW('0011111111111111'); matr[2,01] := BTW('0000000000000000');
   matr[1,02] := BTW('0001111111111111'); matr[2,02] := BTW('0100000000000000');
   matr[1,03] := BTW('0000111111111111'); matr[2,03] := BTW('0110000000000000');
   matr[1,04] := BTW('0000011111111111'); matr[2,04] := BTW('0111000000000000');
   matr[1,05] := BTW('0000001111111111'); matr[2,05] := BTW('0111100000000000');
   matr[1,06] := BTW('0000000111111111'); matr[2,06] := BTW('0111110000000000');
   matr[1,07] := BTW('0000000011111111'); matr[2,07] := BTW('0111111000000000');
   matr[1,08] := BTW('0000000001111111'); matr[2,08] := BTW('0111111100000000');
   matr[1,09] := BTW('0000000000111111'); matr[2,09] := BTW('0111111110000000');
   matr[1,10] := BTW('0000000000011111'); matr[2,10] := BTW('0111110000000000');
   matr[1,11] := BTW('0000000111111111'); matr[2,11] := BTW('0110110000000000');
   matr[1,12] := BTW('0001000011111111'); matr[2,12] := BTW('0100011000000000');
   matr[1,13] := BTW('0011000011111111'); matr[2,13] := BTW('0000011000000000');
   matr[1,14] := BTW('1111100001111111'); matr[2,14] := BTW('0000001100000000');
   matr[1,15] := BTW('1111100001111111'); matr[2,15] := BTW('0000001100000000');
   matr[1,16] := BTW('1111110000111111'); matr[2,16] := BTW('0000000000000000');

   Horz := 0;
   Vert := 0;
  end;

  MouseGraphCursor;
end;


{<<< 30 >>>----------------------------------------------------------------
|          CurBigStandard
---------------------------------------------------------------------------}
procedure CurBigStandard;
begin
  with masc do begin
   matr[1,01] := BTW('0000000000000000'); matr[2,01] := BTW('0000000000000000');
   matr[1,02] := BTW('0000000000000001'); matr[2,02] := BTW('0111111111111100');
   matr[1,03] := BTW('0000000000000011'); matr[2,03] := BTW('0111111111111000');
   matr[1,04] := BTW('0000000000000111'); matr[2,04] := BTW('0111111111110000');
   matr[1,05] := BTW('0000000000001111'); matr[2,05] := BTW('0111111111100000');
   matr[1,06] := BTW('0000000000011111'); matr[2,06] := BTW('0111111111000000');
   matr[1,07] := BTW('0000000000111111'); matr[2,07] := BTW('0111111110000000');
   matr[1,08] := BTW('0000000000011111'); matr[2,08] := BTW('0111111111000000');
   matr[1,09] := BTW('0000000000001111'); matr[2,09] := BTW('0111111111100000');
   matr[1,10] := BTW('0000000000000111'); matr[2,10] := BTW('0111110111110000');
   matr[1,11] := BTW('0000001000000011'); matr[2,11] := BTW('0111100011111000');
   matr[1,12] := BTW('0000011100000001'); matr[2,12] := BTW('0111000001111100');
   matr[1,13] := BTW('0000111110000000'); matr[2,13] := BTW('0110000000111110');
   matr[1,14] := BTW('0001111111000001'); matr[2,14] := BTW('0100000000011100');
   matr[1,15] := BTW('0011111111100011'); matr[2,15] := BTW('0000000000001000');
   matr[1,16] := BTW('0111111111110111'); matr[2,16] := BTW('0000000000000000');

   Horz := 0;
   Vert := 0;
  end;

  MouseGraphCursor;
end;


{<<< 31 >>>----------------------------------------------------------------
|          CurSight
---------------------------------------------------------------------------}
procedure CurSight;
begin
  with masc do begin
   matr[1,01] := BTW('1111111111111111'); matr[2,01] := BTW('0000000100000000');
   matr[1,02] := BTW('1111111111111111'); matr[2,02] := BTW('0000000100000000');
   matr[1,03] := BTW('1111111111111111'); matr[2,03] := BTW('0000011111000000');
   matr[1,04] := BTW('1111111111111111'); matr[2,04] := BTW('0000100100100000');
   matr[1,05] := BTW('1111111111111111'); matr[2,05] := BTW('0001000100010000');
   matr[1,06] := BTW('1111111111111111'); matr[2,06] := BTW('0011001110001000');
   matr[1,07] := BTW('1111111111111111'); matr[2,07] := BTW('0010010001001000');
   matr[1,08] := BTW('1111111111111111'); matr[2,08] := BTW('1111110101111110');
   matr[1,09] := BTW('1111111111111111'); matr[2,09] := BTW('0010010001001000');
   matr[1,10] := BTW('1111111111111111'); matr[2,10] := BTW('0010001110001000');
   matr[1,11] := BTW('1111111111111111'); matr[2,11] := BTW('0001000100010000');
   matr[1,12] := BTW('1111111111111111'); matr[2,12] := BTW('0000100100100000');
   matr[1,13] := BTW('1111111111111111'); matr[2,13] := BTW('0000011111000000');
   matr[1,14] := BTW('1111111111111111'); matr[2,14] := BTW('0000000100000000');
   matr[1,15] := BTW('1111111111111111'); matr[2,15] := BTW('0000000100000000');
   matr[1,16] := BTW('1111111111111111'); matr[2,16] := BTW('0000000000000000');

   Horz := 7;
   Vert := 7;
  end;

  MouseGraphCursor;
end;

{==========================================================================}

begin
  CallMouse(0);
  MouseExists  := r.AX <> 0;
  MouseButtons := r.BX;
  MouseVisible := false;
end.
