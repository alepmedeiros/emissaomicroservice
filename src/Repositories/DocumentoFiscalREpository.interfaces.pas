unit DocumentoFiscalREpository.interfaces;

interface

uses DocumentoFiscal;

type
  IDocumentoFiscalRepository = interface
    ['{B9E0203E-238E-4356-9A59-85B0629F0E3A}']
    function Salvar(Documento: TDocumentoFiscal): Boolean;
    function Buscar(NUmero: String): TDocumentoFiscal;
  end;

implementation

end.
