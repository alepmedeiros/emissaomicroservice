program EmissaoMicroservice;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  main in 'main.pas',
  DocumentoFiscal in 'src\Entities\DocumentoFiscal.pas',
  DocumentoFiscalDTO in 'src\Entities\DocumentoFiscalDTO.pas',
  DocumentoFiscalREpository.interfaces in 'src\Repositories\DocumentoFiscalREpository.interfaces.pas',
  MockDocumentoFiscalREpository in 'src\Repositories\MockDocumentoFiscalREpository.pas',
  EmitirDocumentoFiscalUseCase in 'src\UseCases\EmitirDocumentoFiscalUseCase.pas',
  EventDispatcher in '..\Events\EventDispatcher.pas',
  DocumentoEmitidoHandler in '..\Events\EventHandlers\DocumentoEmitidoHandler.pas',
  EmissaoController in 'src\Controllers\EmissaoController.pas';

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  TMain.New.Registering;
end.
