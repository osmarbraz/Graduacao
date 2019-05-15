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
               until((j<=maxnt)) or (tabnt[j].noment = tabsint[ind].nomets) ;
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
                    until( (j<=maxnt) or (tabnt[j].noment = tabsint[ind].nomets) );
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