Program teste;
uses crt;
var
 y, cont1, cont2 : integer;
 soma,x : real;
begin
   y:= 50;
   soma := 0;
   cont1 := 1;
   while cont1 <= 50 do
   begin
      x := 1;
      for cont2 := 1 to cont1 do
          x := (2 * x);
      soma := soma + (x /y);
      y := y - 1;
      inc(cont1);
   end;
   writeln(soma:0:2);
end.