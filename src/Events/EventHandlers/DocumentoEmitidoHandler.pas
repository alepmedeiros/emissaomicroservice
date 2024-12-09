unit DocumentoEmitidoHandler;

interface

uses
  System.SysUtils;

type
  TDocumentoEmitidoHandler = class
  private
  public
    procedure Handle(Data: TObject);
  end;

implementation

{ TDocumentoEmitidoHandler }

procedure TDocumentoEmitidoHandler.Handle(Data: TObject);
begin
  writeln('Evento: Documento Emitido processado para ', Data.ClassName);
end;

end.
