unit EmitirDocumentoFiscalUseCase;

interface

uses
  DocumentoFiscal, DocumentoFiscalREpository.interfaces;

type
  TEmitirDocumentoFiscalUseCase = class
  private
    FRepository: IDocumentoFiscalRepository;
  public
    constructor Create(aRepository: IDocumentoFiscalRepository);
    function Execute(Documento: TDocumentoFiscal): Boolean;
  end;

implementation

{ TEmitirDocumentoFiscalUseCase }

constructor TEmitirDocumentoFiscalUseCase.Create(
  aRepository: IDocumentoFiscalRepository);
begin
  FRepository := aRepository;
end;

function TEmitirDocumentoFiscalUseCase.Execute(
  Documento: TDocumentoFiscal): Boolean;
begin
  if Documento.PodeEmitir then
    Result := FRepository.Salvar(Documento)
  else
    Result := False;
end;

end.
