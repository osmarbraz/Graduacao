PROGRAM VALORES_EM_DOLAR_OU_OTN;
USES CRT;
CONST
     ESC      = #27;
     O        = #79;
     D        = #68;
     BRANCO   = #32;
VAR
   TECLA               : CHAR;
   DOLAR,OTN,VALOR     : REAL;
   N                   : LONGINT;
BEGIN
     CLRSCR;
     WINDOW (5,1,20,70);
     WRITELN ('DIGITE O PRECO ATUAL DO DOLAR E PRESSIONE <ENTER>');
     READLN (DOLAR);
     WRITELN ('DIGITE O PRECO ATUAL DO OTN E PRESSIONE <ENTER>');
     READLN (OTN);
     WRITELN ('DIGITE O NUMERO DESEJADO E PRESSIONE <ENTER>');
     READ (N);
     WRITELN;
     WRITELN;
     WRITELN ('PRESSIONE D NO CASO DE DOLAR OU O NO CASO DE OTN');
     TECLA := READKEY;
     REPEAT
           IF TECLA = O THEN
              BEGIN
              VALOR := N * OTN;
              CLRSCR;
              GOTOXY (1,10);
              WRITELN ('O VALOR DE ',BRANCO,N,BRANCO,'OTNS E',BRANCO,VALOR)
              END
           ELSE
               IF TECLA = D THEN
                  BEGIN
                  VALOR := N * := PECAS ;
                 DAY := K
            END
         END;
     MEDIA := TOTAL_SEMANAL/7;
     WRITELN;
     WRITELN ('CONSUMO MEDIO SEMANAL : ',MEDIA);
     WRITELN ('DIA DA SEMANA QUE HOUVE MAIOR CONSUMO DE FILE : ',DAY, ' ' ,'QUANTIDADE CONSUMIDA: ',MAIOR_CONSUMO,' ','PE�AS');
     WRITELN ('TOTAL DE PE�AS DE FILE CONSUMIDAS NO FIM DE SEMANA : ',TOTAL_FIM_SEMANA)
END.

 : : : : ');
     WRITELN ('A PESSOA MAIS ALTA E',' ',NOME [1],BRANCO,'E TEM',BRANCO,ALTURA [1],BRANCO,'CENTIMETROS'CHICO                �w     PROGRAM1             i�w     PROGRAM2             l�w     CCP-8579   (          ��w      DIVERSOS             ��w     DICIO