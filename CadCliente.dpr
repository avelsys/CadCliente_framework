program CadCliente;

uses
  Vcl.Forms,
  CadCliente.view.Main in 'src\view\CadCliente.view.Main.pas' {frmViewMain},
  CadCliente.Dao.Model.Conexao in 'src\Dao\Model\CadCliente.Dao.Model.Conexao.pas',
  CadCliente.Dao.Controller.PoolConexao in 'src\Dao\Controller\CadCliente.Dao.Controller.PoolConexao.pas',
  CadCliente.Commons.Constantes in 'src\Commons\CadCliente.Commons.Constantes.pas',
  CadCliente.Dao.Controller.ConSqlServer in 'src\Dao\Controller\CadCliente.Dao.Controller.ConSqlServer.pas',
  CadCliente.View.Base in 'src\view\Base\CadCliente.View.Base.pas' {frnViewBase},
  CadCliente.View.BaseCadastro in 'src\view\Base\CadCliente.View.BaseCadastro.pas' {frnViewBaseCadastro},
  CadCliente.view.Cliente in 'src\view\CadCliente.view.Cliente.pas' {frnViewCliente},
  CadCliente.Model.Main.Interfaces in 'src\Model\CadCliente.Model.Main.Interfaces.pas',
  CadCliente.Controller.Main in 'src\Controller\CadCliente.Controller.Main.pas',
  CadCliente.Model.ViewBase.Interfaces in 'src\Model\CadCliente.Model.ViewBase.Interfaces.pas',
  CadCliente.Controller.BaseCadastro in 'src\Controller\CadCliente.Controller.BaseCadastro.pas',
  CadCliente.Commons.Atributos in 'src\Commons\CadCliente.Commons.Atributos.pas',
  CadCliente.DTO.Cliente in 'src\DTO\CadCliente.DTO.Cliente.pas',
  CadCliente.View.Frame.Base in 'src\view\Frame\Base\CadCliente.View.Frame.Base.pas' {fmeViewBase: TFrame},
  CadCliente.DTO.Telefone in 'src\DTO\CadCliente.DTO.Telefone.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
