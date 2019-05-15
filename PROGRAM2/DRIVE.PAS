PROGRAM DRIVER;
USES CRT;
CONST
     A = 5;
     B = 2;
     C = 4;


TYPE
     VETORA = ARRAY[1..A] OF STRING;
     VETORB = ARRAY[1..B] OF STRING;
     VETORC = ARRAY[1..C] OF STRING;


VAR
   DRIA           : VETORA;
   DRIB           : VETORB;
   DRIC           : VETORC;
   DRIVE,ENTRADA  : STRING;
   X,M,T,W        : INTEGER;

PROCEDURE LIMPA;
BEGIN
   CLRSCR;
END;

PROCEDURE VERSAO;
BEGIN
   WRITELN('MS-DOS Versao 10.0');
   WRITELN;
END;

PROCEDURE LEITURA;
BEGIN
    WRITE(DRIVE,':>');
    READLN(ENTRADA);
    WRITELN;
    M := LENGTH(ENTRADA);
    FOR W := 1 TO M DO
        ENTRADA [W] := UPCASE (ENTRADA[W]);
    T:=0;
    REPEAT
        INC( T );
    UNTIL ENTRADA [ T ] <> ' ';
    DELETE ( ENTRADA, 1 , T - 1 );

END;

PROCEDURE ERRO;
BEGIN
     WRITELN('Seu burro !!! Comado ou nome-de-arquivo invalido');
     WRITELN;
END;

PROCEDURE DIRETORIO;
BEGIN
     WRITELN('O Volume da unidade ',drive,' e DISCO',DRIVE);
     WRITELN ('Diretorio de ',DRIVE,':\');
     WRITELN;
     IF DRIVE ='A' THEN
        BEGIN
            FOR X:= 1 TO A DO
               WRITELN(DRIA[X],' Arquivo ',x);
            WRITELN('     ',X,' arquivos');
        END;
     IF DRIVE ='B' THEN
        BEGIN
            FOR X:= 1 TO B DO
               WRITELN(DRIB[X],' Arquivo ',x);
            WRITELN('     ',X,' arquivos');
        END;
     IF DRIVE ='C' THEN
        BEGIN
           FOR X:= 1 TO C DO
               WRITELN(DRIC[X],' Arquivo ',x);
           WRITELN('     ',X,' arquivos');
        END;
     WRITELN;
END;

PROCEDURE DIRETORIO_DRIVE;
BEGIN
 IF ENTRADA = 'DIR A:' THEN
   BEGIN
        WRITELN ('O Volume da unidade A e DISCOA');
        WRITELN ('Diretorio de A:\');
        WRITELN;
        FOR X:= 1 TO A DO
            WRITELN ( DRIA [X],' Arquivo ',x);
        WRITELN('     ',X,' arquivo(s)');
   END;
 IF ENTRADA = 'DIR B:' THEN
   BEGIN
       WRITELN ('O Volume da unidade B e DISCOB');
       WRITELN ('Diretorio de B:\');
       WRITELN;
       FOR X:= 1 TO B DO
           WRITELN ( DRIB [X],' Arquivo ',x);
       WRITELN('     ',X,' arquivo(s)');
   END;
 IF ENTRADA = 'DIR C:' THEN
   BEGIN
        WRITELN ('O Volume da unidade C e DISCOC');
        WRITELN ('Diretorio de C:\');
        WRITELN;
        FOR X:= 1 TO C DO
            WRITELN ( DRIC [X],' Arquivo ',x);
        WRITELN('     ',X,' arquivo(s)');
   END;
 WRITELN;
END;


BEGIN
     DRIA [1] := 'SKOLL    ';
     DRIA [2] := 'BRAHMA   ';
     DRIA [3] := 'ANTARTICA';
     DRIA [4] := 'BELCO    ';
     DRIA [5] := 'MALT90   ';
     DRIB [1] := 'BELCO    ';
     DRIB [2] := 'MALT90   ';
     DRIC [1] := 'SKINCARIO';
     DRIC [2] := 'POLAR    ';
     DRIC [3] := 'KAYSER   ';
     DRIC [4] := 'CARACU   ';
     CLRSCR;
     DRIVE :='A';
     REPEAT

          LEITURA;

          IF ENTRADA='A:' THEN
             DRIVE:= 'A'
          ELSE
             IF ENTRADA='B:' THEN
                DRIVE :='B'
             ELSE
                IF ENTRADA ='C:' THEN
                   DRIVE := 'C'
                ELSE
                   IF ENTRADA='CLS' THEN
                      LIMPA
                   ELSE
                      IF ENTRADA = 'VER' THEN
                        BEGIN
                            VERSAO
                        END
                      ELSE
                         IF ENTRADA = 'DIR' THEN
                            DIRETORIO
                         ELSE
                            IF (ENTRADA='DIR A:') OR (ENTRADA ='DIR B:') OR (ENTRADA ='DIR C:') THEN
                                DIRETORIO_DRIVE
                            ELSE
                                ERRO;
     UNTIL ENTRADA='EXIT'
END.

