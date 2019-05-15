UNIT TELA;
INTERFACE
USES CRT;
VAR
I:BYTE;
PROCEDURE FAZER_TELA;

IMPLEMENTATION

PROCEDURE FAZER_TELA;
BEGIN
FOR I:=2 TO 24 DO
    BEGIN
      GOTOXY(2,I);

      WRITE(CHR(186));
    END;
FOR I:=2 TO 24 DO
    BEGIN
      GOTOXY(75,I);
      WRITE(CHR(186));
    END;
FOR I:=3 TO 23 DO
    BEGIN
      GOTOXY(3,I);
      WRITE(CHR(178));
    END;
FOR I:=3 TO 23 DO
    BEGIN
      GOTOXY(74,I);
      WRITE(CHR(178));
    END;
FOR I:=3 TO 74 DO
    BEGIN
      GOTOXY(I,2);
      WRITE(CHR(178));
    END;
FOR I:=3 TO 74 DO
    BEGIN
      GOTOXY(I,24);
      WRITE(CHR(178));
    END;
FOR I:=3 TO 23 DO
    BEGIN
      GOTOXY(4,I);
      WRITE(CHR(186));
    END;
FOR I:=3 TO 23 DO
    BEGIN
      GOTOXY(73,I);
      WRITE(CHR(186));
    END;
END;
END.


