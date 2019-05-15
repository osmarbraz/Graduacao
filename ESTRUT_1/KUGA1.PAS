PROGRAM LISTA_DUPLAMENTE_ENCADEADA;
USES CRT;
TYPE
    AP_NO = ^NO;
    NO    =  RECORD
                   DADO : STRING; {dado da lista}
                   ESQ  : AP_NO;  {aponta para o elemento da esquerda}
                   DIR  : AP_NO;  {aponta para o elemento da direita}
             END;
    AP_DESCRITOR = ^DESCRITOR;
    DESCRITOR    = RECORD
                         I,F : AP_NO;{Aponta para o incio-I e fim-F da lista}
                         N   : INTEGER;  { numero de elementos na lista}
                         X   : AP_DESCRITOR;
                   END;
VAR
  LISTA,P  : Ap_No;
  D        : Ap_DEscritor;
  VALOR    : string;
  VAZIO    : BOOLEAN;
  TECLA    : char;
  CONT     : INTEGER;

{ Cria o descritor lista zerando o descritor e seus apontadores }
procedure criar (var d : AP_descritor);
begin
    new(d);
    d^.i :=nil;
    d^.n :=0;
    d^.f :=nil;
end;

{ insere um elemento a esquerda da lista }
procedure insere_esq (VAR d:ap_descritor; VAR valor:string);
var
  P, Q : ap_no;
begin
    new(p);
    p^.dado:=valor;
    P^.ESQ := NIL;
    if d^.n=0 then
       begin
          d^.i :=p;            {lista vazia}
          d^.f :=p;
          d^.n :=1;
          p^.DIR := nil;
       end
    else
        begin
             Q := D^.I;
             Q^.ESQ := P;
             p^.DIR:= Q;    {lista cheia}
             d^.i:=p;
             d^.n:=d^.n+1;
        end;
end;

{ insere um elemento a direita da lista }
procedure insere_dir (VAR d:ap_descritor; VAR valor:string);
var
   p,q: ap_no;
begin
     new(p);
     p^.dado:=valor;
     p^.DIR:=nil;
     if d^.n=0 then
        begin
             d^.i:=p;          {lista vazia}
             d^.f:=p;
             d^.n:=1;
             P^.ESQ := NIL;
        end
      else
          begin
               Q      := D^.F;        {lista cheia}
               D^.F   := P;
               Q^.DIR := P;
               P^.ESQ := Q;
               D^.N   := D^.N+1;
          end;
end;

{insere no meio sendo que se o meio e impar coloca a esquerda }
{se tem 3 elementos, sera inserido na segundao posicao e seguintes}
{movidos para frente}
{tendo assim 4 elementos}
procedure insere_meio (VAR d:ap_descritor; VAR valor:string);
var
   p,q,atual  : ap_no;
   x, cont    : integer;
begin
     new(p);
     p^.dado:=valor;
     if d^.n=0 then
        begin
             d^.i:=p;          {lista vazia}
             d^.f:=p;
             d^.n:=1;
             P^.ESQ := NIL;
             p^.DIR:=nil;
        end
      else
         if d^.n=1 then
            begin
            p^.DIR:=nil;
            Q      := D^.F;        {lista com um elemento}
            D^.F   := P;
            Q^.DIR := P;
            P^.ESQ := Q;
            D^.N   := D^.N+1;
            end
         else
            begin
              x := (d^.n div 2); {acha o meio}
              atual := d^.i;
              cont := 1;
              while cont <> x do
                    begin
                         atual := atual^.dir;
                         cont := cont + 1;
                    end;
             q := atual^.dir;
             p^.dir := q;
             p^.esq := atual;        {faz a inclusao}
             atual^.dir := p;
             q^.esq := p;
             D^.N   := D^.N+1;
          end;
end;

{ remove um elemento da esquerda da lista }
procedure remove_esq (VAR d:ap_descritor;VAR  valor:string);
var
  P,Q : ap_no;

begin
    if d^.n=0 then            {testa se esta vazia}
      begin
           VAZIO := TRUE;
           WRITELN;
           writeln('lista esta vazia');
           TECLA := READKEY;
      end
    else
       begin                   {lista nao vazia, remove}
           P      := D^.I;
           VALOR  := P^.DADO;
           D^.I   := p^.DIR;
           Q      := D^.I;
           Q^.ESQ := NIL;
           D^.N   := D^.N-1;

           dispose(p);

           if d^.n=0 then      {testa se a lista ficou vazia}
              begin
                   d^.f:=nil;
              end;
       end;
end;

{ remove um elemento da esquerda da lista }
procedure remove_dir (VAR d:ap_descritor; VAR valor:string);
var
  p,q   : ap_no;

begin
     if d^.n=0 then
        begin
             VAZIO := TRUE;
             WRITELN;
             writeln('lista esta vazia');
             TECLA := READKEY;
        end
      else
       BEGIN
         P := D^.F;
         VALOR := P^.DADO;
         if d^.n = 1 then
            begin
                 VALOR := P^.DADO;
                 d^.i  := nil;
                 d^.f  := nil;
                 d^.n  := 0;
            end
         else
            begin
                 Q      := P^.ESQ;
                 Q^.DIR := P^.DIR;
                 D^.F   := Q;
                 D^.N   := D^.N -1;

            end;
        DISPOSE(P);
       END;
end;

(************ PROGRAMA PRINCIPAL ****************)
begin
     clrscr;
     criar( d );
     repeat
        VAZIO := FALSE;
        write  ('1 - Insere direita  ');
        write  ('2 - Insere esquerda ');
        writeln('3 - Remove esquerda ');
        write  ('4 - Remove direita  ');
        write  ('5 - Insere no meio  ');
        writeln('ESC - Sai para S.O. ');
        writeln;
        write('Qual a opcao (1-2-3-4-5) => ');
        tecla := readkey;
        case (tecla) of
          '1'  :  begin
                       write('digite o valor :');
                       readln(valor);
                       insere_dir ( d ,valor);
                  end;
          '2'  :  BEGIN
                       write('digite o valor :');
                       readln(valor);
                       insere_esq ( d ,valor);
                  END;
          '3'  :  BEGIN
                       remove_esq ( d ,valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA ESQUERDA ',VALOR);
                  END;
          '4'  :  BEGIN
                       remove_dir ( d ,valor);
                       IF VAZIO <> TRUE THEN
                          WRITELN('VALOR REMOVIDO DA DIREITA ',VALOR);
                  END;
          '5'  :  BEGIN
                       write('digite o valor :');
                       readln(valor);
                       insere_meio ( d ,valor);
                  END;
        end;
        writeln('VALOR DO DESCRITOR ',d^.n);
        IF (VAZIO <> TRUE) AND (D^.N <> 0) THEN
          BEGIN
               P := D^.I;
               CONT := 1;
               WRITELN;
               WHILE (P^.DIR <> NIL) DO
                     BEGIN
                          WRITE(' ELE [',CONT,']= ',P^.DADO);
                          P := P^.DIR;
                          CONT := CONT + 1;
                     END;
               WRITE(' ELE [',CONT,']= ',P^.DADO);
          END;
        TECLA := READKEY;
        WRITELN;

until tecla = #27;
end.