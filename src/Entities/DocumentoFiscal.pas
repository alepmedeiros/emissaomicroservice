unit DocumentoFiscal;

interface

type
  TDocumentoFiscal = class
  private
    FNumero: String;
    FValorTotal: Double;
    { private declarations }
  public
    constructor Create(ANumero: String; AValorTotal: Double);
    function PodeEmitir: Boolean;

    property Numero: String read FNumero write FNumero;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

{ TDocumentoFiscal }

constructor TDocumentoFiscal.Create(ANumero: String; AValorTotal: Double);
begin
  FNumero := ANumero;
  FValorTotal := AValorTotal;
end;

function TDocumentoFiscal.PodeEmitir: Boolean;
begin
  Result := (FNumero <> '') and (FValorTotal > 0);
end;

end.
