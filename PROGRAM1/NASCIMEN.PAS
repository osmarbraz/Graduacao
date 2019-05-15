PROGRAM NASCIMENTO;
USES CRT;
VAR
     DATA,HOJE                                    : STRING[8];
     ANO_NASC,MES_NASC,DIA_NASC                   : STRING[2];
     ANO_ATUAL,MES_ATUAL,DIA_ATUAL                : STRING[2];
     ERRO_ATUAL,ERRO_ATUAL1,ERRO_ATUAL2           : INTEGER;
     ERRO,ERRO1,ERRO2                             : INTEGER;
     ANO_ATUAL_NUM,MES_ATUAL_NUM,DIA_ATUAL_NUM    : INTEGER;
     ANO,MES,DIA                                  : INTEGER;
     ANO_VIDA,MES_VIDA,DIA_VIDA                   : INTEGER;
     ANO_DIA,MES_DIA,DIA_TOTAL                    : INTEGER;
BEGIN
     CLRSCR;
     WRITELN (' DIGITE AS DATAS DA SEGUINTE FORMA   DD/MM/AA  ');
     WRITELN ('       E PRESSIONE <ENTER> NO FINAL');
     WRITELN;
     WRITELN ('QUAL A DATA DE HOJE  ');
     READLN (HOJE);
     ANO_ATUAL := HOJE[7] + HOJE[8];
     MES_ATUAL := HOJE[4] + HOJE[5];
     DIA_ATUAL := HOJE[1] + HOJE[2];
     VAL (ANO_ATUAL,ANO_ATUAL_NUM,ERRO_ATUAL);
     VAL (MES_ATUAL,MES_ATUAL_NUM,ERRO_ATUAL1);
     VAL (DIA_ATUAL,DIA_ATUAL_NUM,ERRO_ATUAL2);
     WRITELN ('QUAL A DATA DE NASCIMENTO ');
     READLN (DATA);
     ANO_NASC := DATA[7] + DATA[8];
     MES_NASC := DATA[4] + DATA[5];
     DIA_NASC := DATA[1] + DATA[2];
     VAL (ANO_NASC,ANO,ERRO);
     VAL (MES_NASC,MES,ERRO1);
     VAL (DIA_NASC,DIA,ERRO2);
     ANO_VIDA := ANO_ATUAL_NUM - ANO;
     MES_VIDA := MES_ATUAL_NUM - MES;
     DIA_VIDA := DIA_ATUAL_NUM - DIA;
     IF MES_VIDA < 0 THEN
        BEGIN
             ANO_VIDA := ANO_VIDA - 1;
             MES_VIDA := 12 + MES_ATUAL_NUM - MES;
        END;
     IF DIA_VIDA < 0 THEN
        BEGIN
             MES_VIDA := MES_VIDA - 1;
             DIA_VIDA := 30 + DIA_ATUAL_NUM - DIA;
        END;
     WRITELN ('VOCE TEM ',ANO_VIDA,' ANOS ',MES_VIDA,' MES ',DIA_VIDA,' DIAS DE VIDA');
     ANO_DIA := ANO_VIDA * 360;
     MES_DIA := MES_VIDA * 30;
     DIA_TOTAL := ANO_DIA + MES_DIA + DIA_VIDA;
     WRITELN ('OU ',DIA_TOTAL,' DIAS DE VIDA');
     REPEAT UNTIL KEYPRESSED;
end.