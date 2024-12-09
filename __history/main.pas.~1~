unit main;

interface

uses
  System.SysUtils,
  System.JSON,
  IdHTTP,
  Horse,
  Horse.Jhonson,
  EmitirDocumentoFiscalUseCase,
  MockDocumentoFiscalREpository,
  DocumentoFiscal;

type
  TMain = class
  private
  protected
    function CheckAuthentication(Token: String): Boolean;

    procedure Emitir(Req: THorseRequest; Res: THorseResponse);
  public
    class function New: TMain;
    procedure Registering;
  end;

implementation

{ TMain }

function TMain.CheckAuthentication(Token: String): Boolean;
begin
  var LHTTP := TIdHTTP.Create(nil);
  try
    LHTTP.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + Token;
    var LResponse := LHTTP.Get('http://localhost:9002/checktoken');
    Result := LResponse = 'Valid';
  finally
    LHTTP.Free;
  end;
end;

procedure TMain.Emitir(Req: THorseRequest; Res: THorseResponse);
begin
  if not CheckAuthentication(Req.Headers['Authorization']) then
  begin
    REs.Status(401).Send('Token Inválido');
    Exit;
  end;

  var LDocumento := TDocumentoFiscal.Create(
    Req.Body<TJSONObject>.GetValue<String>('numero'),
    Req.Body<TJSONObject>.GetValue<Double>('valorTotal'));

  var LRepository := TMockDocumentoFiscalRespository.Create;

  var LUseCase := TEmitirDocumentoFiscalUseCase.Create(LRepository);
  try
    if not LUseCase.Execute(LDocumento) then
    begin
      Res.Status(400).Send('Falha ao emitir o documento');
      exit;
    end;

    Res.Status(200).Send('Documento emitido com sucesso');
  finally
    LDocumento.Free;
  end;
end;

class function TMain.New: TMain;
begin
  Result := SElf.Create;
end;

procedure TMain.Registering;
begin
  THorse
    .Use(Jhonson);

  THorse
    .Post('/emitir', Emitir);

  THorse.Listen(9001, procedure
  begin
    writeln(Format('Servidor rodando %s:%d', [THorse.Host, THorse.Port]));
  end);
end;

end.
