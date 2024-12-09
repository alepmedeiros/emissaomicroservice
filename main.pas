unit main;

interface

uses
  System.SysUtils,
  System.JSON,
  IdHTTP,
  Horse,
  Horse.Jhonson,
  EmissaoController;

type
  TMain = class
  private
  public
    class function New: TMain;
    procedure Registering;
  end;

implementation


class function TMain.New: TMain;
begin
  Result := SElf.Create;
end;

procedure TMain.Registering;
begin
  THorse
    .Use(Jhonson);

  TEmissaoController.New.RegisterController;

  THorse.Listen(9001, procedure
  begin
    writeln(Format('Servidor rodando %s:%d', [THorse.Host, THorse.Port]));
  end);
end;

end.
