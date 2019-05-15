(************************************************************************)
(* ESTE PROGRAMA LE UM  NUMERO  DECIMAL E ENCONTRA SEU NUMERO BINARIO,  *)
(* HEXADECIMAL, E ROMANO CORRESPONDENTE.                                *)
(************************************************************************)

PROGRAM BINARIO;
USES CRT;
VAR
   RESTOB,RESTOH,COLUNA,LINHA,R,TAMANHO                        : INTEGER;
   NUMERO_DECIMAL,H,B                                          : WORD;
   RO                                                          : STRING[3];
   CHAVE                                                       : CHAR;

BEGIN
    CLRSCR;

(******************* ABRE A PRIMEIRA JANELA DE SAIDA ***********************)

    WINDOW(1,1,80,8);
    TEXTBACKGROUND(15);
    TEXTCOLOR(0);
    CLRSCR;

(***************** POSICIONAMENTO DA TABELA NA TELA ************************)

    GOTOXY(15,1);
    WRITELN('T R A B A L H O   D E   P R O G R A M A C A O  -  I');
    GOTOXY(24,2);
    WRITELN('ALUNA : LUSICLER DE SOUZA MOLON');
    GOTOXY(17,4);
    WRITELN('DIGITE UM NUMERO DECIMAL DO TIPO WORD (0-65535)');
    GOTOXY (2,6);
    WRITELN ('NUMERO DECIMAL');
    GOTOXY (20,6);
    WRITELN ('NUMERO BINARIO');
    GOTOXY (38,6);
    WRITELN ('NUMERO HEXADECIMAL');
    GOTOXY (59,6);
    WRITELN ('NUMERO ROMANO (0-999)');

(********************* ABRE A SEGUNDA JANELA DE SAIDA **********************)

    WINDOW (1,8,80,25);
    TEXTBACKGROUND(0);
    TEXTCOLOR(15);
    CLRSCR;

    CHAVE := 'S';
    WHILE CHAVE <> 'N' DO

(*********************** LEITURA DO NUMERO DECIMAL ************************)

         BEGIN
         LINHA := 3;
         COLUNA := 5;
         CLRSCR;
         GOTOXY (COLUNA,LINHA);
         READLN (NUMERO_DECIMAL);

(*********************** CALCULO DE NUMERO BINARIO *************************)

         COLUNA := 31;
         B := NUMERO_DECIMAL;
         WHILE (B <> 0) AND (B <> 1) DO
              BEGIN
                   RESTOB := B MOD 2;
                   B  :=  B DIV 2;
                   GOTOXY (COLUNA,LINHA);
                   WRITELN (RESTOB);
                   COLUNA := COLUNA - 1;
             END;
         GOTOXY (COLUNA,LINHA);
         WRITELN (B);

(********************* CALCULO DE NUMERO HEXADECIMAL **********************)

         COLUNA := 46;
         H := NUMERO_DECIMAL;
         WHILE (H > 15) DO
             BEGIN
                  RESTOH := H MOD 16;
                  H := H DIV 16;
                  GOTOXY (COLUNA,LINHA);
                  CASE RESTOH OF
                      0..9  : WRITELN (RESTOH);
                      10    : WRITELN ('A');
                      11    : WRITELN ('B');
                      12    : WRITELN ('C');
                      13    : WRITELN ('D');
                      14    : WRITELN ('E');
                      15    : WRITELN ('F');
                  END;
                  COLUNA := COLUNA - 1;
             END;
         GOTOXY (COLUNA,LINHA);
         CASE H OF
             0..9  : WRITELN (H);
             10    : WRITELN ('A');
             11    : WRITELN ('B');
             12    : WRITELN ('C');
             13    : WRITELN ('D');
             14    : WRITELN ('E');
             15    : WRITELN ('F');
         END;

(***************** CALCULO DE NUMERO ROMANO (0 ATE 999) ********************)

         COLUNA := 68;
         IF (NUMERO_DECIMAL < 1000) AND (NUMERO_DECIMAL > 0)THEN
            BEGIN
                R := NUMERO_DECIMAL;

(** TRANSFORMA A VARIAVEL R DO TIPO INTEIRA EM UMA VARIAVEL TIPO STRING (RO) **)

                STR (R,RO);

                TAMANHO := LENGTH(RO);
                GOTOXY (COLUNA,LINHA);
                CASE RO [TAMANHO - 2] OF
                   '9' : WRITE ('CM');
                   '8' : WRITE ('DCCC');
                   '7' : WRITE ('DCC');
                   '6' : WRITE ('DC');
                   '5' : WRITE ('D');
                   '4' : WRITE ('CD');
                   '3' : WRITE ('CCC');
                   '2' : WRITE ('CC');
                   '1' : WRITE ('C');
                END;
                CASE RO [TAMANHO - 1] OF
                   '9' : WRITE ('XC');
                   '8' : WRITE ('LXXX');
                   '7' : WRITE ('LXX');
                   '6' : WRITE ('LX');
                   '5' : WRITE ('L');
                   '4' : WRITE ('XL');
                   '3' : WRITE ('XXX');
                   '2' : WRITE ('XX');
                   '1' : WRITE ('X');
                END;
                CASE RO [TAMANHO] OF
                   '9' : WRITE ('IX');
                   '8' : WRITE ('VIII');
                   '7' : WRITE ('VII');
                   '6' : WRITE ('VI');
                   '5' : WRITE ('V');
                   '4' : WRITE ('IV');
                   '3' : WRITE ('III');
                   '2' : WRITE ('II');
                   '1' : WRITE ('I');
                END;
            END
         ELSE
            IF NUMERO_DECIMAL = 0 THEN
               BEGIN
                    GOTOXY (COLUNA,LINHA);
                    WRITE('ZERO');
               END
            ELSE
                BEGIN
                    GOTOXY (COLUNA,LINHA);
                    WRITE ('----');
                END;

(***********************  CARTAO BANDEIRA = "N" **************************)

        GOTOXY(15,12);
        WRITE('VOCE  QUER CONSULTAR OUTRO NUMERO (S/N) ? : ');
        CHAVE := READKEY;
    END;
END.
