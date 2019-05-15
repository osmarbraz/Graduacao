program compild2;
uses crt;
type
    regtabsint = record
                       tipo,nomets  		: char;
                       numno,altts,sucts	: integer;
                 end;
    regtabgrafo = record
    			suctg,alttg,sim   : integer;
                        ter         	  : boolean;
                  end;
    regtabt = record
                    nomet : char;
              end;
    regtabnt = record
                     noment : char;
                     prim   : integer;
               end;

var
   tabsint  : array [1..12] of regtabsint;
   tabgrafo : array [1..12] of regtabgrafo;
   tabt     : array [1..12] of regtabt;
   tabnt    : array [1..12] of regtabnt;


procedure algoritmo;
var
   ind,maxt,maxnt,indprim,numno,nomax,i,j,c1 : integer;
   encontrou				     : boolean;
begin
     maxt:=0; maxnt:=0; indprim:=1; nomax:=0; j:=1; ind:=0;

     while (ind<13) do
     begin
     	  inc(ind);
          if (tabsint[ind].tipo='C') then
          begin
               inc(indprim,nomax);
               nomax:=0;

               c1:=0; encontrou:=false;
               while (c1<=maxnt) do
               begin
                    inc(c1);
               	    if (tabsint[ind].nomets = tabnt[c1].noment) then
                    begin
                    	 encontrou:=true;
                         inc(c1,maxnt+1);
                    end
                    else
                    	inc(c1);
               end;

               if (not encontrou) then
               begin
               	    inc(maxnt);
                    tabnt[maxnt].noment:= tabsint[ind].nomets;
                    tabnt[maxnt].prim:= indprim;
               end;

               j:=0;
               repeat
                     inc(j);
                     if (tabnt[j].noment = tabsint[ind].nomets) then
                       if (tabnt[j].prim=0) then
                          tabnt[j].prim:= indprim;
               until((j<=maxnt)) and (tabnt[j].noment = tabsint[ind].nomets) ;
          end
          else
          begin
               {se ‚ terminal e n¢ <> vazio}
               i:= indprim+tabsint[ind].numno-1;

               if (tabsint[ind].tipo='T') and (tabsint[ind].nomets<>'V')  then
               begin
                    c1:=0; encontrou:=false;
               	    while (c1<maxt) do
               	    begin
                    	 inc(c1);
               	    	 if (tabsint[ind].nomets = tabt[c1].nomet) then
                    	 begin
                    	      encontrou:=true;
                              inc(c1,maxt+1);
                    	 end
                    	 else
                    	     inc(c1);
               	    end;
                    if (not encontrou) then
               	    begin
                    	 inc(maxt);
                    	 tabt[maxt].nomet:= tabsint[ind].nomets;
                    end
               end;

               j:=0;
               repeat
                     inc(j);
                     if (tabt[j].nomet = tabsint[ind].nomets) then
                          tabgrafo[i].ter:= true;
	       until( (j<=maxt) and
	       	       (tabt[j].nomet = tabsint[ind].nomets) );

               { nao terminal }
               if tabsint[ind].tipo='N' then
               begin

                    c1:=0; encontrou:=false;
               	    while (c1<maxnt) do
               	    begin
                    	 inc(c1);
               	    	 if (tabsint[ind].nomets = tabnt[c1].noment) then
                    	 begin
                    	      encontrou:=true;
                              inc(c1,maxnt+1);
                    	 end
                    	 else
                    	     inc(c1);
               	    end;
                    if (not encontrou) then
                    begin
                         inc(maxnt);
                         tabnt[maxnt].noment:= tabsint[ind].nomets;
                         tabnt[maxnt].prim:= 0;
                    end;

                    j:=0;
                    repeat
                          inc(j);
                          if (tabnt[j].noment = tabsint[ind].nomets) then
	            	     tabgrafo[i].ter:= false;
                    until( (j<=maxnt) and (tabnt[j].noment = tabsint[ind].nomets) );
               end;

               if tabsint[ind].nomets= 'V' then
               begin
                    tabgrafo[i].ter:= true;
                    tabgrafo[i].sim:= 0;
               end

               else
                   tabgrafo[i].sim:= j;

               if tabsint[ind].altts <> 0 then
                  tabgrafo[i].alttg:= indprim + tabsint[ind].altts - 1
               else
                   tabgrafo[i].alttg:= 0;

               if tabsint[ind].sucts <> 0 then
                  tabgrafo[i].suctg:= indprim + tabsint[ind].sucts - 1
               else
                   tabgrafo[i].suctg:= 0;

              if nomax < tabsint[ind].numno then
                 nomax:= tabsint[ind].numno;
          end;
     end;

     clrscr;
     writeln('                                    TABSINT');
     writeln;
     writeln('                   INDTS TIPO NOMETS NUMNO ALTTS SUCTS');
     writeln('                    01     ', tabsint[1].tipo,'    ',tabsint[1].nomets,'     ',tabsint[1].numno,'    ',
     tabsint[1].altts,'    ',tabsint[1].sucts);
     writeln('                    02     ', tabsint[2].tipo,'    ',tabsint[2].nomets,'      ',tabsint[2].numno,'     ',
     tabsint[2].altts,'     ',tabsint[2].sucts);
     writeln('                    03     ', tabsint[3].tipo,'    ',tabsint[3].nomets,'      ',tabsint[3].numno,'     ',
     tabsint[3].altts,'     ',tabsint[3].sucts);
     writeln('                    04     ', tabsint[4].tipo,'    ',tabsint[4].nomets,'      ',tabsint[4].numno,'     ',
     tabsint[4].altts,'     ',tabsint[4].sucts);
     writeln('                    05     ', tabsint[5].tipo,'    ',tabsint[5].nomets,'      ',tabsint[5].numno,'     ',
     tabsint[5].altts,'     ',tabsint[5].sucts);
     writeln('                    06     ', tabsint[6].tipo,'    ',tabsint[6].nomets,'      ',tabsint[6].numno,'     ',
     tabsint[6].altts,'     ',tabsint[6].sucts);
     writeln('                    07     ', tabsint[7].tipo,'    ',tabsint[7].nomets,'      ',tabsint[7].numno,'     ',
     tabsint[7].altts,'     ',tabsint[7].sucts);
     writeln('                    08     ', tabsint[8].tipo,'    ',tabsint[8].nomets,'      ',tabsint[8].numno,'     ',
     tabsint[8].altts,'     ',tabsint[8].sucts);
     writeln('                    09     ', tabsint[9].tipo,'    ',tabsint[9].nomets,'     ',tabsint[9].numno,'    ',
     tabsint[9].altts,'    ',tabsint[9].sucts);
     writeln('                    10     ',tabsint[10].tipo,'    ',tabsint[10].nomets,'      ',tabsint[10].numno,'     ',
     tabsint[10].altts,'     ',tabsint[10].sucts);
     writeln('                    11     ',tabsint[11].tipo,'    ',tabsint[11].nomets,'      ',tabsint[11].numno,'     ',
     tabsint[11].altts,'     ',tabsint[11].sucts);
     writeln('                    12     ',tabsint[12].tipo,'    ',tabsint[12].nomets,'      ',tabsint[12].numno,'     ',
     tabsint[12].altts,'     ',tabsint[12].sucts);
     readln;

     clrscr;
     writeln('                                 TABGRAFO');
     writeln;
     writeln('                       INDTG  TER   SIM ALTTG SUCTG');
     writeln('                         01  ', tabgrafo[1].ter,'    ',tabgrafo[1].sim,'    ',tabgrafo[1].alttg,'     ',
     tabgrafo[1].suctg);
     writeln('                         02  ', tabgrafo[2].ter,'    ',tabgrafo[2].sim,'    ',tabgrafo[2].alttg,'     ',
     tabgrafo[2].suctg);
     writeln('                         03  ', tabgrafo[3].ter,'   ',tabgrafo[3].sim,'    ',tabgrafo[3].alttg,'     ',
     tabgrafo[3].suctg);
     writeln('                         04  ', tabgrafo[4].ter,'    ',tabgrafo[4].sim,'    ',tabgrafo[4].alttg,'     ',
     tabgrafo[4].suctg);
     writeln('                         05  ', tabgrafo[5].ter,'    ',tabgrafo[5].sim,'    ',tabgrafo[5].alttg,'     ',
     tabgrafo[5].suctg);
     writeln('                         06  ', tabgrafo[6].ter,'    ',tabgrafo[6].sim,'    ',tabgrafo[6].alttg,'     ',
     tabgrafo[6].suctg);
     writeln('                         07  ', tabgrafo[7].ter,'    ',tabgrafo[7].sim,'    ',tabgrafo[7].alttg,'     ',
     tabgrafo[7].suctg);
     writeln('                         08  ', tabgrafo[8].ter,'    ',tabgrafo[8].sim,'   ',tabgrafo[8].alttg,'     ',
     tabgrafo[8].suctg);
     writeln('                         09  ', tabgrafo[9].ter,'   ',tabgrafo[9].sim,'    ',tabgrafo[9].alttg,'     ',
     tabgrafo[9].suctg);
     writeln('                         10  ', tabgrafo[10].ter,'    ',tabgrafo[10].sim,'    ',tabgrafo[10].alttg,'     ',
     tabgrafo[10].suctg);
     readln;

     clrscr;
     writeln('                                  TABT');
     writeln;
     writeln('                               INDT NOMET');
     writeln('                                01    ', tabt[1].nomet);
     writeln('                                02    ', tabt[2].nomet);
     writeln('                                03    ', tabt[3].nomet);
     writeln('                                04    ', tabt[4].nomet);
     writeln('                                05    ', tabt[5].nomet);
     writeln('                                06    ', tabt[6].nomet);
     readln;

     clrscr;
     writeln('                                  TABNT');
     writeln;
     writeln('                            INDNT NOMENT PRIM');
     writeln('                             01     ', tabnt[1].noment,'     ',tabnt[1].prim);
     writeln('                             02     ', tabnt[2].noment,'     ',tabnt[2].prim);
     readln;
end;

Procedure atribuicao;
begin
     tabsint[1].tipo:= 'C';  tabsint[2].tipo:= 'T'; tabsint[3].tipo:= 'T';
     tabsint[4].tipo:= 'N';  tabsint[5].tipo:= 'T'; tabsint[6].tipo:= 'T';
     tabsint[7].tipo:= 'N';  tabsint[8].tipo:= 'T'; tabsint[9].tipo:= 'C';
     tabsint[10].tipo:= 'T'; tabsint[11].tipo:='N'; tabsint[12].tipo:= 'T';

     tabsint[1].nomets:= 'S'; tabsint[2].nomets:= 'a'; tabsint[3].nomets:= 'b';
     tabsint[4].nomets:= 'S'; tabsint[5].nomets:= 'c'; tabsint[6].nomets:= 'd';
     tabsint[7].nomets:= 'M'; tabsint[8].nomets:= 'e'; tabsint[9].nomets:= 'M';
     tabsint[10].nomets:= 'f'; tabsint[11].nomets:= 'S'; tabsint[12].nomets:= 'V';

     tabsint[1].numno:= -1; tabsint[2].numno:= 1; tabsint[3].numno:= 2;
     tabsint[4].numno:= 3; tabsint[5].numno:= 4; tabsint[6].numno:= 5;
     tabsint[7].numno:= 6; tabsint[8].numno:= 7; tabsint[9].numno:= -1;
     tabsint[10].numno:= 1; tabsint[11].numno:= 2; tabsint[12].numno:= 3;

     tabsint[1].altts:= -1; tabsint[2].altts:= 5; tabsint[3].altts:= 3;
     tabsint[4].altts:= 0; tabsint[5].altts:= 0; tabsint[6].altts:= 7;
     tabsint[7].altts:= 0; tabsint[8].altts:= 0; tabsint[9].altts:= -1;
     tabsint[10].altts:= 3; tabsint[11].altts:= 0; tabsint[12].altts:= 0;

     tabsint[1].sucts:= -1; tabsint[2].sucts:= 2; tabsint[3].sucts:= 0;
     tabsint[4].sucts:= 4; tabsint[5].sucts:= 0; tabsint[6].sucts:= 6;
     tabsint[7].sucts:= 0; tabsint[8].sucts:= 0; tabsint[9].sucts:= -1;
     tabsint[10].sucts:= 2; tabsint[11].sucts:= 1; tabsint[12].sucts:= 0;
end;

procedure principal;
begin
     atribuicao;
     algoritmo;
end;


BEGIN
	principal;
END.