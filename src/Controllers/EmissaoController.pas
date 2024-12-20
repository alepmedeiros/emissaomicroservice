unit EmissaoController;

interface

uses
  System.SysUtils,
  Horse,
  System.JSON,
  IdHTTP,
  EventDispatcher,
  DocumentoEmitidoHandler,
  DocumentoFiscalDTO,
  EmitirDocumentoFiscalUseCase,
  MockDocumentoFiscalREpository,
  DocumentoFiscal;

type
  TEmissaoController = class
  private
    FDispatcher: TEventDispatcher;
  protected
    function CheckAuthentication(Token: String): Boolean;

    procedure EmitirDocumento(Req: THorseRequest; Res: THorseResponse);
    procedure TesteActions(Req: THorseRequest; Res: THorseResponse);
  public
    class function New: TEmissaoController;

    procedure RegisterController;
  end;

implementation

{ TEmissaoController }

function TEmissaoController.CheckAuthentication(Token: String): Boolean;
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

procedure TEmissaoController.EmitirDocumento(Req: THorseRequest;
  Res: THorseResponse);
begin
  if not CheckAuthentication(Req.Headers['Authorization']) then
  begin
    REs.Status(401).Send('Token Inv�lido');
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

class function TEmissaoController.New: TEmissaoController;
begin
  Result := Self.Create;
end;

procedure TEmissaoController.RegisterController;
begin
  FDispatcher := TEventDispatcher.Create;

  var LDocumentoHandler := TDocumentoEmitidoHandler.Create;
  FDispatcher.Subscribe('DocumentoEmitido', LDocumentoHandler.Handle);

  THorse
    .Post('/emitir', EmitirDocumento)
    .Get('/action', TesteActions);
end;

procedure TEmissaoController.TesteActions(Req: THorseRequest;
  Res: THorseResponse);
begin
  Res.Status(200).Send('Teste da action funcionando');
end;

end.
