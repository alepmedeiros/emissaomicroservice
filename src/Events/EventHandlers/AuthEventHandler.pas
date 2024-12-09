unit AuthEventHandler;

interface

uses
  System.SysUtils;

type
  TAuthEventHandler = class
  public
    procedure Handle(Data: TObject);
  end;

implementation

{ TAuthEventHandler }

procedure TAuthEventHandler.Handle(Data: TObject);
begin
  writeln('Evento: Token valido para o usuário');
end;

end.
