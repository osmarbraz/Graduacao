Program teste;
uses crt;
var
 x, y, cont : integer;
 soma : real;
begin
   x:= 1;
   y:= 1;
   cont := 1;
   soma := 0;
   while cont < 50 do
   begin
      soma := soma + (x/y);
      x := x + 2;
      y := y + 1;
      inc(cont);
   end;
   clrscr;
   write (soma:0:2);
end.