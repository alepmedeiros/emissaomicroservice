unit DocumentoFiscalDTO;

interface

type
  TDocumentoFiscalDTO = class
  private
    FNumero: String;
    FDataEmissao: TDateTime;
    FValorTotal: Double;
  public
    property Numero: String read FNumero write FNumero;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

end.
