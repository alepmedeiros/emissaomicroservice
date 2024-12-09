unit EmissaoController;

interface

uses
  Horse,
  System.JSON,
  EventDispatcher,
  DocumentoEmitidoHandler,
  DocumentoFiscalDTO;

type
  TEmissaoController = class
  private
    FDispatcher: TEventDispatcher;
  protected
    procedure EmitirDocumento(Req: THorseRequest; Res: THorseResponse);
    procedure TesteActions(Req: THorseRequest; Res: THorseResponse);
  public
    class function New: TEmissaoController;

    procedure RegisterController;
  end;

implementation

{ TEmissaoController }

procedure TEmissaoController.EmitirDocumento(Req: THorseRequest;
  Res: THorseResponse);
begin
  var LDocumento := TDocumentoFiscalDTO.Create;
  try
    LDocumento.Numero := Req.Body<TJSONObject>.GetValue<String>('numero');
    LDocumento.ValorTotal := Req.Body<TJSONObject>.GetValue<Double>('valorTotal');

    // Despachar evento de documento emitido
    FDispatcher.Dispatch('DocumentoEmitido', LDocumento);
    Res.Status(200).Send('Documento emitido e evento disparado');
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
    .Get('/awsteste', TesteActions);
end;

procedure TEmissaoController.TesteActions(Req: THorseRequest;
  Res: THorseResponse);
begin
  Res.Status(200).Send('Teste de validação remota1');
end;

end.
