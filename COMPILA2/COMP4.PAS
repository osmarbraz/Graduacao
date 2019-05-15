PROGRAM COMP4;
USES CRT,tela,DOS;
 VAR
    DADO,DADO2,T60,T61                       :STRING[20];
    T20                                      :STRING[2];
    COD1                                     :ARRAY[1..60] OF STRING;{PALAVRAS RESERVADAS}
    NOMEARQ                                  :STRING[20];{NOME DO ARQUIVO A LER}
    H,SE,L,CONT,TAMANHO,SOMA,LINHA,TIPO,SOMA2:INTEGER;
    ARQ,ARQ1,ARQ2                            :TEXT;
    TECLA                                    :CHAR;
    TE,CAR,CAR2,T50                          :STRING[249];
    W0,I,A,T4,codi,ERRO                      :BYTE;
    AUX                                      :STRING[1];
    DIA,MES,ANO,VAR12                        :WORD;
{
*******************************************************************************
*                                  VARIAVEIS                                  *
* DADO ->  VARIAVEL AUXILIAR PARA CONCATENAR VARIAVEL E TIPO,GRAVADA NO ARQ2  *
*          COPILA.W                                                           *
* DADO2 -> VARIAVEL AUXILIAR DE DADO                                          *
* T50   -> VARIAVEL QUE RETORNA A LINHA DO ARQUIVO COPILA.W, ONDE CONSTA      *
*          O CODIGO, DESCRICAO E LINHA.                                       *
* T60   -> RETORNA A DESCRICAO DO CODIGO.                                     *
* T20   -> RETORNA O CODIGO.                                                  *
* COD1  -> CONSTA TODOS OS SIMBOLOS RECONHECIDOS.                             *
* NOMEARQ -> NOME DO ARQUIVO A COMPILAR.                                      *
* H     -> USADO EM WHILE.                                                    *
* SE    -> VARIAVEL DE RECONHECIMENTO, SE SE=0 NAO RECONHECEU,                *
           SE=1 RECONHECIDO                                                   *
* L     -> INDICA FIM DE ARQUIVO, SE L=0 FIM DE ARQUIVO.                      *
* CONT  -> CAMINHA PELA STRING CAR                                            *
* TAMANHO -> TAMANHO DA VARIVEL CAR                                           *
* SOMA  -> SOMA OS BYTES                                                      *
* LINHA -> CONTEM O NUMERO DE LINHA                                           *
* ARQ   -> ARQUIVO A COMPACTAR                                                *
* ARQ1  -> ARQUIVO AUXILIAR, CONTEM O CODIGO, DESCRICAO E LINHA               *
* ARQ2  -> ARQUIVO AUXILIAR, CONTEM A VARIAVEL E O SEU TIPO                   *
* TE    -> RETORNA O SIMBOLO RECONHECIDO OU NAO                               *
* CAR   -> VERIAVEL RETORNA A LINHA DO ARQUIVO COMPILADO                      *
* CAR2  -> AUXILIAR PARA FAZER UPCASE DE CAR                                 *
* CODI  -> RETORNA DO CODIGO DO SIMBOLO                                       *
* ERRO  -> NUMERO DE ERROS                                                    *
********************************************************************************
}
{******************************************************************************
 * PROCEDIMENTO  QUE ABRE ARQUIVO AUXILIAR COPILA.W                           *
 * CONSTA O CODIGO DO SIMBOLO, O SIMBOLO E A LINHA                            *
 ******************************************************************************
}
 procedure abre_arquivo;
 BEGIN
     ASSIGN(ARQ1,'COPILA.W');
         {$I-}
         REWRITE(ARQ1);
         {$I+}
   END;
{******************************************************************************
 * PROCEDIMENTO  QUE ABRE ARQUIVO AUXILIAR COPILA.W PARA LEITURA              *
 * ABRE ARQUIVO COPIVAR.W PARA ESCRITA,CONSTA VARIAVEL E O CODIGO DO TIPO     *
 ******************************************************************************
}
  procedure abre_arquivo2;
 BEGIN
     ASSIGN(ARQ1,'COPILA.W');
         {$I-}
         RESET(ARQ1);
        {$I+}
     ASSIGN(ARQ2,'COPIVAR.W');
         {$I-}
         REWRITE(ARQ2);
         {$I+}
   END;
{******************************************************************************
 * PROCEDIMENTO  QUE GRAVA NO ARQUIVO COPIVAR.W A VARIAVEL E O CODIGO DO TIPO *
 * DADO RECEBERA A VARIAVEL, COD-> RECEBE O CODIGO DO TIPO                    *
 ******************************************************************************
}
 PROCEDURE GRAVAVAR(DADO:STRING;COD:INTEGER);
 VAR
   VAR20:STRING[20];
   VAR21:STRING[2];
 BEGIN
     STR(COD,VAR21);
     VAR20:=DADO+' '+VAR21;
    WRITELN(ARQ2,VAR20);
 END;
 {******************************************************************************
 * PROCEDIMENTO  QUE MOSTRA AS MENSAGENS DE ERROS NA TELA                     *
 * MENSAGEM -> RECEBE A MENSAGEM                                              *
 ******************************************************************************
}
 PROCEDURE ERROS(MENSAGEM:STRING;LI:STRING);
  BEGIN
         ERRO:=ERRO+1;
         GOTOXY(15,15);
         WRITELN('COMPILACAO PROCESSADA COM ERROS                              ' );
         GOTOXY(15,16);
         WRITELN('COMPILANDO..:',NOMEARQ ,' DATA:',DIA,'/',MES,'/',ANO);
         GOTOXY(15,17);
         WRITELN('TOTAL BYTES.:',SOMA);
         GOTOXY(15,18);
         WRITELN('TOTAL LINHAS:',LINHA);
         GOTOXY(15,19);
         WRITELN('ERROS.......:',ERRO);
         GOTOXY(15,20);
         WRITELN('MENSAGEM....:',MENSAGEM);
         GOTOXY(15,21);
         WRITELN('LINHA ERRO..:',LI);
         TECLA:=READKEY;
         HALT;
  END;
{******************************************************************************
 * FUNCAO        QUE PROCURA NO ARQUIVO COPIVAR.W A VARIAVEL                  *
 * PARA ANALISAR SE ESTA JA ESTA DEFINIDA, A FUNCAO RETORNA O TIPO            *
 * DA VARIAVEL PARA ANALISE DE ATRIBUICOES                                    *
 * SE FUNCAO RETORNAR 0 CONCLUIMOS QUE VARIAVEL NAO ESTAVA PRE DEFINIDA       *
 ******************************************************************************
}
 FUNCTION PROCURAVAR(DADO:STRING):INTEGER;
  VAR
    LER,LER2       :STRING[20]; { LER2 -> RETORNA A VARIAVEL }
    VAR22          :BYTE;
    ACHOU          :BOOLEAN;
    VAR23,VAR25    :INTEGER; { VAR25 -> RETORNA O CODIGO }
 BEGIN
        ACHOU:=FALSE;
        LER2:='';
        VAR22:=0;
        FOR I:=1 TO 20 DO
         LER[I]:=' ';
         LER:='';
   WHILE (NOT EOF(ARQ2)) AND (NOT ACHOU) DO
   BEGIN
       READLN(ARQ2,LER);
       LER2:='';
       FOR I:=1 TO 20 DO
         BEGIN
            IF LER[I]<>' ' THEN
             BEGIN
               LER2:=LER2+LER[I];
             END
             ELSE
              BEGIN
               VAR22:=I;
               I:=20;
              END;
        END;
        IF LER2=DADO THEN
            ACHOU:=TRUE;
    END;
       IF ACHOU THEN
        BEGIN
            LER2:='';

         FOR I:=VAR22 TO VAR22+2 DO
          BEGIN
            IF LER[I]<>' ' THEN
              LER2:=LER2+LER[I];
           END;
             VAL(LER2,VAR25,VAR23);
             PROCURAVAR:=VAR25;
         END
        ELSE
          BEGIN
             ERROS('VARIAVEL NAO DEFINIDA',T61);
            END;
         CLOSE(ARQ2);
         {$I-}
         RESET(ARQ2);
         {$I+}
 END;

 {*****************************************************************************
 * PROCEDIMENTO  QUE PEGA DO ARQUIVO COPILA.W A LINHA INTEIRA                 *
 * ONDE T20-> RECEBE O CODIGO , T50->RECEBE LINHA TODA, T60->O SIMBOLO        *
 ******************************************************************************
}
PROCEDURE PEGA2; {PROCEDIMENTO PARA LER UMA LINHA DO ARQUIVO}
 VAR
    T40:STRING[2];
    T41,T42:BYTE;

 BEGIN
  T41:=0;
  T42:=0;
  IF NOT SEEKEOF(ARQ1) THEN { SE NAO E FIM DE ARQUIVO }
    BEGIN
              FOR I:=1 TO 2 DO   { INICIALIZANDO A VARIAVEL T20 }
                BEGIN
                    T20[I]:=' ';
                 END;
                     T20:='';
             FOR I:=1 TO 20 DO
                BEGIN
                  T50[I]:=' ';
                  T60[I]:=' ';
                  T61[I]:=' ';
                END;
              FOR I:=20 TO 249 DO
                 T50[I]:=' ';

                  T50:='';
                  T60:='';
                  T61:='';
             READLN(ARQ1,T50);

             T42:=LENGTH(T50);

             FOR I:=1 TO 2 DO
                T20:=T20+T50[I];
               TAMANHO:=LENGTH(T20);

          { ** ESTA PEGANDO O SIMBOLO -> T60 **}
             FOR I:=TAMANHO+2 TO 20 DO
              BEGIN
                IF T50[I]<>' ' THEN
                    T60:=T60+T50[I]
                ELSE
                  BEGIN
                     T41:=I;
                     I:=20;
                  END;
                END;


            FOR I:=T42 DOWNTO 1 DO
              BEGIN
                    IF T50[I]<>' ' THEN
                    T61:=T50[I]+T61
              ELSE
                    I:=1;
               END;

         L:=1;                { VARIAVEL AXILIAR QUE INDICA FIM DO ARQUIVO }
         TAMANHO:=LENGTH(T20);{ PEGA O TAMANHO DA STRING LIDA DO ARQUIVO   }
  END    { SE FOR FIM DE ARQUIVO }
  ELSE
         L:=0;{ VARIAVEL AUXILIAR QUE INDICA FIM DE ARQUIVO QUANDO L=0 }
              FOR I:=1 TO 2 DO
                BEGIN
                    T40[I]:=' ';
                 END;
                     T40:='';
        IF T20='53' THEN   { ERRO, 53 CODIGO DE ERRO }
              ERROS('ERRO SIMBOLO NAO RECONHECIDO',T61);
        FOR I:=1 TO 2 DO
          BEGIN
            IF T20[I] <> ' ' THEN
               T40:=T40+T20[I];
          END;
           T20:=T40;
   END;
{
 *****************************************************************************
 * PROCEDIMENTO  QUE PEGA DO ARQUIVO COPILA.W A LINHA INTEIRA                 *
 * VERIFICA SE E FIM DO ARQUIVO L=0                                           *
 ******************************************************************************
}
 PROCEDURE PEER(MENSAGEM:STRING);
 BEGIN
    PEGA2;
          IF L=0 THEN { FIM DO ARQUIVO }
              ERROS(MENSAGEM,T61);
 END;
{
 ******************************************************************************
 * PROCEDIMENTO  QUE ANALISE O TIPO ARRANJO                                   *
 * SEGUENCIA :  29,COLCHETES -> 44,NUMERO -> 34,REDICENCIAS ->44,NUMERO       *
 * ->30,FECHA COLCHETES->23,DE->14,CARACTER 17,INTERO->26,PONTO VIRGULA       *
 ******************************************************************************
}
   PROCEDURE IDARRANJO;
   VAR
      NU1,NU2,VAR10:INTEGER;
   BEGIN
    PEGA2;
        IF (L=0) OR (T20<>'29') THEN
           ERROS('ERRO ESPERANDO COLCHETES',T61);
        PEGA2;
         IF (L=0) OR (T20<>'44') THEN
             ERROS('ERRO ESPERANDO NUMERO',T61);
             VAL(T60,NU1,VAR10);
         PEGA2;
          IF (L=0) OR (T20<>'34') THEN
                  ERROS('ERRO ESPERANDO REDICENCIAS',T61);
          PEGA2;
            IF (L=0) OR (T20<>'44') THEN
                  ERROS('ERRO ESPERANDO NUMERO',T61);
                  VAL(T60,NU2,VAR10);
              IF NU2<NU1 THEN
                  ERROS('ERRO NUMERO INICIAL MAIOR QUE FINAL',T61);
         PEGA2;
            IF (L=0) OR (T20<>'30') THEN
                 ERROS('ERRO ESPERANDO FECHA COLCHETES',T61);
         PEGA2;
            IF (L=0) OR (T20<>'23') THEN
                 ERROS('ERRO ESPERANDO PALAVRA RESERVADA DE',T61);
          PEGA2;
             IF (L=0) OR ((T20<>'14') AND (T20<>'17')) THEN
                     ERROS('ERRO ESPERANDO IDENTIFICADOR',T61);
          PEGA2;
             IF (L=0) OR (T20<>'26') THEN
                     ERROS('ERRO ESPERANDO PONTO E VIRGULA',T61);


   END;


 {*****************************************************************************
 * PROCEDIMENTO  QUE ANALISE AS DECLARACAO DE VARIAVEIS                       *
 * SEGUENCIA :  45,VARIAVEL  -> 25,DOIS PONTOS -> 2,ARRANJO,14 CARACTER,      *
 * 17,INTEIRO->26,PONTO EVIRGULA                                              *
 ******************************************************************************
}
 PROCEDURE PVARIAVEL;
  VAR
     T70:STRING[20];
     T80:BYTE;
 BEGIN
      PEGA2;
        IF L=0 THEN { FIM DO ARQUIVO }
           ERROS('ERRO ESPERANDO DECLARACAO DE VARIAVEIS',T61);
         T80:=1;
     WHILE T80=1 DO  { ENQUANTO NAO ENCONTROU INICIO OU ERRO FAZ }
     BEGIN

       IF T20='45'  THEN { VARIAVEL }
          BEGIN
               T70:=T60;
            PEGA2;
               IF L=0 THEN   { FIM DO ARQUIVO }
                   ERROS('ESPERANDO DOIS PONTOS',T61);
               IF T20<>'25' THEN   { SE NAO E DOIS PONTOS }
                   ERROS('ESPERANDO DOIS PONTOS',T61);
                   PEGA2;
               IF L=0 THEN
                  ERROS('ERRO ESPERANDO PALAVRA RESERVADA, IDENTIFICAO DE VARIAVEL',T61);
                IF (T20<>'2') AND (T20<>'14') AND (T20<>'17')  THEN
                     ERROS('ESPERANDO IDENTIFICADOR DE VARIAVEL',T61);
                 IF T20='2' THEN
                   BEGIN
                       GRAVAVAR(T70,2);{GRAVA NO COPILAVAR.W, AVARIAVEL}
                       IDARRANJO;
                    END;
                 IF T20='14' THEN
                    BEGIN
                       GRAVAVAR(T70,14);
                      PEGA2;
                        IF (L=0) OR (T20<>'26') THEN
                            ERROS('ESPERANDO PONTO E VIRGULA',T61);
                  END;

                  IF T20='17' THEN
                    BEGIN
                       GRAVAVAR(T70,17);
                       PEGA2;
                        IF (L=0) OR (T20<>'26') THEN
                            ERROS('ESPERANDO PONTO E VIRGULA',T61);
                  END;
          END
          ELSE
             ERROS('ERRO ESPERANDO VARIAVEL',T61);
           PEGA2;
             IF L=0 THEN { FIM DO ARQUIVO }
                ERROS('ERRO ESPERANDO INICIO',T61);
             IF T20='3' THEN
                T80:=0;
      END;
  END;
{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE AS VARIAVEL TIPO CARACTER,NO PRINCIPAL          *
* EXEMPLO: A:='KJK'; A:='JJ'+K;                                             *
******************************************************************************
}
PROCEDURE IDVARCARACTER;
VAR
  TIPO2,H1:INTEGER;

BEGIN
     H1:=1;
 WHILE H1=1 DO
 BEGIN
      PEER('ESPERANDO CADEIA DE CARACTERES');
         IF (T20<>'35') AND (T20<>'45') THEN
             ERROS('ESPERANDO CADEIA DE CARACTERES',T61);

         IF T20='45' THEN { VARIAVEL,CASO EXEMPLO A:=B; }
            BEGIN
               TIPO2:=PROCURAVAR(T60);
               IF TIPO2<>TIPO THEN
                    ERROS('TIPOS INCONPATIVEIS',T61);
              END;

      PEER('ESPERANDO PONTO E VIRGULA OU SINAL DE MAIS');

         IF (T20<>'38') AND (T20<>'26') THEN
             ERROS('ERRO ESPERANDO PONTO E VIRGULA OU SINAL DE MAIS',T61);

         IF T20='26' THEN {SE PONTO E VIRGULA SAI}
            H1:=0;


 END;

END;


{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE AS VARIAVEL TIPO ARRANJO                        *
* EXEMPLO: A[1]                                                             *
******************************************************************************
}
PROCEDURE IDVARARRANJO;
BEGIN
      PEER('ERRO ESPERANDO ABRE COLCHETES');

       IF T20<>'29' THEN
            ERROS('ESPERANDO ABRE COLCHETES',T61);

      PEER('ERRO ESPERANDO NUMERO');

       IF T20<>'44' THEN
            ERROS('ESPERANDO NUMERO',T61);

     PEER('ERRO ESPERANDO FECHA COLCHETES');

      IF T20<>'30' THEN
           ERROS('ESPERANDO FECHA COLCHETES',T61);
END;


{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE AS VARIAVEL NO DO TIPO INTEIRO                  *
* EXEMPLO:A:=A;A:=1+1;A:=A+1;A:=(A+A)/A;A:=(1*5)/(A+A);A:=(1-A)/(A+2)*2;    *
******************************************************************************
}
PROCEDURE IDVARINTEIRO;
VAR
   TIPO2,H1,P1,P2,P3:INTEGER;
   P4               :STRING[2];

{
   P1 QUANTIDADE DE ABRE PARENTESES
   P2 QUANTIDADE DE FECHA PARENTESES
}
BEGIN
  P3:=0;
   P1:=0;
   P2:=0;

      H1:=1;
            PEER('ERRO ESPERANDO ATRIBUICAO');
  WHILE H1=1 DO
  BEGIN
    
      IF (T20<>'45')AND(T20<>'44')AND(T20<>'27')AND(T20<>'28')AND(T20<>'26')
          AND(T20<>'40')AND(T20<>'38')AND(T20<>'41')    THEN { ( ) 1 V  - + *}
            ERROS('ERRO ESPERANDO VARIAVEL,NUMERICO OU SINAL DE OPERACAO',T61);

         IF (T20='26')  THEN   {PONTO E VIRGULA}
          BEGIN
               IF P3=1 THEN
               BEGIN
                    IF P1<>P2 THEN { SE QUANTIDADE PARENTESES DIVERENTES }
                         ERROS('ERRO ESPERANDO FECHA PARENTESES OU ABRE',T61);
                  H1:=0;
               END
               ELSE
                  ERROS('ERRO ESPERANDO NUMERO OU VARIAVEL',T61);
           END;

           IF (T20='28') THEN { ) }
            BEGIN
             IF P3=0 THEN { SE I:=) ->ERRO }
              ERROS('ERRO NA EXPRECAO',T61);
            END;
           IF (T20='41') THEN { ) }
            BEGIN
             IF P3=0 THEN { SE I:=* ->ERRO }
              ERROS('ERRO NA EXPRECAO',T61);
            END;


    IF H1<>0 THEN
    BEGIN
        P3:=1;
      IF T20='45' THEN { VARIVEL }
          BEGIN
               TIPO2:=PROCURAVAR(T60);
               IF TIPO2<>TIPO THEN
                    ERROS('TIPOS INCOMPATIVEIS',T61);
                    P4:=T20;
          END;

      IF T20='28' THEN    { ) }
         BEGIN
            P2:=P2+1;
            IF P1<P2 THEN
               ERROS('ERRO ESPERANDO ABRE PARENTECES',T61);
               P4:=T20;
          END;

      IF T20='27' THEN { (  }
        BEGIN
          P1:=1+P1;
          P4:=T20;
        END;

      IF T20='44' THEN  {NUMERO}
         P4:=T20;
       IF T20='38' THEN {+}
         P4:=T20;
       IF T20='40' THEN {-}
         P4:=T20;
       IF T20='41' THEN
          P4:=T20;

      PEER('ERRO NA EXPRECAO OU ESPERANDO PONTO E VIRGULA');

       IF P4='27' THEN { ( }
        BEGIN
           IF (T20='26')OR(T20='28')AND(T20='41') THEN
               ERROS('ERRO ESPERANDO NUMERO,SINAL,VARIAVEL',T61);
        END;
        IF P4='38' THEN {+}
         BEGIN
             IF (T20='38')OR(T20='40')OR(T20='41')OR(T20='28')OR(T20='26')THEN
                  ERROS('ERRO ESPERANDO VARIAVBEL,NUMERO',T61);
         END;
         IF P4='40' THEN {-}
         BEGIN
             IF (T20='38')OR(T20='40')OR(T20='41')OR(T20='28')OR(T20='26')THEN
                  ERROS('ERRO ESPERANDO VARIAVBEL,NUMERO',T61);
         END;

        IF P4='28' THEN {)}
         BEGIN
             IF (T20='45')OR(T20='44')OR(T20='27') THEN
                ERROS('ERRO ESPERANDO SINAL DE OPERACAO',T61);
         END;

         IF P4='41' THEN {*}
           BEGIN
               IF (T20<>'27')AND(T20<>'44')AND(T20<>'45')AND(T20<>'38')AND(T20<>'40') THEN
                  ERROS('ERRO ESPERANDO NUMERO,VARIAVEL',T61);
            END;

          IF P4='45' THEN {VARIAVEL }
            BEGIN
               IF (T20='27')OR(T20='44')OR(T20='45') THEN
                    ERROS('ERRO ESPERANDO SINAL DE OPERACAO',T61);
             END;

            IF P4='44' THEN {NUMERO }
            BEGIN
               IF (T20='27')OR(T20='44')OR(T20='45') THEN
                    ERROS('ERRO ESPERANDO SINAL DE OPERACAO',T61);
             END;
         END;  {H1}
  END; { WHILE }
END; { FIM }
{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE AS VARIAVEL NO PROGRAMA PRINCIPAL               *
* EXEMPLO: A:=A; A:='FDFDF';  A:=A+'KKK'; A:=1+1; A:=A+1; A:='DFD'+'LL'     *
******************************************************************************
}
 PROCEDURE IDVAR;
  VAR
  TIPO2:INTEGER;
 BEGIN
   TIPO:=PROCURAVAR(T60);
        IF TIPO=2 THEN { ARRANJO }
          BEGIN
            IDVARARRANJO;
          END;
   PEER('ERRO ESPERANDO SINAL DE ATRIBUICAO');

      IF (T20<>'31') AND (TIPO<>2) THEN
          ERROS('ERRO ESPERANDO SINAL DE ATRIBUICAO',T61);

        IF TIPO=14 THEN { CARACTER }
           IDVARCARACTER;

        IF TIPO=17 THEN   {INTEIRO}
            IDVARINTEIRO;
 END;
{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE O COMANDO PARA                                  *
*****************************************************************************
}
PROCEDURE IDFOR;
VAR
TIPO,TIPO2:INTEGER;
  VAR1,VAR2:STRING[8];
BEGIN
    FOR I:=1 TO 8 DO
      BEGIN
        VAR1[I]:=' ';
        VAR2[I]:=' ';
      END;
        VAR1:='';
        VAR2:='';
     PEER('ERRO ESPERANDO VARIAVEL');
    IF T20='45' THEN {VARIAVEL}
         TIPO:=PROCURAVAR(T60)
     ELSE
        ERROS('ESPERANDO VARIAVEL',T61);

     PEER('ERRO ESPERANDO ATRIBUICAO');
     IF T20<>'31' THEN
        ERROS('ESPERANDO ATRIBUICAO',T61);

      PEER('ERRO ESPERANDO NUMERO OU CARACTER');

      IF (T20='35')  THEN  {CADEIA}
       BEGIN

         IF (TIPO=17) THEN  {INTEIRO}
              ERROS('ERRO ATRIBUICAO INVALIDA',T61);
            VAR1:=T60;
       END
       ELSE
         IF T20='44' THEN   {NUMERO}
          BEGIN
           IF (TIPO=14) THEN {CADEIA}
              ERROS('ERRO ATRIBUICAO INVALIDA',T61);
               VAR1:=T60;
       END
       ELSE
          IF T20='45' THEN  { VARIAVEL }
            BEGIN
                TIPO2:=PROCURAVAR(T60);
                     IF TIPO2<>TIPO THEN
                          ERROS('TIPO INCOPATIVEIS',T61);

            END
           ELSE
           ERROS('ESPERANDO ATRIBUICAO',T61);

       PEER('ESPERANDO ATE');
       IF T20<>'16' THEN
          ERROS('ERRO ESPERANDO ATE',T61);

        PEER('ESPERANDO VARIAVEL OU NUMERO');

        IF T20='45' THEN  { VARIAVEL }
         BEGIN
           TIPO2:=PROCURAVAR(T60);
            IF TIPO2<>TIPO THEN
                ERROS('TIPO INCOPATIVEIS',T61);
          END
         ELSE
           IF T20='35' THEN { CADEIA }
           BEGIN
              IF TIPO=17 THEN  {INTEIRO}
                ERROS('TIPO INCOPATIVEL',T61);
                  VAR2:=T60;
           END
            ELSE
               IF T20='44' THEN {NUMERO}
                BEGIN
                   IF TIPO=14 THEN  {CARACTER}
                         ERROS('TIPO INCOPATIVEL',T61);
                        VAR2:=T60;
                END
                ELSE
                    ERROS('ESPERANDO CADEIA, NUMERO ,VARIAVEL',T61);
                   IF VAR2<>'' THEN
                     BEGIN
                        IF VAR1>VAR2 THEN
                          ERROS('ERRO EXPRECAO 1 MAIOR QUE EXPRECAO 2',T61);
                       END;

           PEER('ERRO ESPERANDO FACA') ;

           IF T20<>'6' THEN
                ERROS('ESPERANDO FACA',T61);


END;
{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE O COMANDO LEIA                                  *
*****************************************************************************
}

PROCEDURE IDLEIA;
VAR
TIPO:INTEGER;
BEGIN
     PEER('ERRO ESPERANDO ABRE PARENTESES');
      IF T20<>'27' THEN
         ERROS('ESPERANDO ABRE PARENTESES',T61);
      PEER('ERRO ESPERANDO VARIAVEL');
      IF T20='45' THEN
        BEGIN
        TIPO:=PROCURAVAR(T60);

        END
        ELSE
           ERROS('ESPERANDO VARIAVEL',T61);
        PEER('ERRO ESPERANDO FECHA PARENTESES');
        IF T20<>'28' THEN
           ERROS('ESPERANDO FECHA PARENTESES',T61);
           PEER('ESPERANDO PONTO E VIRGULA');

         IF T20<>'26' THEN
            ERROS('ESPERANDO PONTO E VIRGULA',T61);


END;
{
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE  CONDICOES -> (A=4)  (F<=4)E (4=5)  (F=5)OR     *
*****************************************************************************
}
PROCEDURE IDCONDICAO;
VAR
   HJ,EN,ABRE,FECHA,SO:BYTE;
   P4:STRING[2];
   TIPO2:INTEGER;
BEGIN
  ABRE:=0;
  FECHA:=0;
  HJ:=0;
  EN:=0;
  TIPO2:=0;
  SO:=0;
 PEER('ESPERANDO CONDICAO');
WHILE HJ=0 DO
BEGIN

 IF (T20<>'45')AND(T20<>'42')AND(T20<>'44')AND(T20<>'45')AND(T20<>'35')AND
    (T20<>'27')AND(T20<>'28')AND(T20<>'21')AND(T20<>'11')AND
    (T20<>'46')AND(T20<>'48')AND(T20<>'49')AND(T20<>'50')AND(T20<>'47')
     AND(T20<>'15')AND(T20<>'6')AND(T20<>'26') THEN
           ERROS('ERRO NA CONDICAO',T61);

         IF (T20='15')OR(T20='6')OR(T20='26')THEN { ENTAO,FACA, ; }
           BEGIN
              IF EN=0 THEN    {SE ENTROU PRIMEIRA FEZ ERRO}
                 ERROS('ERRO NA CONDICAO',T61);
              IF ABRE<>FECHA THEN
                 ERROS('ESPERANDO ABRE OU FECHA PARENTESES',T61);
                HJ:=1;
           END;


  IF HJ=0 THEN
   BEGIN
       IF (T20='46')OR(T20='48')OR(T20='49')OR(T20='50')
           OR(T20='47')OR(T20='28')OR(T20='11')OR(T20='21')OR(T20='42')
                                    THEN
           BEGIN
              IF EN=0 THEN    {SE ENTROU PRIMEIRA FEZ ERRO}
                 ERROS('ERRO NA CONDICAO',T61);
            END;

         IF T20='27' THEN { ( }
             ABRE:=ABRE+1;

         IF T20='28' THEN   { ) }
          BEGIN
               FECHA:=FECHA+1;
              IF FECHA>ABRE THEN
                ERROS('ESPERANDO ABRE PARENTESES',T61);
          END;

        EN:=1;
        P4:=T20;{ GUARDA ANTERIOR }

    IF T20='45' THEN   { VARIAVEL }
     BEGIN
        TIPO:=PROCURAVAR(T60);{GUARDA O TIPO DA VARIAVEL SE INTEIRA ETC..}
         IF TIPO2<>0 THEN    {SE ENTROU OUTRA VARIAVEL NA CONDICAO}
            IF TIPO<>TIPO2 THEN  {SE OS TIPOS SAO DIFERENTES}
                  ERROS('TIPOS INCOMPATIVEIS',T61);
            SO:=SO+1; {VARIAVEL AUXILIAR PARA COMPARAR DUAS VARIAVEIS}
           IF SO=1 THEN
             TIPO2:=TIPO
           ELSE
           BEGIN
              TIPO2:=0;  {ENTROU OUTRA VARIAVEL EM OUTRA CONDICAO}
              SO:=0;
           END;
    END;

            PEER('ERRO NA CONDICAO');

{********** ANTERIOR *******************}

         IF P4='45' THEN {DEPOIS DE VARIAVEL}
            BEGIN
              IF (T20<>'28')AND(T20<>'46')AND(T20<>'48')AND(T20<>'49')
                  AND(T20<>'50')AND(T20<>'47')AND(T20<>'26')
                  AND(T20<>'15')AND(T20<>'6')AND(T20<>'42') THEN
                  ERROS('ERRO NA CONDICAO',T61);
            END;

         IF (P4='46')OR(P4='48')OR(P4='49') { SE SINAL DE COMPARACAO }
             OR(P4='50')OR(P4='47')OR(P4='42') THEN
          BEGIN
             IF(T20<>'45')AND(T20<>'27')AND(T20<>'35')AND(T20<>'44')THEN
                 ERROS('ESPERANDO COMPARACAO',T61);
          END;



        IF P4='27' THEN  {(}
          BEGIN
             IF (T20<>'45')AND(T20<>'44')AND(T20<>'35')AND(T20<>'27') THEN
               ERROS('ERRO NA CONDICAO',T61);
          END;

         IF P4='28' THEN {)}
           BEGIN
           IF (T20<>'21')AND(T20<>'11')AND(T20<>'46')AND(T20<>'47')AND
              (T20<>'48')AND(T20<>'49')AND(T20<>'50')AND(T20<>'26')
              AND(T20<>'42')AND(T20<>'15')AND(T20<>'6')AND(T20<>'28') THEN
                ERROS('ESPERANDO CONDICAO',T61);
           END;

         IF (P4='21')OR(P4='11')THEN { E OU }
           BEGIN
             IF T20<>'27'THEN    { ( }
               ERROS('ESPERANDO ABRE PARENTESES',T61);
            END;

         IF P4='44' THEN   {NUMERO}
           BEGIN
              IF (T20<>'28')AND(T20<>'26')AND(T20<>'46')AND(T20<>'47')AND
              (T20<>'48')AND(T20<>'49')AND(T20<>'50')AND(T20<>'42')
              AND(T20<>'15')AND(T20<>'6')THEN
                ERROS('ESPERANDO CONDICAO',T61);
              IF TIPO<>0 THEN
               BEGIN
                 IF TIPO<>17 THEN   {VARIAVEL NAO INTEIRA}
                    ERROS('ERRO DE ATRIBUICAO',T61);
               END;
          END;

         IF P4='35'THEN {CADEIA DE CARACTERES}
           BEGIN
           IF (T20<>'28')AND(T20<>'26')AND(T20<>'46')AND(T20<>'47')AND
              (T20<>'48')AND(T20<>'49')AND(T20<>'50')AND(T20<>'42')
                AND(T20<>'15')AND(T20<>'6')THEN
                ERROS('ESPERANDO CONDICAO',T61);
              IF TIPO<>0 THEN
               BEGIN
                 IF TIPO<>14 THEN   {VARIAVEL NAO CARACTER}
                    ERROS('ERRO DE ATRIBUICAO',T61);
               END;

           END;

   END;
END;
END;



 {
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE O COMANDO ESCREVA                               *
*****************************************************************************
}
PROCEDURE IDESCREVA;
VAR
  HJ,V0:BYTE;
  P4:STRING[2];
BEGIN
    PEER('ERRO ESPERANDO ABRE PARENTESES');
   IF T20<>'27' THEN { ( }
      ERROS('ESPERANDO ABRE PARENTESES',T61);
     HJ:=0;
     V0:=0;
        PEER('ERRO ESPERANDO ABRE PARENTESES');
   WHILE HJ=0 DO
   BEGIN
      IF (T20<>'45')AND(T20<>'35')AND(T20<>'28')AND
         (T20<>'32')AND(T20<>'26')  THEN { VARIAVEL , 'DJKNDKJ44', VIRGULA , ) ; }
         ERROS('ESPERANDO VARIAVEL OU CADEIA DE CARACTERES',T61);

     IF T20='28' THEN       { ) }
      BEGIN
           HJ:=1;
        IF V0=0 THEN
           ERROS('ERRO NO COMANDO ESCREVA',T61)
         ELSE
         BEGIN
           PEER('ERRO ESPERANDO PONTO E VIRGULA');
           IF T20<>'26' THEN
             ERROS('ERRO ESPERANDO PONTO E VIRGULA',T61);
          END;
      END;

      IF T20='32' THEN { , }
        IF V0=0 THEN
           ERROS('ERRO NO COMANDO ESCREVE',T61);

      IF T20='45' THEN   { VARIAVEL }
         TIPO:=PROCURAVAR(T60);

     IF HJ=0 THEN
      BEGIN
           V0:=1;
            P4:=T20;
          PEER('ERRO NO COMANDO ESCREVA');

          IF P4='35' THEN   {DEPOIS CADEIA DE CARACTER }
             IF (T20<>'28')AND(T20<>'32') THEN
                    ERROS('ERRO NO COMANDO ESCREVE',T61);

          IF P4='45' THEN  { DEPOIS DE VARIAVEL }
               IF (T20<>'28')AND(T20<>'32') THEN
                    ERROS('ERRO NO COMANDO ESCREVE',T61);

          IF P4='32' THEN {DEPOIS VIRGULA }
                  IF (T20<>'35')AND(T20<>'45') THEN
                    ERROS('ERRO NO COMANDO ESCREVE',T61);
      END;


  END;

 END;

 {
*****************************************************************************
* PROCEDIMENTO  QUE ANALISE O PROGRAMA PRINCIPAL                            *
*****************************************************************************
}

 PROCEDURE BLOCO2;
 VAR
 H4,IN1,FI1,RE1,RE2,ATE1:BYTE;

 BEGIN
         {$I-}
         RESET(ARQ2);
         {$I+}
         H4:=0;
         IN1:=0;{ SOMA OS TOTAIS DE INICIO }
         FI1:=0;{ SOMA OS TOTAIS DE FIM    }
         RE1:=0; { INDICA QUE ENTROU UM REPITA }
         RE2:=0; {SOMA O NUMERO DE REPITA}
         ATE1:=0; {SOMA O NUMERO DE ATE DO REPITA}

  WHILE H4=0 DO
  BEGIN

IF(T20<>'45')AND(T20<>'1')AND(T20<>'4')AND(T20<>'9')AND(T20<>'8')AND(T20<>'3')
 AND(T20<>'10')AND(T20<>'13')AND(T20<>'18')AND(T20<>'20')AND(T20<>'33')
 AND(T20<>'16')AND(T20<>'6')AND(T20<>'15')AND(T20<>'7')AND(T20<>'36') THEN
         ERROS('ERRO DE LOCAL OU ESPERANDO INICIO',T61);


       IF T20='45' THEN { VARIAVEL }
            IDVAR;

      

     IF T20='1' THEN  { FIM }
      BEGIN
              FI1:=FI1+1;

          IF FI1>IN1 THEN     { TEM FIM SEM INICIO }
            ERROS('ESPERANDO INICIO',T61);

        PEER('ESPERANDO PONTO FINAL OU PONTO E VIRGULA');

           IF (T20<>'26') AND (T20<>'33')  THEN { . ; }
               ERROS('ESPERANDO PONTO E VIRGULA OU PONTO',T61);
      END;

       IF T20='3' THEN  { INICIO }
           IN1:=IN1+1;

        IF T20='9' THEN {PARA}
           IDFOR;


       IF T20='33' THEN { PONTO FINAL }
         BEGIN
           IF IN1<>FI1 THEN   { SE EXISTE DIFERENSAS ENTRE FIM E INICIO }
              ERROS('ESPERANDO FIM OU INICIO',T61);
           IF RE1<>ATE1 THEN
             ERROS('ESPERANDO REPITA OU  ATE',T61);
              H4:=1;
         END;

        IF T20='8' THEN {COMANDO LEIA}
          IDLEIA;
         IF T20='20' THEN { COMANDO ESCREVA }
             IDESCREVA;

         IF T20='18'THEN { COMANDO ENQUANTO }
          BEGIN
               IDCONDICAO;
           IF T20<>'6' THEN   {FACA}
             ERROS('ESPERANDO FACA',T61);
           END;

           IF T20='10'THEN { COMANDO SE }
           BEGIN
               IDCONDICAO;
           IF T20<>'15' THEN   {ENTAO}
             ERROS('ESPERANDO ENTAO',T61);
           END;
           IF T20='16' THEN { ATE }
            BEGIN
               ATE1:=ATE1+1; { SOMA NUMEROS DE ATE }
               IF ATE1>RE1 THEN
                  ERROS('ESPERANDO REPITA',T61);

               IDCONDICAO;
               IF T20<>'26'THEN    { PONTO E VIRGULA }
                 ERROS('ESPERANDO PONTO E VIRGULA',T61);

            END;


          IF T20='13' THEN {COMANDO REPITA }
            BEGIN
               RE1:=1;
               RE2:=RE2+1;
               PEER('ESPERANDO PONTO E VIRGULA');
               IF T20<>'26' THEN { ; }
                   ERROS('ESPERANDO PONTO E VIRGULA',T61);
           END;


         IF H4<>1 THEN  {CASO NAO SEJA PONTO FINAL }
           PEER('EERO DE LOCAL OU ESPERANDO INICIO OU FIM');

    END;

 END;

 PROCEDURE BLOCO;
 BEGIN
     PEER('ERRO ESPERANDO IDENTIFICACAO DE VARIAVEIS OU INICIO');

      IF T20='36' THEN {COMENTARIO}
        PEER('ERRO ESPERANDO IDENTIFICACAO DE VARIAVEIS OU INICIO');

      IF T20='19' THEN
          PVARIAVEL;
      IF T20<>'3' THEN
           ERROS('ERRO ESPERANDO INICIO',T61);

         BLOCO2;
      CLOSE(ARQ2);
      CLOSE(ARQ1);
{ HALT;}
 END;

 PROCEDURE RECON;
 BEGIN
     PEGA2;
      IF (T20='12') AND (L<>0) THEN {SE PROGRAMA E NAO E FIM DE ARQUIVO}
      BEGIN
         PEGA2;
            IF (T20='45') AND (L<>0) THEN {SE NOME DO PROGRAMA}
                 BEGIN
                      PEGA2;
                          IF (T20='26') AND (L<>0) THEN   {SE PONTO E VIRGULA}
                           BEGIN
                             BLOCO;
                            END
                            ELSE
                              ERROS('ERRO ESPERANDO PONTO E VIRGULA',T61);

                  END
                    ELSE
                         ERROS('ERRO NOME DO PROGRAMA',T61);

      END
      ELSE
            ERROS('ERRO ESPERANDO PROGRAMA',T61);
 END;
{
 *************************************************************************
 *                               GRAMATICA                               *
 *                                                                       *
 *************************************************************************
 }
 PROCEDURE PEGA; {PROCEDIMENTO PARA LER UMA LINHA DO ARQUIVO}
 BEGIN
  IF NOT SEEKEOF(ARQ) THEN { SE NAO E FIM DE ARQUIVO }
    BEGIN
     LINHA:=LINHA+1;
     FOR I:=1 TO 249 DO   { INICIALIZANDO A VARIAVEL CAR }
      BEGIN
         CAR[I]:=' ';
         CAR2[I]:=' ';
      END;
         CAR:='';
         CAR2:='';
        READLN(ARQ,CAR);
       L:=1;                { VARIAVEL AXILIAR QUE INDICA FIM DO ARQUIVO }
       TAMANHO:=LENGTH(CAR);{ PEGA O TAMANHO DA STRING LIDA DO ARQUIVO   }
      FOR I:=1 TO TAMANHO+1 DO
        BEGIN
             CAR2[I]:=UPCASE(CAR[I]);
             CAR[I]:=CAR2[I]; { TRANSFORMANDO PARA MAIUSCULO }
         END;
  END    { SE FOR FIM DE ARQUIVO }
   ELSE
        L:=0;{ VARIAVEL AUXILIAR QUE INDICA FIM DE ARQUIVO QUANDO L=0 }
   END;
{************************************************************************}
 PROCEDURE IDENTIFICA(VAR T5:BYTE); { PROC.QUE RECONHECE PALAVRAS RECERVADAS DO PASCAL}
 VAR
     O,U2:BYTE;
     VAR4:STRING[20];
 BEGIN
   U2:=1;
  IF T5=36 THEN {COMENTARIO}
   BEGIN
        VAR4:=COD1[36];
        CODI:=36;
        I:=50;
        U2:=0;

   END
   ELSE
   IF T5=2 THEN    {SIMBOLOS}
     BEGIN
     FOR I:=25 TO 50 DO
      BEGIN
         IF TE=COD1[I]  THEN
            BEGIN
                U2:=0;
                VAR4:=COD1[I];
                CODI:=I;
                I:=50;
            END;
        END;
  END
  ELSE
     IF T5=4 THEN      {NUMERO}
          BEGIN
             VAR4:=COD1[44];
             U2:=0;
             CODI:=44;
          END
      ELSE
       IF T5=35 THEN  {CADEIA DE CARACTERES}
         BEGIN
             U2:=0;
             VAR4:=COD1[35];
             CODI:=35;
          END
         ELSE
           IF T5=53 THEN  {ERRO}
              BEGIN
               VAR4:=COD1[53];
               U2:=0;
               CODI:=53;
               ERRO:=ERRO+1;
          END
          ELSE
          FOR O:=1 TO 24 DO    {RESERVADA}
          BEGIN
           IF (COD1[O]=TE) THEN  { VERIFICA SE E UMA PALAVRA RECERVADA}
            BEGIN
             VAR4:=COD1[O];
              CODI:=O;
               O:=24;             { SAI DO LACO               }
               U2:=0;
            END;
          END;


       IF U2=1 THEN   {VARIAVEL}
        BEGIN
             CODI:=45;
             VAR4:=COD1[45];
        END;

         GOTOXY(15,16);
         WRITELN('COMPILANDO..:',NOMEARQ,' DATA:',DIA,'/',MES,'/',ANO);
         GOTOXY(15,17);
         WRITELN('TOTAL BYTES.:',SOMA);
         GOTOXY(15,18);
         WRITELN('TOTAL LINHAS:',LINHA);
         GOTOXY(15,19);
         WRITELN('ERROS.......:',ERRO);
   END;

{***********************************************************************}

{*************************************************************************}

PROCEDURE DIGITO; { RECONHECENDO DIGITOS INTEITOS SEM SINAL}
   VAR
          T,LE1:INTEGER;
   BEGIN
      T:=0; { ESTADO RECONHECEDOR SE T=0 NAO RECONHECE T=1 RECONHECE}
   FOR I:=CONT TO tamanho+1 DO
    BEGIN
      T:=0;
        I:=CONT;
      CASE ord(CAR[I]) OF
       48..57:BEGIN { NUMEROS}
              T:=1;
            END;
      END; { fim case }
       {NAO RECONHECE}
         IF T=0 THEN
          begin
            CODI:=44;
           { PILHA;}
            T4:=4;
            IDENTIFICA(T4);
            i:=tamanho+1;
           CONT:=CONT-1;{ CONT DEVE RETONAR AO ELEMENTO QUE NAO RECONHECEDOR}
          end
          else
             TE:=TE + CAR[I];
             CONT:=CONT+1;
    END; { END DO FOR }
  END;
  PROCEDURE DIGITOMAIS; { RECONHECE DIGITOS INTEIROS COM SINAL MAIS +}
   VAR
          T,LE1,U:INTEGER;
   BEGIN
      T:=0; { ESTADO RECONHECEDOR SE T=0 NAO RECONHECE T=1 RECONHECE}
      LE1:=CONT; { GUARDA O SINAL }
      CONT:=CONT+1;  { AVANCA PARA O PROXIMO CARACTER}
      I:=CONT;
      U:=0;
   WHILE I<=tamanho+1 DO
    BEGIN
      T:=0;
      I:=CONT;
      CASE ord(CAR[I]) OF
       48..57:BEGIN { NUMEROS}
              T:=1;
              U:=1;
            END;
      END; { fim case }
       {NAO RECONHECE}
    IF T=0 THEN
     BEGIN
            IF U = 1  THEN   { SE ENTROU NUMERO OU NAO}
             CODI:=44
            ELSE
              CODI:=38;
           TE:=CAR[LE1]+TE;
           T4:=2;
           IDENTIFICA(T4);
        i:=tamanho+2;
        CONT:=CONT-1;{ CONT DEVE RETONAR AO ELEMENTO QUE NAO RECONHECEDOR}
    END
     ELSE
         TE:=TE+CAR[I];
         CONT:=CONT+1;
    END; { END DO WHILE }
  END;
  PROCEDURE DIGITOMENOS; { RECONHECE DIGITOS INTEIROS COM SINAL MENOS -}
   VAR
          T,LE1,U:INTEGER;
   BEGIN
      T:=0; { ESTADO RECONHECEDOR SE T=0 NAO RECONHECE T=1 RECONHECE}
      LE1:=CONT;{ GUARDA O SINAL MENOS}
      CONT:=CONT+1;
      I:=CONT;
      U:=0;
   WHILE I<= tamanho+1 DO
    BEGIN
      T:=0;
        I:=CONT;
      CASE ord(CAR[I]) OF
       48..57:BEGIN { NUMEROS}
              T:=1;
              U:=1;
            END;
      END; { fim case }
       {NAO RECONHECE}
         IF T=0 THEN
          begin
           IF U=1 THEN
           BEGIN
            CODI:=44;
            END
           ELSE
            CODI:=40;
            TE:=CAR[LE1]+TE;
           { PILHA;}
           T4:=2;
           IDENTIFICA(T4);
            i:=tamanho+2;
          end
          else
            TE:=TE + CAR[I];
           IF T<>0 THEN { SO IR PARA O PROXIMO CASO RECONHECER}
            CONT:=CONT+1;
    END; { END DO FOR }
  END;
    PROCEDURE PONTOS; { RECONHECE DOIS PONTOS : E := }
   VAR
         LE1,U:INTEGER;
   BEGIN
      LE1:=CONT; { GUARDA A POSICAO DOS DOIS PONTOS }
      CONT:=CONT+1; { VAI PARA O PROXIMO CARACTER }
      I:=CONT;
      U:=0; { VARIAVEL AXILIAR QUE INDICA SE ENTRO = }
   WHILE I<= tamanho+1 DO
    BEGIN
        I:=CONT;
      CASE ord(CAR[I]) OF
       61:BEGIN { IGUAL }
              U:=1;
            END;
      END; { fim case }
           IF U=1 THEN
           BEGIN
            CODI:=31;
            TE:=CAR[LE1]+CAR[I];
           END
           ELSE
            BEGIN
            CODI:=25;
            TE:=CAR[LE1];
           END;
            {   PILHA;}
             T4:=2;
           IDENTIFICA(T4);
               i:=tamanho+2;
              IF U<>0 THEN
               CONT:=CONT+1;
    END; { END DO FOR }
  END;
   PROCEDURE MENOR; { < }
   VAR
          LE1,U,V60:INTEGER;
   BEGIN
      V60:=0;
      LE1:=CONT;
      CONT:=CONT+1;
      I:=CONT;
      U:=0;
   WHILE I<= tamanho+1 DO
    BEGIN
        V60:=V60+1;
        I:=CONT;
      CASE ord(CAR[I]) OF
       61:BEGIN { IGUAL }
              U:=1;
            END;
       62:BEGIN { MAIOR > }
              U:=2;
            END;
      END; { fim case }
       IF U=1 THEN   { <= }
         BEGIN
            CODI:=48;
            TE:=CAR[LE1]+CAR[I];
         END
         ELSE
         IF U=2 THEN {<>}
           BEGIN
               CODI:=50;
               TE:=CAR[LE1]+CAR[I];
           END
            ELSE
              IF V60=1 THEN
               BEGIN
                  CODI:=46;
                  TE:=CAR[LE1];
                END
               ELSE
                BEGIN
                 CODI:=53;
                 TE:=CAR[I];
                END;
          IF CODI<>53 THEN
             T4:=2
           ELSE
              T4:=53;
           IDENTIFICA(T4);
           i:=tamanho+2;
           { CONT DEVE RETONAR AO ELEMENTO QUE NAO RECONHECEDOR}
           IF U<>0 THEN { DEVE SOMAR SO E SOMENTE SE RECONHECER }
            CONT:=CONT+1;
    END; { END DO FOR }
  END;
   PROCEDURE MAIOR; { > }
   VAR
          LE1,U:INTEGER;
   BEGIN
      LE1:=CONT;
      CONT:=CONT+1;
      I:=CONT;
      U:=0;
   WHILE I<= tamanho+1 DO
    BEGIN
        I:=CONT;
      CASE ord(CAR[I]) OF
       61:BEGIN { IGUAL }
              U:=1;
            END;
      END; { fim case }
           IF U=1 THEN
           BEGIN
            CODI:=46;
            TE:=CAR[LE1]+CAR[I];
           END
           ELSE
               BEGIN
                 CODI:=58;
                 TE:=CAR[LE1];
               END;
             T4:=2;
           IDENTIFICA(T4);
            i:=tamanho+2;
           { CONT DEVE RETONAR AO ELEMENTO QUE NAO RECONHECEDOR}
           IF U<>0 THEN
            CONT:=CONT+1;
    END; { END DO FOR }
  END;
   PROCEDURE RETICENCIAS; { .. }
   VAR
          LE1,U:INTEGER;
   BEGIN
      LE1:=CONT;
      CONT:=CONT+1;
      I:=CONT;
      U:=0;
   WHILE I<= tamanho+1 DO
    BEGIN
        I:=CONT;
      CASE ord(CAR[I]) OF
       46:BEGIN { . }
              U:=1;
            END;
      END; { fim case }
         IF U=1 THEN
           BEGIN
            CODI:=33;
            TE:=CAR[LE1]+CAR[I];
           { PILHA}
            T4:=2;
           IDENTIFICA(T4);
           END
           ELSE
            BEGIN
              CODI:=34;
              TE:=CAR[LE1];
              { PILHA}
            T4:=2;
           IDENTIFICA(T4);
            END;
            i:=tamanho+2;
           { CONT DEVE RETONAR AO ELEMENTO QUE NAO RECONHECEDOR}
           IF U<>0 THEN
            CONT:=CONT+1;
    END; { FIM WHILE }
  END;
    { FIM RETICENCIAS ..  **************}
  PROCEDURE LETRAS;
  VAR
          T,LE1:INTEGER;
   BEGIN
   LE1:=1;
   I:=CONT;
   WHILE I<=TAMANHO+1 DO
   BEGIN
        T:=0;
        I:=CONT;
      CASE ord(CAR[I]) OF
       97..122:BEGIN { a ATE z }
                T:=1;
               END;
       65..90:BEGIN     {A ATE Z}
               T:=1;
              END;
       48..57:BEGIN     {NUMEROS 0 A 9}
              T:=1;
              LE1:=0;
             END;
      95: BEGIN          {ANDERLAINE '_' }
             T:=1;
             LE1:=0;
          END;
      END; { fim case }
      IF T=0 THEN
        BEGIN
           IF LE1=0 THEN
           BEGIN
               CODI:=45;
               { PILHA}
            T4:=1;
           IDENTIFICA(T4);
               i:=tamanho+2;
            END;
          IF LE1=1 THEN
           BEGIN
           {  RESERVADA;}
            T4:=1;
           IDENTIFICA(T4);
             i:=TAMANHO+2;
           END;
     END
     ELSE
         TE:=TE + CAR[I];
           IF T<>0 THEN
            CONT:=CONT+1;
    END; { END DO FOR }
  END;

  PROCEDURE CHIFRE;
  VAR
          T,LE1:INTEGER;
   BEGIN
      T:=0;
      I:=CONT;
  WHILE I<=tamanho+1 DO
   BEGIN
        I:=CONT;
      CASE ord(CAR[I]) OF
        39:BEGIN
              T:=t+1;
            END;
      END; { fim case }
        IF T=2 THEN
        begin
             TE:=TE+CAR[I];
             CODI:=35;
             T4:=35;
             IDENTIFICA(T4);
             i:=tamanho+2;
        END
        ELSE
            TE:=TE + CAR[I];
            CONT:=CONT+1;
            IF CONT>249  THEN
             BEGIN
                CODI:=53;
                T4:=53;
                IDENTIFICA(T4);
             END;
    END; { END DO FOR }
     IF T=1 THEN
      BEGIN
           CODI:=53;
           T4:=53;
           IDENTIFICA(T4);
      END;
  END;

  PROCEDURE CHAVES;
  VAR
          T,LE1:INTEGER;
          TE2:STRING;
   BEGIN
      T:=0;
      I:=CONT;
      TE2:='';

  WHILE I<=tamanho+1 DO
   BEGIN
        I:=CONT;
      CASE ord(CAR[I]) OF
        125:BEGIN
              T:=t+1;
            END;
      END; { fim case }
       IF T=1 THEN
          begin
              TE:=TE+CAR[I];
              CODI:=36;
              T4:=36;
              IDENTIFICA(T4);
             i:=tamanho+2;
          END
         ELSE
            TE:=TE + CAR[I];
            CONT:=CONT+1;
            IF (CONT>TAMANHO+1) AND (T<>1)  THEN
            BEGIN
                TE2:=TE;
                PEGA;
                H:=TAMANHO;
                TE:=TE2;
                  IF L=1 THEN
                    BEGIN
                      SOMA:=CONT+SOMA;
                       CONT:=1;
                       I:=CONT;
                    END
                    ELSE
                       BEGIN
                          CODI:=53;
                          T4:=53;
                          IDENTIFICA(T4);
                           I:=TAMANHO+2;
                           H:=TAMANHO+2;
                       END;
           END;
    END; { END DO WHILE }
  END;


{**************************************************************************}

 PROCEDURE RESERVADAS;
  BEGIN
   COD1[1]:='FIM';
   COD1[2]:='ARRANJO';
   COD1[3]:='INICIO';
   COD1[4]:='CASO';
   COD1[5]:='CONSTANTE';
   COD1[6]:='FACA';
   COD1[7]:='SENAO';
   COD1[8]:='LEIA';
   COD1[9]:='PARA';
   COD1[10]:='SE';
   COD1[11]:='OU';
   COD1[12]:='PROGRAMA';
   COD1[13]:='REPITA';
   COD1[14]:='CARACTER';
   COD1[15]:='ENTAO';
   COD1[16]:='ATE';
   COD1[17]:='INTEIRO';
   COD1[18]:='ENQUANTO';
   COD1[19]:='VARIAVEIS';
   COD1[20]:='ESCREVA';
   COD1[21]:='E';
   COD1[22]:='SEJA';
   COD1[23]:='DE';
   COD1[24]:='NAO';
   COD1[25]:=':';
   COD1[26]:=';';
   COD1[27]:='(';
   COD1[28]:=')';
   COD1[29]:='[';
   COD1[30]:=']';
   COD1[31]:=':=';
   COD1[32]:=',';
   COD1[33]:='.';
   COD1[34]:='..';
   COD1[35]:='CADEIA DE CARACTERES';
   COD1[36]:='{';
   COD1[37]:='}';
   COD1[38]:='+';
   COD1[39]:='/';
   COD1[40]:='-';
   COD1[41]:='*';
   COD1[42]:='=';
   COD1[43]:='$';
   COD1[44]:='NUMERO';
   COD1[45]:='VARIAVEL';
   COD1[46]:='>';
   COD1[47]:='<';
   COD1[48]:='<=';
   COD1[49]:='>=';
   COD1[50]:='<>';
   COD1[53]:='ERRO';


  END;

PROCEDURE ABREARQUIVO;
 BEGIN
       W0:=0;
   WHILE W0=0 DO
      BEGIN
         CLRSCR;
         FAZER_TELA;
         GOTOXY(24,8);
         WRITELN('ษอออออออออออออออออออออออออออป');
         GOTOXY(24,9);
         WRITELN('บ  EQUIPE                   บ ');
         GOTOXY(24,10);
         WRITELN('บ                           บ ');
         GOTOXY(24,11);
         WRITELN('บ  LEONARDO BENEDET         บ ');
         GOTOXY(24,12);
         WRITELN('บ  ANA LUCIA RODRIGES       บ ');
         GOTOXY(24,13);
         WRITELN('บ  JAQUELINE DA LUZ MIGUEL  บ ');
         GOTOXY(24,14);
         WRITELN('บ                           บ ');
         GOTOXY(24,15);
         WRITELN('ศอออออออออออออออออออออออออออผ');
         TECLA:=READKEY;
         GOTOXY(24,18);
         WRITELN('DIGITE 0 PARA SAIR');
         GOTOXY(24,19);
         WRITE('NOME DO ARQUIVO=');
         READLN(NOMEARQ);
         IF NOMEARQ='0' THEN
                   HALT;
         ASSIGN(ARQ,NOMEARQ);
         {$I-}
         RESET(ARQ);
         {$I+}
         IF (IORESULT<>0 ) OR (NOMEARQ='') THEN
             BEGIN
                 WRITELN('ARQUIVO NAO EXISTE');
                 TECLA:=READKEY;
                  W0:=0
             END
             ELSE
               BEGIN
                CLRSCR;
                FAZER_TELA;
                W0:=1;
              END;
      END;
 END;
{
***************************************************
*                 PRINCIPAL                       *
***************************************************
 }
BEGIN
   getdate(ano,mes,dia,var12);
  LINHA:=0;
  SOMA:=0;
  ERRO:=0;
  A:=7;
 {'CAR'->VARIAVEL QUE GUARDA A LINHA DO ARQUIVO LIDO DE 249 CARACTERES }
   RESERVADAS; { COLOCA AS PALAVRAS NO ARRAY COD1 }
   CONT:=0;    { CONTADOR QUE PERCORRE A VARIAVEL CAR (CARACTER A CARACTER }
   SOMA:=0;    { SOMA AS PALAVRAS RESERVADAS }
   ABREARQUIVO;{ ABRINDO ARQUIVO TESTE.PAS }
   ABRE_ARQUIVO;
   TE:='';
   PEGA;       { PROCEDIMENTO QUE LE DO ARQUIVO UMA LINHA DE 249 CARACTERES }
REPEAT;
       CONT:=1; {CONTADOR QUE PERCORRE A VARIAVEL CAR (CARACTER A CARACTER)}
       H:=0;
     WHILE H<=TAMANHO+1 DO
   BEGIN
   SE:=0; { VARIAVEL 'SE'  ESTA FOR SE=1 ENTAO RECONHECEU CASO CONTRARIO NAO}
           IF CONT >= TAMANHO+1 THEN  { CASO CONT ULTRAPAZAR O TAMANHO DA LINHA, IRA PEGAR OUTRA LINHA}
              BEGIN
               PEGA;
               SOMA:=CONT+SOMA;
               CONT:=1;
             END;
 IF L=0 THEN   { "L" SIGUNIFICA QUE CHEGOU O FIM DO ARQUIVO SE L=0 }
 BEGIN
     SE:=0;
     H:=TAMANHO+2;
 END
 ELSE
  BEGIN
             H:=CONT;
           CASE CAR[H] OF  { CAR VARIAVEL QUE CONSTA A LINHA DO ARQUIVO
                             LIDO }
            ' ':BEGIN
                    CONT:=CONT+1;
                    SE:=1;
                 END;
            END;
         CASE ORD(CAR[H]) OF
                 58: BEGIN       {: DOIS PONTOS }
                         SE:=1;
                         PONTOS;
                     END;
                 48..57:BEGIN      { DE 0 A 9}
                            DIGITO;
                            SE:=1;
                      END;
                 97..122:begin { LETRAS MAIUSCULAS}
                             letras;
                             se:=1;
                          end;
                 65..90:BEGIN    {MINUSCULAS}
                            LETRAS;
                            SE:=1;
                        END;
                 60:BEGIN { MENOR <}
                       SE:=1;
                       MENOR;
                    END;
                 62:BEGIN    { MAIOR >}
                        SE:=1;
                        MAIOR;
                   END;
                 46:BEGIN         {PONTO . }
                        SE:=1;
                        RETICENCIAS;
                    END;
                 43: BEGIN {SINAL DE + }
                         SE:=1;
                         TE:='+';
                         CODI:=38;
                         T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;

                 45: BEGIN    { SINAL DE MENOS }
                         SE:=1;
                         TE:='-';
                         CODI:=40;
                         T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                     END;
                 42: BEGIN        { MULTIPLICACAO}
                         SE:=1;
                         TE:='*';
                         CODI:=41;
                         T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;
                 47: BEGIN         { DIVISAO }
                         SE:=1;
                         TE:='/';
                         CODI:=39;
                         T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;
                 40: BEGIN { ABRE PARENTESES }
                         SE:=1;
                         TE:='(';
                         CODI:=27;
                          T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;
                 41: BEGIN { FECHA PARENTESES}
                         SE:=1;
                         TE:=')';
                         CODI:=28;
                         T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;
                 44: BEGIN  { VIRGULA}
                         SE:=1;
                         TE:=',';
                         CODI:=32;
                          T4:=2;
                         IDENTIFICA(T4);
                         CONT:=CONT+1;
                       END;
                 61: BEGIN         { SINAL DE IGUAL = }
                         SE:=1;
                         TE:='=';
                         CODI:=42;
                           T4:=2;
                         IDENTIFICA(T4);
                            cont:=cont+1;
                       END;
                 59:BEGIN     { PONTO E VRIGULA }
                         SE:=1;
                         TE:=';';
                         CODI:=26;
                         T4:=2;
                         IDENTIFICA(T4);
                         cont:=cont+1;
                       END;
                 91:BEGIN      { ABRE COLCHETES }
                        SE:=1;
                        TE:='[';
                        CODI:=29;
                        T4:=2;
                         IDENTIFICA(T4);
                        cont:=cont+1;
                       END;
                 93:BEGIN   { FECHA COLCHETES }
                        SE:=1;
                        TE:=']';
                        CODI:=30;
                        T4:=2;
                         IDENTIFICA(T4);
                        cont:=cont+1;
                    END;
                 39:BEGIN  { ASPAS '}
                       SE:=1;
                       CHIFRE;
                    END;
                 123:BEGIN     { ABRE CHAVES }
                          SE:=1;
                          CHAVES;
                     END;
                 36:BEGIN     { DOLAR $ }
                        SE:=1;
                        TE:='$';
                        CODI:=43;
                        T4:=2;
                         IDENTIFICA(T4);
                        cont:=cont+1;
                    END;
         END; { CASE  PRINCIPAL }
         IF SE=0 THEN { CASO O SE=0 ESTAMOS COM UM NAO RECONHECEDOR}
         BEGIN
           TE:=CAR[H];
           CODI:=53; { 54 CODIGO DE UM NAO RECONHECEDOR}
           CONT:=CONT+1; { PEGA O PROXIMO CARACTER}
            IF TE<>'' THEN
              BEGIN
                STR(CODI,DADO);
                STR(LINHA,DADO2);
                DADO:=DADO+' '+TE+' '+DADO2;
                WRITELN(ARQ1,DADO);
                T4:=53;
                IDENTIFICA(T4);
                TE:='';
              END;

         END
         ELSE
          BEGIN
         IF TE<>'' THEN
          BEGIN
            STR(CODI,DADO);
            STR(LINHA,DADO2);
            DADO:=DADO+' '+TE+' '+DADO2;
            WRITELN(ARQ1,DADO);
          END;
            TE:='';
          END;

    END; {DA CONTICAO QUE INDICA O FIM DO ARQUIVO ESTA SENDO LIDO
          L=0 }
 end;{while}

 UNTIL (L=0);
{************************* FIM DA GRAMATICA **********************}
    
     CLOSE(ARQ);
     CLOSE(ARQ1);
 
     IF ERRO=0 THEN
      BEGIN
         GOTOXY(15,15);
         WRITELN('TODOS OS SIMBOLOS FORAM RECONHECIDOS               ');
         GOTOXY(15,16);
         WRITELN('COMPILANDO..:',NOMEARQ ,' DATA:',DIA,'/',MES,'/',ANO);
         GOTOXY(15,17);
         WRITELN('TOTAL BYTES.:',SOMA);
         GOTOXY(15,18);
         WRITELN('TOTAL LINHAS:',LINHA);
         GOTOXY(15,19);
         WRITELN('ERROS.......:',ERRO);
         GOTOXY(15,20);
     END
     ELSE
      BEGIN
          GOTOXY(15,15);
         WRITELN('OCORERAM ERROS SIMBOLOS NAO RECONHECIDOS          ');
         GOTOXY(15,16);
         WRITELN('COMPILANDO..:',NOMEARQ ,' DATA:',DIA,'/',MES,'/',ANO);
         GOTOXY(15,17);
         WRITELN('TOTAL BYTES.:',SOMA);
         GOTOXY(15,18);
         WRITELN('TOTAL LINHAS:',LINHA);
         GOTOXY(15,19);
         WRITELN('ERROS.......:',ERRO);
         GOTOXY(15,20);
      END;
      SOMA2:=SOMA;

     GOTOXY(24,23);
     WRITELN('TECLE ENTER');
     TECLA:=READKEY;
     GOTOXY(15,15);
     WRITELN('                                        ');

     abre_arquivo2;
     RECON;

       IF ERRO=0 THEN
       BEGIN
         GOTOXY(15,15);
         WRITELN('COMPILACAO PROCESSADA COM SUCESSO  ');
         GOTOXY(15,16);
         WRITELN('COMPILANDO..:',NOMEARQ ,' DATA:',DIA,'/',MES,'/',ANO);
         GOTOXY(15,17);
         WRITELN('TOTAL BYTES.:',SOMA2);
         GOTOXY(15,18);
         WRITELN('TOTAL LINHAS:',LINHA);
         GOTOXY(15,19);
         WRITELN('ERROS.......:',ERRO);
         GOTOXY(15,20);
       END;
       TECLA:=READKEY;
         GOTOXY(15,15);
         WRITELN('COMPILACAO PROCESSADA COM ERROS             ');
END.{ FIM }